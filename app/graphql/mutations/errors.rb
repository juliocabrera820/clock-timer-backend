module Mutations
  module Errors
    class InvalidCheckedInError < GraphQL::ExecutionError
      def initialize
        super('El empleado llegó tarde')
      end
    end

    class AbsenceError < GraphQL::ExecutionError
      def initialize
        super('El empleado tiene una falta hoy')
      end
    end

    class WithoutCheckIn < GraphQL::ExecutionError
      def initialize
        super('El empleado no hizo check in')
      end
    end

    class CheckedInAgainError < GraphQL::ExecutionError
      def initialize
        super('El empleado quiso registrar su entrada nuevamente')
      end
    end

    class CheckedOutAgainError < GraphQL::ExecutionError
      def initialize
        super('El empleado quiso registrar su salida nuevamente')
      end
    end

    class CheckedOutBeforeError < GraphQL::ExecutionError
      def initialize
        super('El empleado registró su salida antes')
      end
    end
  end
end
