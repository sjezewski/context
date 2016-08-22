#!/usr/bin/env ruby

# Detects if there is any context in the CWD for:
#
# pachctl
# kubectl
# gcloud
# docker machine
#
# And updates the state of those connections accordingly.

def usage
    puts "Usage: context [use|view|set]"
    exit 1
end

def parse_command
    puts ARGV
    if ARGV.size != 1
        usage
    end
   ARGV[0] 
end

def view
    context_file = "./.ctx"
    if File.exist? context_file
        raw = File.read("./.ctx")
        puts "Found ctx : #{raw}"
    else
        puts "No local context"
    end
end



case parse_command
when "set"
    
when "view"
    view
when "use"

else

end
