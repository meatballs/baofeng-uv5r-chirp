require 'rubygems'
require 'nokogiri'
require_relative 'build_parameters'

def get_xml_string_from_defintion_files
  memory_string = ""
  $definition_files.each do |definition_file|
    file = File.open(definition_file)
    memories = Nokogiri::XML(file).root.search("./memories/memory")
    memories.each do |memory|
      memory_string << memory.to_s
    end    
    file.close
  end
  return memory_string
end

def get_xml_from_definition_files
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.radio(:version => $chirp_version) {
      xml.memories {
        xml << get_xml_string_from_defintion_files
      }
      xml.banks {}
    }
  end
  return builder
end

def write_output_file_from_xml(xml)
  File.delete($output_file_name) if File.exist?($output_file_name)
  File.open($output_file_name, 'w') do |file| 
    file.write(xml.to_xml)
    file.close
  end
end