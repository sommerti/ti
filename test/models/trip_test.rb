# == Schema Information
#
# Table name: trips
#
#  id         :integer          not null, primary key
#  name       :string
#  begin_date :date
#  end_date   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  privacy    :string
#

require 'test_helper'

class TripTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
