class Category < ApplicationRecord
    has_many :questions, dependent: :delete_all

    validates :name, presence: true, uniqueness: true
end
