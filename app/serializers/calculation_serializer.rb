class CalculationSerializer < ActiveModel::Serializer
  attributes :id, :operation, :result, :count
  def id
    object.id.to_s
  end

  def result
    result = object.result
    if (result - result.to_i).abs < 1e-9
      result.to_i 
    else
      result.round(9)
    end
  end
end
