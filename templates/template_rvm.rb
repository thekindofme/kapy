require_relative "../lib/templates/template"

class TemplateRvm < Kapy::Template
  def requires
    <<END
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
END
  end

  def body
    <<END
set :rvm_ruby_string, 'ruby-1.9.2-p290@global'        # Or whatever env you want it to run in.
set :rvm_type, :user  # Copy the exact line. I really mean :user here
END
  end
end