class Article < ApplicationRecord
	#use the dependent option of an association to delete its 
	# associated comments, when delete an article
	has_many :comments, dependent: :destroy
	#This class inherits from ActiveRecord::Base, supply many functions:
	# database CRUD (Create, Read, Update, Destroy) operations, 
	# data validation, as well as sophisticated search support 
	# and the ability to relate multiple models to one another.
    validates :title, presence: true,
                      length: { minimum: 2 }
end
