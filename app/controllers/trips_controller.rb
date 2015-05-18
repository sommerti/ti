class TripsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :format_params, only: [:create, :update]


  def index
    @trips = Trip.where(is_private: false).order("CREATED_AT DESC")
    # @trips = Trip.order("CREATED_AT DESC")
  end

  def show

  end

  def new
    @trip = current_user.trips.new
  end

  def create
    @trip = current_user.trips.new(@formatted_params)

    if @trip.save
      flash[:notice] = "Trip created."
      redirect_to @trip
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @trip.update(@formatted_params)
      flash[:notice] = "Trip updated."
      redirect_to @trip
    else
      render 'new'
    end
  end

  def destroy
    @trip.destroy
    flash[:notice] = "Trip deleted."
    redirect_to trip_path
  end


  private
  def trip_params
    params.require(:trip).permit(:name, :begin_date, :end_date, :is_private)
  end
  def set_trip    
    @trip = Trip.friendly.find(params[:id])
  end
  def format_params
    @formatted_params = trip_params
    @formatted_params[:name].downcase!
    @formatted_params[:name] = @formatted_params[:name].split(' ').map(&:capitalize).join(' ')

    # if using auto_html gem
    # @temp[:description] = auto_html(@temp[:description]){ simple_format; link(target: 'blank') }
    # @temp[:description] = @temp[:description][3..(@temp[:description].length-5)] if !@temp[:description].empty?
  end

end
