#! /usr/bin/env ruby

require_relative 'build_methods'

definition_files = Dir.glob('channel_definitions/*.chirp')

xml = get_xml_from_definition_files(definition_files)

write_output_file_from_xml(xml)
