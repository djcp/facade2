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
    end


  end
end