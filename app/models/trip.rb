# == Schema Information
#
# Table name: trips
#
#  id          :integer          not null, primary key
#  name        :string
#  begin_date  :date
#  end_date    :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  privacy     :string
#  description :text
#

class Trip < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :name, use: :slugged



end
