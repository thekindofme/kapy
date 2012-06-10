require_relative "../lib/templates/template"

class TemplateUnicorn < Kapy::Template
  def body
    <<END
namespace :deploy do
  desc "Zero-downtime restart of Unicorn"
  task :restart, :except => { :no_release => true } do
    run "kill -s USR2 `cat /tmp/unicorn.starcount.pid`"
  end

  desc "Start unicorn"
  task :start, :except => { :no_release => true } do
    run "cd #\{current_path} ; RAILS_ENV=#\{rails_env} bundle exec unicorn_rails -c config/unicorn.rb -D"
  end

  desc "Stop unicorn"
  task :stop, :except => { :no_release => true } do
    run "kill -s QUIT `cat /tmp/unicorn.starcount.pid`"
  end
end
END
  end
end