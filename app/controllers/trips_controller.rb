class TripsController < ApplicationController
  before_action :authenticate_user!, except: [:trip_library, :show, :big_map]
  before_action :set_trip, only: [:show, :big_map, :edit, :update, :destroy, :clone_trip]
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

      # add city results onto a google map; only city has latitude/longitude data
      @hash_city_results = Gmaps4rails.build_markers(@city_results) do |city, marker|
        marker.lat city.latitude
        marker.lng city.longitude
        marker.infowindow  "<div style='width:200px;height:100%;'>
                              #{city.name}&nbsp;&nbsp;
                              <a href='#{@trip.id}/stops/new?country_id=#{city.country.id}&region_id=#{city.region.id}&city_id=#{city.id}
                              '><strong>Add To Trip</strong></a></div>"
      end


      # rank trips according to creation date
      @trip_stops_ranked = @trip.stops.order(begin_date: :asc, created_at: :asc)


      # add trip's stops onto a google map; only city has latitude/longitude data
      @hash_trip_stops = Gmaps4rails.build_markers(@trip_stops_ranked) do |stop, marker|
        marker.lat stop.city.latitude
        marker.lng stop.city.longitude
        marker.infowindow "<div style='width:200px;height:100%;'>#{stop.city.name}</div>"
      end
      
  end

  def big_map
      # rank trips according to creation date
      @trip_stops_ranked = @trip.stops.order(begin_date: :asc, created_at: :asc)

      # add trip's stops onto a google map; only city has latitude/longitude data
      @hash_big_map = Gmaps4rails.build_markers(@trip_stops_ranked) do |stop, marker|
        marker.lat stop.city.latitude
        marker.lng stop.city.longitude
        marker.infowindow "<div style='width:200px;height:100%;'>#{stop.city.name}</div>"
      end
  end

  def new
    @trip = current_user.trips.new
  end

  def create
    authorize! :create, @trip

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
    authorize! :update, @trip

    @trip.slug = nil
    if @trip.update(@formatted_params)
      flash[:notice] = "Trip updated."
      redirect_to @trip
    else
      render 'edit'
    end
  end

  def destroy
    authorize! :destroy, @trip

    @trip.destroy
    flash[:notice] = "Trip deleted."
    redirect_to my_trips_path
  end

  def clone_trip
      @cloned_trip = @trip.deep_clone include: :stops
      @cloned_trip.name = "#{@trip.name} (CLONED)"
      @cloned_trip.user = current_user
      @cloned_trip.save

      redirect_to my_trips_path
  end


  def my_trips
    @trips = current_user.trips

  end

  def trip_library
    @public_trips = Trip.is_public    

    if !params[:search].nil?
      @trip_results = Trip.text_search(params[:search]) 
    end
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
