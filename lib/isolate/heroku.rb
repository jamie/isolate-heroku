require "isolate"

unless ENV.keys.any? { |k| /^heroku/i =~ k }
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

  STDERR.puts "WARNING: isolate-heroku has modified .gems, please commit to git." if /\.gems/ =~ `git status`
end
