#! /usr/bin/env ruby

require_relative 'build_methods'

xml = get_xml_from_definition_files

write_output_file_from_xml(xml)
