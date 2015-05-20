# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  firstname              :string
#  lastname               :string
#  country                :string
#  city                   :string
#  age                    :integer
#  gender                 :string
#  role                   :string
#  slug                   :string
#  description            :text
#

class User < ActiveRecord::Base
  	# Include default devise modules. Others available are:
 	 # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

 	has_many :trips, dependent: :destroy

 	def fullname
 		"#{self.firstname} #{self.lastname}"
 	end

  	# gem friendly_id
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged
	def slug_candidates
	[
	  [:firstname, :lastname],
	  [:firstname, :lastname, :country],
	  [:firstname, :lastname, :country, :city],
	]
	end
	
end
