module WatirSplash
  module Frameworks
    class Helper
      class << self
        def load_gem params
          gem params[:gem], params[:version]
          require params[:require] || params[:gem]
        rescue Gem::LoadError
          puts "\nUnable to load #{params[:gem]} gem. Install it with:\n  gem install #{params[:gem]}#{params[:version] ? " -v #{params[:version]}" : ""}\n\n"
          exit 1
        end
      end
    end
  end
end
