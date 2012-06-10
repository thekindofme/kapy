module Kapy
  class File
    def write_or_update_files files, base
      puts files
      files.each do |file, content|
        file = ::File.join(base, file)
        if ::File.exists?(file)
          warn "[skip] '#{file}' already exists"
        elsif ::File.exists?(file.downcase)
          warn "[skip] '#{file.downcase}' exists, which could conflict with `#{file}'"
        else
          unless ::File.exists?(::File.dirname(file))
            puts "[add] making directory '#{::File.dirname(file)}'"
            FileUtils.mkdir(::File.dirname(file))
          end
          puts "[add] writing '#{file}'"
          ::File.open(file, "w") { |f| f.write(content) }
        end
      end
    end
  end
end