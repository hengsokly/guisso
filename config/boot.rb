require 'yaml'
require 'erb'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

module Settings
  extend self

  CONFIG = YAML.load(ERB.new(File.read(File.expand_path('../settings.yml', __FILE__))).result)

  def method_missing(method_name)
    if method_name.to_s =~ /(\w+)\?$/
      CONFIG[$1] == true
    else
      CONFIG[method_name.to_s]
    end
  end
end
