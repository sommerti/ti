class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:new, :create, :edit, :update, :destroy, :search_location]
  before_action :set_location, only: [:edit, :update, :destroy]

  def new
    @location = @trip.locations.new(location_new_params)
  end

  def create
    authorize! :create, @location

    @location = @trip.locations.new(location_create_update_params)

    if @trip.user == current_user and @location.save
      flash[:notice] = "location added to trip."
    else
      flash[:alert] = "location creation failed."
    end

    # if using modal pop-up
    if session[:search_location_switch] == "on"
      session[:search_location_switch] = "off"
      redirect_to trip_search_location_path(@trip)  
    else
      redirect_to @trip
    end
  
  end

  def edit

  end

  def update
    authorize! :update, @location

    if @location.update(location_create_update_params)
      flash[:notice] = "location updated."
    else
      render 'edit'
    end

    redirect_to @trip

  end

  def destroy
    authorize! :destroy, @location

    @location.destroy
    flash[:notice] = "location deleted."
    redirect_to @trip
  end

  def search_location
    if !params[:search].nil?
      @temp_location = Location.new(name: params[:search])
    end
    
    # add "agnostic location" onto a google map, if latitude/longitude data exist
    @hash_temp_location = Gmaps4rails.build_markers(@temp_location) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.infowindow  "<div style='width:200px;height:100%;'>
                            #{location.name}</div>"
    end
  end

  private
  
  def location_new_params
    params.permit(:name)
  end

  def location_create_update_params
    params.require(:location).permit(:name :begin_date, :end_date, :description)
  end
  
  def set_trip    
    @trip = Trip.friendly.find(params[:trip_id])
  end
  
  def set_location
    @location = location.find(params[:id])
  end

end
