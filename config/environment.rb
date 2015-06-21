# Load the Rails application.
require File.expand_path('../application', __FILE__)
ENV['LD_LIBRARY_PATH'] ||="/usr/lib"
ENV['LD_LIBRARY_PATH'] +=":/app/lib/native"
ENV['MECAB_PATH']='/usr/local/lib/libmecab.so'

# Initialize the Rails application.
Rails.application.initialize!
