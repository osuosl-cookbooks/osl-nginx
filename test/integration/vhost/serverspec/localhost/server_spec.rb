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

# Test vhost file should exist
describe file("/etc/nginx/sites-available/test.conf") do
    it { should be_file }
end

# Test nxensite symlink
describe file('/etc/nginx/sites-enabled/test.conf') do
    it { should be_linked_to '/etc/nginx/sites-available/test.conf' }
end

# Log directory exists
describe file('/var/log/nginx/test') do
    it { should be_directory }
end
