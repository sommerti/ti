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
#  description :text
#  slug        :string
#  user_id     :integer
#  is_private  :boolean
#

class Trip < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged

	# Try building a slug based on the following fields in
	# increasing order of specificity.
	def slug_candidates
	[
	  :name,
	  [:name, :begin_date],
	  [:name, :begin_date, :end_date]
	]
	end



  	belongs_to :user

  	validates :name, presence: true

end
