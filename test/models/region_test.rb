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

require 'test_helper'

class RegionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
