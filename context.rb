#!/usr/bin/env ruby
require 'json'

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
    if ARGV.size == 0
        usage
    end
   ARGV[0]
end

$context_file = "./.ctx"

def view
    if File.exist? $context_file
        raw = File.read $context_file
        puts JSON.pretty_generate( JSON.parse(raw) )
    else
        puts "No local context"
    end
end

def set(key_path, value)
    ctx = {}
    if File.exist? $context_file
        raw = File.read $context_file
        puts "Updating existing context"
        ctx = JSON.parse raw
    end

    key_index = 0
    obj = ctx
    while key_index < key_path.size - 1 do
        if obj[key_path[key_index]].nil?
            obj[key_path[key_index]] = {}
        end
        obj = obj[key_path[key_index]]
        key_index += 1
    end
    obj[key_path[key_index]] = value

    File.open($context_file, "w") {|f| f << JSON(ctx)}
end

case parse_command
when "set"
   key_path = ARGV[1..-2]
   value = ARGV[-1]
   puts "Setting #{key_path} to value #{value}"
   set(key_path, value)
when "view"
    view
when "use"
    use
else
    usage
end
