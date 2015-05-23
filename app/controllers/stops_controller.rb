class StopsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:new, :create, :edit, :update, :destroy, :search_stop]
  before_action :set_stop, only: [:edit, :update, :destroy]
  
  def new
    @stop = @trip.stops.new(stop_new_params)
  end

  def create
    authorize! :create, @stop

    @stop = @trip.stops.new(stop_create_update_params)

    if @trip.user == current_user and @stop.save
      flash[:notice] = "Stop added to trip."
    else
      flash[:alert] = "Stop creation failed."
    end

    # if using modal pop-up
    if session[:search_stop_switch] == "on"
      session[:search_stop_switch] = "off"
      redirect_to trip_search_stop_path(@trip)  
    else
      redirect_to @trip
    end
  
  end

  def edit

  end

  def update
    authorize! :update, @stop

    if @stop.update(stop_create_update_params)
      flash[:notice] = "Stop updated."
    else
      render 'edit'
    end

    redirect_to @trip

  end

  def destroy
    authorize! :destroy, @stop

    @stop.destroy
    flash[:notice] = "Stop deleted."
    redirect_to @trip
  end


  def search_stop
      # user searches for a destination, result could be country/region/city
      if !params[:search].nil?
        @destination = params[:search]
        @country_results = Country.text_search(@destination) 
        @region_results = Region.text_search(@destination) 
        @city_results = City.text_search(@destination) 
      end

      # add city results onto a google map; only city has latitude/longitude data
      @hash_city_results = Gmaps4rails.build_markers(@city_results) do |city, marker|
        marker.lat city.latitude
        marker.lng city.longitude
        marker.infowindow  "<div style='width:200px;height:100%;'>
                              #{city.name}&nbsp;&nbsp;
                              <a href='stops/new?country_id=#{city.country.id}&region_id=#{city.region.id}&city_id=#{city.id}
                              '><strong>Add To Trip</strong></a></div>"
      end
          
  end

  private
  
  def stop_new_params
    params.permit(:city_id, :country_id, :region_id)
  end

  def stop_create_update_params
    params.require(:stop).permit(:city_id, :country_id, :region_id, :begin_date, :end_date, :description)
  end
  
  def set_trip    
    @trip = Trip.friendly.find(params[:trip_id])
  end
  
  def set_stop
    @stop = Stop.find(params[:id])
  end

end
