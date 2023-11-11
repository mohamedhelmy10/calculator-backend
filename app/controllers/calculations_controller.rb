class CalculationsController < ApplicationController
    before_action :get_calculation_service

    def calculate
        begin
            @calculation_service.validate_calculation
            @calculation = @calculation_service.find_old_calculation
            if @calculation.nil?
                result = @calculation_service.calculate
                @calculation = @calculation_service.create_calculation(result)
            else
                @calculation.update(count: @calculation.count + 1)
            end
            render json: @calculation, status: :created
        rescue StandardError => e
            render json: { error:  e.message }, status: :bad_request
        end
    end

    private

    def get_calculation_service
        @calculation_service = CalculationService.new(params[:operand1], params[:operand2], params[:operator])
    end
end
