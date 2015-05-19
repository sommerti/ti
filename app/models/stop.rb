# == Schema Information
#
# Table name: stops
#
#  id         :integer          not null, primary key
#  country_id :integer
#  region_id  :integer
#  city_id    :integer
#  begin_date :date
#  end_date   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Stop < ActiveRecord::Base
  belongs_to :country
  belongs_to :region
  belongs_to :city
  belongs_to :trip
end
