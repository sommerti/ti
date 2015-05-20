class TripsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :format_params, only: [:create, :update]

  def index
    @public_trips = Trip.is_public
    @private_trips = Trip.is_private
  end

  def show
      # user searches for a destination, result could be country/region/city
      if !params[:search].nil?
        @destination = params[:search]
        @country_results = Country.text_search(@destination) 
        @region_results = Region.text_search(@destination) 
        @city_results = City.text_search(@destination) 
      end

      # add trip's stops onto a google map; only city has latitude/longitude data
      @hash_city_results = Gmaps4rails.build_markers(@city_results) do |city, marker|
        marker.lat city.latitude
        marker.lng city.longitude
        marker.infowindow  "<div style='width:200px;height:100%;'>
                              #{city.name}&nbsp;&nbsp;
                              <a href='#{@trip.id}/stops/new?country_id=#{city.country.id}&region_id=#{city.region.id}&city_id=#{city.id}
                              '><strong>Add To Trip</strong></a></div>"
      end

      # add trip's stops onto a google map; only city has latitude/longitude data
      @hash_trip_stops = Gmaps4rails.build_markers(@trip.stops) do |stop, marker|
        marker.lat stop.city.latitude
        marker.lng stop.city.longitude
        marker.infowindow "<div style='width:200px;height:100%;'>#{stop.city.name}</div>"
      end
      
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
    @trip.slug = nil
    if @trip.update(@formatted_params)
      flash[:notice] = "Trip updated."
      redirect_to @trip
    else
      render 'edit'
    end
  end

  def destroy
    @trip.destroy
    flash[:notice] = "Trip deleted."
    redirect_to trips_path
  end

  def mytrips
    @trips = current_user.trips
  end

  private
  
  def trip_params
    params.require(:trip).permit(:name, :begin_date, :end_date, :is_private, :description)
  end

  def set_trip    
    @trip = Trip.friendly.find(params[:id])
  end
  
  def format_params
    @formatted_params = trip_params
    
    # if capitalizing every word
    # @formatted_params[:name] = capitalize_input(@formatted_params[:name])

    # if using auto_html gem
    # @formatted_params[:description] = auto_html(@formatted_params[:description]){ simple_format; link(target: 'blank') }
    # @formatted_params[:description] = @formatted_params[:description][3..(@formatted_params[:description].length-5)] if !@formatted_params[:description].empty?
  end

end
