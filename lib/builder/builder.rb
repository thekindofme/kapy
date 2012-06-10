module Kapy
  class Builder
    def generate_deploy_file
      requires = generate_section :requires, load_templates
      puts "Requires #{requires}"
      bodies = generate_section :body, load_templates
      puts "Bodies #{bodies}"

      { "config/deploy.rb" => combine_sections(requires, bodies) }
    end

    private
    def load_templates
      puts ::File.dirname(__FILE__)
      templates = Dir.glob("#{::File.dirname(__FILE__)}/../../templates/*.rb").collect do |file|
        puts file
        require file #load the file

        get_type(file)
      end

      templates.compact
    end

    def get_type(file)
      begin
        eval camelize(::File.basename(file, ".rb"))
      rescue
        nil
      end
    end

    def camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
      if first_letter_in_uppercase
        lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
      else
        lower_case_and_underscored_word.first + camelize(lower_case_and_underscored_word)[1..-1]
      end
    end

    def generate_section section, templates
      templates.collect do |t|
        puts "calling #{section}"
        instance = t.new
        instance.send(section).to_source(:strip_enclosure => true) << "\n" if instance.respond_to? section
      end
    end

    def combine_sections requires, bodies
      output = requires.join "\n"
      output << bodies.join("\n")
    end
  end
end