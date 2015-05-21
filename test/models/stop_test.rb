# == Schema Information
#
# Table name: stops
#
#  id          :integer          not null, primary key
#  country_id  :integer
#  region_id   :integer
#  city_id     :integer
#  begin_date  :date
#  end_date    :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  trip_id     :integer
#  position    :integer
#  description :text
#

require 'test_helper'

class StopTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
