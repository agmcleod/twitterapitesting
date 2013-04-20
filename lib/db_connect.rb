require 'yaml'
require 'active_record'

class DbConnect
  attr_accessor :config
  def initialize
    self.config = YAML.load IO.read(File.expand_path(File.dirname(__FILE__) + '/../config/database.yml'))
    ActiveRecord::Base.establish_connection(
      adapter: "postgresql",
      database: config['database'],
      username: config['username'],
      password: config['password'],
      encoding: "utf-8",
      host: 'localhost'
    )
  end
end