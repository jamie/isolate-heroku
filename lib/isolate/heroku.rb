require 'isolate'

unless ENV.keys.any? { |k| /^heroku/i =~ k }
  File.open ".gems", "wb" do |f|
    entries = Isolate.sandbox.entries.sort_by { |e| e.name }

    f.puts "isolate --version '= #{Isolate::VERSION}'"

    entries.each do |entry|
      next unless entry.matches? "production"

      gems  = [entry.name]
      gems << "--version '#{entry.requirement}'"
      
      if entry.options[:source]
        gems << "--source #{entry.options[:source]}"
      end
      
      f.puts gems.join(" ")
    end
  end
  
  STDERR.puts "WARNING: isolate-heroku has modified .gems, please commit to git." if /\.gems/ =~ `git status`
end
