class Person < ApplicationRecord
	has_many :person_locations
	has_many :locations, through: :person_locations
    has_many :person_affiliations
	has_many :affiliations, through: :person_affiliations
	validates :first_name, presence: true
	validates :last_name, allow_blank: true, length: { maximum: 50 }
	validates :weapon, allow_blank: true, length: { maximum: 50 }
	validates :vehicle, allow_blank: true ,length: { maximum: 50 }
	validates :species, presence: true
	validates :gender, presence: true


end
