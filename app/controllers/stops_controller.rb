class StopsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:new, :show, :create, :edit, :update, :destroy]
  before_action :set_stop, only: [:show, :edit, :update, :destroy]
  
  def new
    @stop = @trip.stops.new(stop_new_params)
    @country
  end

  def show
  end

  def create
    @stop = @trip.stops.new(stop_create_update_params)

    if @stop.save
      flash[:notice] = "Stop created."
    else
      flash[:alert] = "Stop creation failed."
    end

    redirect_to trip_stop_path(@trip, @stop)
  end

  def edit

  end

  def update
    if @stop.update(stop_create_update_params)
      flash[:notice] = "Stop updated."
    else
      render 'edit'
    end

    redirect_to trip_stop_path(@trip, @stop)

  end

  def destroy
    @trip.destroy
    flash[:notice] = "Trip deleted."
    redirect_to @trip
  end


  private
  
  def stop_new_params
    params.permit(:city_id, :country_id, :region_id)
  end

  def stop_create_update_params
    params.require(:stop).permit(:city_id, :country_id, :region_id, :begin_date, :end_date)
  end
  
  def set_trip    
    @trip = Trip.friendly.find(params[:trip_id])
  end
  
  def set_stop
    @stop = Stop.find(params[:id])
  end

end
