require 'spec_helper'

module Facade2::Server

  describe 'The sesame server' do
    before(:all) do
      @sesame_server = connect_to_sesame_server
      @repo = connect_to_repo(@sesame_server)
    end
    it 'should have a readable repository' do
      @sesame_server.has_repository?(Facade2::Application.config.default_repository).should == true
      @repo.readable?.should == true
    end
    it 'should have statements' do
      @repo.count.should > 0
    end
  end

  describe 'The RDF statements' do
    before(:all) do
      @sesame_server = connect_to_sesame_server
      @repo = connect_to_repo(@sesame_server)
      @statement = create_dcterms_statement
    end

    it 'should be createable' do
      @statement.blank?.should == false
    end

    it 'should have a statement we can find' do
      @repo.has_statement?(@statement).should == true
    end

    it 'should not have a bogus statement' do
      @repo.has_statement?(
        RDF::Statement.new(
          :subject => RDF::URI.new('adsfasdf'),
          :predicate => 'asdfasdf',
          :object => RDF::Literal.new('asdfasd')
      )).should == false
    end
  end

  describe 'Querying for RDF statements' do
    before(:all) do
      @sesame_server = connect_to_sesame_server
      @repo = connect_to_repo(@sesame_server)
    end

    it 'should be able to find titles' do
      query = RDF::Query.new do
        pattern['<file://C:/fakepath/usip-sample_PIM.rdf.xml>', RDF.type, RDF::DC.title]
      end
      solutions = query.execute(@repo)

      puts solutions.inspect

    end

  end

end
