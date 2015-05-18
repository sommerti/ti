# == Schema Information
#
# Table name: countries
#
#  id                   :integer          not null, primary key
#  name                 :string(50)       not null
#  fips104              :string(2)        not null
#  iso2                 :string(2)        not null
#  iso3                 :string(3)        not null
#  ison                 :string(4)        not null
#  internet             :string(2)        not null
#  capital              :string(25)
#  map_reference        :string(50)
#  nationality_singular :string(35)
#  nationality_plural   :string(35)
#  currency             :string(30)
#  currency_code        :string(3)
#  population           :integer
#  title                :string(50)
#  comment              :string(255)
#

class Country < ActiveRecord::Base
	has_many :regions
	has_many :cities

	include PgSearch
	multisearchable against: :name
end
