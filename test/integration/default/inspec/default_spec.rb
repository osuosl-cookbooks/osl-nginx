# Tests nginx _test_vhost without certificate chain recipe

# Dependencies installed
describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe port('80') do
  it { should be_listening }
end

describe iptables do
  it { should have_rule('-A INPUT -j http') }
  it { should have_rule('-A http -p tcp -m tcp --dport 80 -j ACCEPT') }
  it { should have_rule('-A http -p tcp -m tcp --dport 443 -j ACCEPT') }
  it { should have_rule('-N http') }
end
