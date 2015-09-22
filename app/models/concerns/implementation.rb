module Implementation
  extend ActiveSupport::Concern
  IMPLEMENTATIONS = (%w(follows does_not_follow na ambiguous unknown).map &:to_sym)

  included do |base|
    base.validates :implementation, presence: true, :numericality => {:greater_than_or_equal_to => 0, :less_than => IMPLEMENTATIONS.size}
  end

  IMPLEMENTATION_MAP = {
    1 => :follows,
    2 => :does_not_follow,
    3 => :na,
    4 => :ambiguous,
    5 => :unknown
  }

  class_methods do
    def implementations
      IMPLEMENTATIONS
    end
  end

  def implementation_text
    # Displays current implementation as text
    IMPLEMENTATIONS[self.implementation]
  end
end
