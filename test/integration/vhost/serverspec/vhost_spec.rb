# Tests nginx _test_vhost without certificate chain recipe
require 'serverspec'

set :backend, :exec

# Dependencies installed
describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

%w[80 443].each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

describe file('/etc/nginx/sites-available/test.osuosl.org.conf') do
  it { should be_mode 644 }
  it { should be_owned_by 'nginx' }
  it { should be_grouped_into 'nginx' }
  it { should contain('rewrite ^ https://$server_name$request_uri? permanent;').from(/listen 80;/).to(/^}$/) }
  it { should_not contain('rewrite ^ https://$server_name$request_uri? permanent;').from(/listen 443;/).to(/^}$/) }
  its(:content) { should match /server_name test.osuosl.org test1.osuosl.org test2.osuosl.org;/ }
  its(:content) { should match /ssl_certificate/ }
  its(:content) { should_not match /include/ }
end

describe file('/etc/nginx/sites-available/test-include.osuosl.org.conf') do
  it { should be_mode 644 }
  it { should be_owned_by 'nginx' }
  it { should be_grouped_into 'nginx' }
  its(:content) { should match /include \/etc\/nginx\/sites-available\/test-include.osuosl.org_include.conf;/ }
  its(:content) { should match /server_name test-include.osuosl.org;$/ }
end

describe file('/etc/nginx/sites-available/test-include-name.osuosl.org.conf') do
  it { should be_mode 644 }
  it { should be_owned_by 'nginx' }
  it { should be_grouped_into 'nginx' }
  its(:content) { should match /include \/etc\/nginx\/sites-available\/test_include.conf;$/ }
  its(:content) { should match /server_name test-include-name.osuosl.org;$/ }
end

describe file('/etc/nginx/sites-available/test_include.conf') do
  it { should be_mode 644 }
  it { should be_owned_by 'nginx' }
  it { should be_grouped_into 'nginx' }
  its(:content) { should match /test-include-name/ }
end

describe file('/etc/nginx/sites-available/test-include.osuosl.org_include.conf') do
  it { should be_mode 644 }
  it { should be_owned_by 'nginx' }
  it { should be_grouped_into 'nginx' }
  its(:content) { should match /test-include-hostname/ }
end

%w[test test-include test-include-name].each do |f|
  describe file("/etc/nginx/sites-enabled/#{f}.osuosl.org.conf") do
    it { should be_linked_to "/etc/nginx/sites-available/#{f}.osuosl.org.conf" }
  end
end
