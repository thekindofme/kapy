require_relative "../lib/templates/template"

class TemplateGit < Kapy::Template
  def body
    <<END
set :repository,  "git@favmed.unfuddle.com:favmed/dgtadmin.git"
set :scm, :git
END
  end
end