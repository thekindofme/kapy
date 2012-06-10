require_relative "../lib/templates/template"

class TemplateAssetsPipeline < Kapy::Template
  def body
    <<END
load 'deploy/assets'

# Disable warning message about missing dirs 'public/[javascripts|images|stylesheets]'
# src: https://github.com/capistrano/capistrano/issues/79
set :normalize_asset_timestamps, false
END
  end
end