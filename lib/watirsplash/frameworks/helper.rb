module WatirSplash
  module Frameworks
    class Helper
      class << self
        def load_gems *gems
          gems.each do |gem|
            require gem
          end
        end

        alias_method :load_gem, :load_gems
      end
    end
  end
end
