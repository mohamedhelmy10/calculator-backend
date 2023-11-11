require 'rails_helper'

RSpec.describe Calculation, type: :model do
    it 'is valid with valid attributes' do
      valid_calculation = FactoryBot.build(:calculation)
      expect(valid_calculation).to be_valid
    end
  
    it 'is not valid without an operation attribute' do
      invalid_calculation =  FactoryBot.build(:calculation, operation: nil)
      expect(invalid_calculation).not_to be_valid
      expect(invalid_calculation.errors[:operation]).to include("can't be blank")
    end

    it 'is not valid for redundunt operation attribute' do
      valid_calculation = FactoryBot.create(:calculation)
      # The below calculation have the same operation value 5+5
      redundunt_calculation =  FactoryBot.build(:calculation)
      expect(redundunt_calculation).not_to be_valid
      expect(redundunt_calculation.errors[:operation]).to include('is already taken')
    end
end
