# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'rdf/sesame'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
#  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
#  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end

def connect_to_sesame_server
  uri = RDF::URI(Facade2::Application.config.sesame_uri)
  RDF::Sesame::Server.new(uri)
end

def connect_to_repo(server,repo = Facade2::Application.config.default_repository)
  server.repository(repo)
end

def create_dcterms_statement
  RDF::Statement.new(
    :subject => RDF::URI.new('usip-sample:FILE-8'),
    :predicate => RDF::DC.title,
    :object => RDF::Literal.new('070207_Atrium_view_Donor.jpg')
  )
end
