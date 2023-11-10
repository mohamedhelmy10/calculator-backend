class Calculation
  include Mongoid::Document
  include Mongoid::Timestamps
  field :operation, type: String
  field :result, type: Integer, default: 0
  field :count, type: Integer, default: 1
  index({ operation: 1 }, { unique: true })
end
