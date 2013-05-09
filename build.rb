#! /usr/bin/ruby

require 'rexml/document'
include REXML

output_file_name = "radio_config.chirp"
chirp_version = "0.1.1"

File.delete(output_file_name) if File.exist?(output_file_name)

output_doc = Document.new()
output_doc.context[:attribute_quote] = :quote
output_doc << XMLDecl.new

radio = output_doc.add_element("radio", {"version" => chirp_version})
memories = radio.add_element("memories")
radio.add_element("banks")

Dir.glob('channel_definitions/*.chirp') do |chirp_file|
  file = File.new(chirp_file)
  doc = Document.new(file)
  doc.elements.each("radio/memories/memory") do |memory|
    memories.add_element(memory)
  end
end

formatter = REXML::Formatters::Pretty.new()
formatter.compact = true
File.open(output_file_name, "w") do |output_file|
  formatter.write(output_doc, output_file)
end
