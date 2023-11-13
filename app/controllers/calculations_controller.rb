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
            render json: { error:  {message: e.message} }, status: :bad_request
        end
    end

    private

    def get_calculation_service
        parameters = calculation_params
        @calculation_service = CalculationService.new(parameters[:operand1], parameters[:operand2], parameters[:operator])
    end

    def calculation_params
        params.require(:calculation).permit(:operand1, :operand2, :operator)
    end
end
