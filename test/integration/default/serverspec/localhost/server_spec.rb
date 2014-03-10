# Tests for osl-nginx server
require 'spec_helper'

# Nginx installed
describe package('nginx') do
    it { should be_installed }
end

# Nginx service running
describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
end

# Port 80 open and accessable
describe port(80) do
    it { should be_listening }
end
describe host("localhost") do
    it { should be_reachable }
end
