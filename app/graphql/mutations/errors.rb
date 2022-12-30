module Mutations
  module Errors
    class InvalidCheckedInError < GraphQL::ExecutionError
      def initialize
        super(I18n.t('mutations.errors.invalid_checked_in_error'))
      end
    end

    class WithoutCheckInError < GraphQL::ExecutionError
      def initialize
        super(I18n.t('mutations.errors.without_check_in_error'))
      end
    end

    class CheckedInAgainError < GraphQL::ExecutionError
      def initialize
        super(I18n.t('mutations.errors.checked_in_again_error'))
      end
    end

    class CheckedOutAgainError < GraphQL::ExecutionError
      def initialize
        super(I18n.t('mutations.errors.checked_out_again_error'))
      end
    end

    class CheckedOutBeforeError < GraphQL::ExecutionError
      def initialize
        super(I18n.t('mutations.errors.checked_out_before_error'))
      end
    end
  end
end
