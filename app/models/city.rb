# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  country_id :integer          not null
#  region_id  :integer          not null
#  name       :string(45)       not null
#  latitude   :float            not null
#  longitude  :float            not null
#  timezone   :string(10)       not null
#  dma_id     :integer
#  code       :string(4)
#

class City < ActiveRecord::Base
	belongs_to :region
	belongs_to :country
	has_many :stops

	include PgSearch
	pg_search_scope :search, against: :name

	def self.text_search(query)
		search(query)
	end

end
