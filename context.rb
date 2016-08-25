#!/usr/bin/env ruby
require 'json'
require_relative 'adapter'

# Detects if there is any context in the CWD for:
#
# pachctl
# kubectl
# gcloud
# docker machine
#
# And updates the state of those connections accordingly.

def usage
    STDERR.puts "Usage: context [use|view|set]"
    exit 1
end

def parse_command
    if ARGV.size == 0
        usage
    end
   ARGV[0]
end

$context_file = "./.ctx"

def view(setting_path)
    if File.exist? $context_file
        raw = File.read $context_file
		settings = JSON.parse raw
		if setting_path.nil?
			puts JSON.pretty_generate(settings)
		else
			if setting_path.size == 0
				STDERR.puts "Usage:\nctx view <adapter_name> <setting>"
				exit 1
			end
			v = nil
			setting_path.each do |key|
				v = settings[key]
			end
			puts v
		end
    else
        puts "No local context"
		puts "To get started refer to: https://github.com/sjezewski/context"
		exit 1
    end
end

# TODO - if running set in CWD, call use at the end
def set(key_path, value)
    ctx = {}
    
    # Load existing config
    if File.exist? $context_file
        raw = File.read $context_file
        ctx = JSON.parse raw
    end

	adapters = Adapter.List

    key_index = 0
    obj = ctx
	adapter = nil

    while key_index < key_path.size do
		if key_index == 0
			adapter = key_path[key_index]
			if adapters[adapter].nil?
				STDERR.puts "No such adapter #{adapter} supported."
				adapter_list = adapters.collect { |k,v| "\t- #{k}" }.join("\n")
				STDERR.puts "Valid adapters are:\n#{adapter_list}"
				exit 1
			end
def use
    ctx = {}
    
    # Load existing config
    if File.exist? $context_file
        raw = File.read $context_file
        ctx = JSON.parse raw
    end

    if ctx == {}
        STDERR.puts "No config found"
        exit 1
    end

    adapters = Adapter.List
    ctx.each do |name, config|
        if adapters[name].nil?
            STDERR.puts "Adapter #{name} not implemented."
            exit 1
        end
        adapters[name].use(config)
    end

end

case parse_command
when "set"
    if ARGV.size > 1
        key_path = ARGV[1..-2]
        value = ARGV[-1]
        set(key_path, value)
    else
        puts "Saving current state to current working directory."
        Adapter.List.each do |a|
            a.update_config
        end
    end
when "view"
    view ARGV[1..-1]
when "use"
    use
else
    usage
end
