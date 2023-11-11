class Calculation
  include Mongoid::Document
  include Mongoid::Timestamps
  field :operation, type: String
  field :result, type: Float, default: 0
  field :count, type: Integer, default: 1
  index({ operation: 1 }, { unique: true })
  validates :operation, presence: true, uniqueness: true
end
