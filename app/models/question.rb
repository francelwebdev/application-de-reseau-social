class Question < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :answers, dependent: :delete_all

    validates :title, presence: true

    is_impressionable

    # include PublicActivity::Model
    # tracked only: [:create], owner: Proc.new{|controller, model| controller.current_user}
end
