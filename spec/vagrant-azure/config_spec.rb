require "vagrant-azure/config"

require 'coveralls'
Coveralls.wear!

describe VagrantPlugins::Azure::Config do
  let(:instance) { described_class.new }
  
end