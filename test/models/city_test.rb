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

require 'test_helper'

class CityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
