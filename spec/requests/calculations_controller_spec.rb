require 'rails_helper'

RSpec.describe "CalculationsControllers", type: :request do
  describe "Valid requests to be calculated" do
    it 'returns a successful response for sum' do
      calculation_params = { operand1: 5, operand2: 5, operator: "+" }
      expect {
        post '/calculations/calculate', params: calculation_params, as: :json
      }.to change(Calculation, :count).by(1)
      calculation = Calculation.last
      expect(calculation.result).to eq(10)
    end

    it 'returns a successful response for difference' do
      calculation_params = { operand1: 5, operand2: 10, operator: "-" }
      expect {
        post '/calculations/calculate', params: calculation_params, as: :json
      }.to change(Calculation, :count).by(1)
      calculation = Calculation.last
      expect(calculation.result).to eq(-5)
    end

    it 'returns a successful response for multiplication' do
      calculation_params = { operand1: 5, operand2: 5, operator: "*" }
      expect {
        post '/calculations/calculate', params: calculation_params, as: :json
      }.to change(Calculation, :count).by(1)
      calculation = Calculation.last
      expect(calculation.result).to eq(25)
    end

    it 'returns a successful response for division' do
      calculation_params = { operand1: 5, operand2: 5, operator: "/" }
      expect {
        post '/calculations/calculate', params: calculation_params, as: :json
      }.to change(Calculation, :count).by(1)
      calculation = Calculation.last
      expect(calculation.result).to eq(1)
    end

    it 'Only increase the count without adding new record as the calculation already exist' do
      # Create calculation with operation 5+5
      calculation = FactoryBot.create(:calculation)
      # Send a request to calculate 5+5
      calculation_params = { operand1: 5, operand2: 5, operator: "+" }
      expect {
        post '/calculations/calculate', params: calculation_params, as: :json
      }.to change(Calculation, :count).by(0)
      expect(response).to have_http_status(:created)
    end
  end

  describe "Inalid requests to be calculated" do
    it 'returns Invalid calculation because of negative number' do
      calculation_params = { operand1: -5, operand2: 5, operator: "+" }
      expect {
        post '/calculations/calculate', params: calculation_params, as: :json
      }.to change(Calculation, :count).by(0)
      expect(response).to have_http_status(:bad_request)
    end

    it 'returns Invalid calculation as an operand greater than 99' do
      calculation_params = { operand1: 5, operand2: 100, operator: "+" }
      expect {
        post '/calculations/calculate', params: calculation_params, as: :json
      }.to change(Calculation, :count).by(0)
      expect(response).to have_http_status(:bad_request)
    end

    it 'returns Invalid calculation because of invalid operator' do
      calculation_params = { operand1: -5, operand2: 5, operator: "%" }
      expect {
        post '/calculations/calculate', params: calculation_params, as: :json
      }.to change(Calculation, :count).by(0)
      expect(response).to have_http_status(:bad_request)
    end

    it 'returns Invalid calculation because of more than one charater operator' do
      calculation_params = { operand1: 5, operand2: 100, operator: "++" }
      expect {
        post '/calculations/calculate', params: calculation_params, as: :json
      }.to change(Calculation, :count).by(0)
      expect(response).to have_http_status(:bad_request)
    end

    it 'returns Invalid calculation because of division by zero' do
      calculation_params = { operand1: 5, operand2: 0, operator: "/" }
      expect {
        post '/calculations/calculate', params: calculation_params, as: :json
      }.to change(Calculation, :count).by(0)
      expect(response).to have_http_status(:bad_request)
    end
  end
end
