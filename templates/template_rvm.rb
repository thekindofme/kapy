require_relative "../lib/templates/template"

class TemplateRvm < Kapy::Template
  def requires
    Proc.new {
      $:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
      require "rvm/capistrano"                  # Load RVM's capistrano plugin.
    }
  end

  def body
    Proc.new {
      set :rvm_ruby_string, 'ruby-1.9.2-p290@global'        # Or whatever env you want it to run in.
      set :rvm_type, :user  # Copy the exact line. I really mean :user here
    }
  end
end