module WatirSplash
  module Frameworks
    class Helper
      class << self
        def load_gems *gems
          failed_gems = []
          gems.each do |gem_params|
            begin
              gem gem_params[:gem], gem_params[:version]
              require gem_params[:require] || gem_params[:gem]
            rescue Gem::LoadError
              failed_gems << gem_params
            end
          end
          unless failed_gems.empty?
            puts "\nSome dependencies are missing. Install them with:"
            failed_gems.each do |failed_gem|
              puts "  gem install #{failed_gem[:gem]}#{failed_gem[:version] ? " -v #{failed_gem[:version].gsub(/^[~>=]*\s*/, "")}" : ""}"
            end
            puts
            exit 1 unless failed_gems.empty?          
          end
        end

        alias_method :load_gem, :load_gems
      end
    end
  end
end
