class TripsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_trip, only: [:show, :edit, :update, :destroy]




  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private
  def trip_params
    params.require(:trip).permit(:name, :begin_date, :end_date, :privacy)
  end
  def set_trip    
    @trip = Trip.find(params[:id])
  end
  def set_params
    @temp = trip_params
    @temp[:name].downcase!
    @temp[:name] = @temp[:name].split(' ').map(&:capitalize).join(' ')

    @temp[:description] = auto_html(@temp[:description]){ simple_format; link(:target => 'blank') }
    @temp[:description] = @temp[:description][3..(@temp[:description].length-5)] if !@temp[:description].empty?
  end
end
