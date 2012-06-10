require_relative "../lib/templates/template"

class TemplateGit < Kapy::Template
  def body
    Proc.new {
      set :repository,  "git@favmed.unfuddle.com:favmed/dgtadmin.git"
      set :scm, :git
    }
  end
end