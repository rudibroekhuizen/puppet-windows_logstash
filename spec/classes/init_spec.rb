require 'spec_helper'
describe 'windows_logstash' do

  context 'with defaults for all parameters' do
    it { should contain_class('windows_logstash') }
  end
end
