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
  	belongs_to :user
  	has_many :stops, dependent: :destroy
  	has_many :comments, dependent: :destroy

  	validates :name, presence: true

	scope :is_private, -> { where(is_private: true) }
	scope :is_public, -> { where(is_private: false) }
	scope :by_user_id, -> user_id { where(user_id: user_id) }
	scope :by_travel_date, -> begin_date, end_date { where("begin_date = ? AND end_date = ?", begin_date, end_date) }

  	# gem friendly_id
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged
	def slug_candidates
	[
	  :name,
	  [:name, :begin_date],
	  [:name, :begin_date, :end_date]
	]
	end

	include PgSearch

	pg_search_scope :search, against: [:name, :description], 
					associated_against: { stops: :description }, 
					using: {tsearch: {dictionary: "english"}}

	def self.text_search(query)
		search(query)
	end
		
end
