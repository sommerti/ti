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
#  provider               :string
#  uid                    :string
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#

class User < ActiveRecord::Base
  	# Include default devise modules. Others available are:
 	 # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable, :omniauthable,
        :recoverable, :rememberable, :trackable, :validatable

 	has_many :trips, dependent: :destroy
 	has_many :comments, dependent: :destroy

	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, 
								default_url: ":style/default-avatar.jpg"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
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

	def self.from_omniauth(auth)
		#where(auth.slice(:provider, :uid)).first_or_create do |user|
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
				user.email = auth.info.email
	    user.provider = auth.provider
				user.uid = auth.uid
				#user.username = auth.info.nickname
	    #user.build_profile.avatar_url = auth.info.image
		end
	end

	def self.new_with_session(params, session)
		if session["devise.user_attributes"]
			new(session["devise.user_attributes"], without_protection: true) do |user|
				user.attributes = params
				user.valid?
			end
		else
			super
		end
	end

	def password_required?
		super && provider.blank?
	end

	def update_with_password(params, *options)
		if encrypted_password.blank?
			update_attributes(params, *options)
		else
			super
		end
		
	end
	
end
