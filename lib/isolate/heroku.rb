require "digest/md5"
require "isolate"

unless ENV.keys.any? { |k| /^heroku/i =~ k }
  digest = File.file?(".gems") && Digest::MD5.hexdigest(File.read ".gems")
  
  File.open ".gems", "wb" do |f|
    f.puts "isolate --version '= #{Isolate::VERSION}'"

    Isolate.sandbox.entries.each do |entry|
      next unless entry.matches? "production"

      gem  = [entry.name]
      gem << "--version '#{entry.requirement}'"

      if entry.options[:source]
        gem << "--source #{entry.options[:source]}"
      end

      f.puts gem.join(" ")
    end
  end

  unless digest == Digest::MD5.hexdigest(File.read ".gems")
    warn ".gems has changed! Don't forget to commit it."
  end
end
