# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  country_id :integer          not null
#  name       :string(45)       not null
#  code       :string(8)        not null
#  adm1code   :string(4)        not null
#

class Region < ActiveRecord::Base
	has_many :cities
	belongs_to :country

	include PgSearch
	pg_search_scope :search, against: :name

	def self.text_search(query)
		search(query)
	end
end
