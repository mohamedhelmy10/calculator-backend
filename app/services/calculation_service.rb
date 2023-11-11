class CalculationService
    def initialize(operand1, operand2, operator)
      @operand1 = operand1
      @operand2 = operand2
      @operator = operator
    end

    def validate_calculation
        raise StandardError, "Invalid calculation" unless (LABELS.include?(@operator) && NUMBER_RANGE.include?(@operand1) && NUMBER_RANGE.include?(@operand2))
        check_zero_division
    end

    def find_old_calculation
        operation = "#{@operand1}#{@operator}#{@operand2}"
        Calculation.find_by(operation: operation)
    end
  
    def calculate
        operation = "#{@operand1.to_f}#{@operator}#{@operand2}"
        eval(operation)
    end

    def create_calculation(result)
      operation = "#{@operand1}#{@operator}#{@operand2}"
      Calculation.create(operation: operation, result: result)
    end

    private

    def check_zero_division
        raise ZeroDivisionError, "Cannot divide by zero" if @operand2 == 0 && @operator =="/"
    end
end
  