class Question < ActiveRecord::Base
  belongs_to :quiz
  validates_presence_of :question, :option_a, :option_b
end
