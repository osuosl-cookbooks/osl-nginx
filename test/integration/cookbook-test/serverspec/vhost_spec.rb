# Tests nginx _test_vhost without certificate chain recipe
require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

# Dependencies installed
describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe port(443) do
  it { should_not be_listening }
end

describe file('/etc/nginx/sites-available/test-cookbook.osuosl.org.conf') do
  it { should be_mode 644 }
  it { should be_owned_by 'nginx' }
  it { should be_grouped_into 'nginx' }
  its(:content) { should_not match /ssl_certificate/ }
  its(:content) { should match /include \/etc\/nginx\/sites-available\/test-cookbook.osuosl.org_include.conf;/ }
end

describe file('/etc/nginx/sites-available/test-cookbook-name.osuosl.org.conf') do
  it { should be_mode 644 }
  it { should be_owned_by 'nginx' }
  it { should be_grouped_into 'nginx' }
  its(:content) { should match /include \/etc\/nginx\/sites-available\/test-cookbook_include.conf;/ }
  its(:content) { should match /server_name test-cookbook-name.osuosl.org;$/ }
end

describe file('/etc/nginx/sites-available/test-cookbook-include.osuosl.org.conf') do
  it { should be_mode 644 }
  it { should be_owned_by 'nginx' }
  it { should be_grouped_into 'nginx' }
  its(:content) { should match /include \/etc\/nginx\/sites-available\/test_include.conf;$/ }
  its(:content) { should match /server_name test-cookbook-include.osuosl.org;$/ }
end

describe file('/etc/nginx/sites-available/test-cookbook-template.osuosl.org.conf') do
  it { should be_mode 644 }
  it { should be_owned_by 'nginx' }
  it { should be_grouped_into 'nginx' }
  its(:content) { should match /cookbook-template$/ }
end

describe file('/etc/nginx/sites-available/test_include.conf') do
  it { should be_mode 644 }
  it { should be_owned_by 'nginx' }
  it { should be_grouped_into 'nginx' }
  its(:content) { should match /test-include-name/ }
end

describe file('/etc/nginx/sites-available/test-cookbook_include.conf') do
  it { should be_mode 644 }
  it { should be_owned_by 'nginx' }
  it { should be_grouped_into 'nginx' }
  its(:content) { should match /test-name-cookbook/ }
end

describe file('/etc/nginx/sites-available/test-cookbook.osuosl.org_include.conf') do
  it { should be_mode 644 }
  it { should be_owned_by 'nginx' }
  it { should be_grouped_into 'nginx' }
  its(:content) { should match /test-cookbook/ }
end

%w[test-cookbook test-cookbook-include test-cookbook-include
test-cookbook-template].each do |f|
  describe file("/etc/nginx/sites-enabled/#{f}.osuosl.org.conf") do
    it { should be_linked_to "/etc/nginx/sites-available/#{f}.osuosl.org.conf" }
  end
end
