require 'sqlite3'
require 'rspec'
require 'rspec/autorun'
require 'active_record'

$LOAD_PATH << '.'
require 'lib/discover'

require 'rspec/rails/adapters'
require 'rspec/rails/fixture_support'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
ActiveRecord::Base.configurations = true

File.open('spec.log', 'w').close
ActiveRecord::Base.logger = Logger.new('spec.log')

ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define(:version => 1) do
  create_table :groups do |t|
    t.string :name
  end
end

RSpec.configure do |config|
  config.use_transactional_examples = true
  config.before(:each) do
    class ::Group < ActiveRecord::Base

      scope :by_char, lambda { |char|
        {
          :conditions => ['name like ?', char + '%'],
          :order => 'name'
        }
      }
    end

  end

  config.after(:each) do
    Object.send(:remove_const, :Group)
  end
end
