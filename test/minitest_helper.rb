require 'erb'
require 'active_record'
require 'druthers'
require 'tmpdir'

db_config = File.expand_path("database.yml", File.dirname(__FILE__))
ActiveRecord::Base.configurations = YAML::load(ERB.new(IO.read(db_config)).result)

def env_db
  ENV["DB"] || "mysql"
end

ActiveRecord::Base.establish_connection(env_db)
ActiveRecord::Migration.verbose = false

require 'test_models'
require 'minitest/autorun'
require 'minitest/great_expectations'
require 'minitest/reporters' unless ENV['CI']
MiniTest::Reporters.use! unless ENV['CI']

Thread.abort_on_exception = true
