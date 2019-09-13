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

%w(
  etherpad-lite.osuosl.org
  nginx_status
).each do |vhost|
  describe file("/etc/nginx/sites-available/#{vhost}.conf") do
    it { should exist }
  end

  describe file("/etc/nginx/sites-enabled/#{vhost}.conf") do
    it { should be_linked_to "/etc/nginx/sites-available/#{vhost}.conf" }
  end
end

describe file('/etc/nginx/sites-available/etherpad-lite.osuosl.org-back.conf') do
  it { should exist }
end

describe file('/etc/nginx/sites-enabled/etherpad-lite.osuosl.org-back.conf') do
  it { should_not exist }
end