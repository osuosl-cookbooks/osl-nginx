docker = inspec.command('test -e /.dockerenv')

include_controls 'osuosl-baseline' do
  skip_control 'ssl-baseline'
end

control 'default' do
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

  describe file '/etc/nginx/dhparam.pem' do
    it { should exist }
    its('mode') { should cmp '0640' }
    its('content') { should match %r{MIICCAKCAgEA1l98/amgPcQzuYTI9HyFjRc2Qy6DVG8CXM999Fh0NK04r6ZPGKgj} }
  end

  describe iptables do
    it { should have_rule('-A INPUT -j http') }
    it { should have_rule('-A http -p tcp -m tcp --dport 80 -j ACCEPT') }
    it { should have_rule('-A http -p tcp -m tcp --dport 443 -j ACCEPT') }
    it { should have_rule('-N http') }
  end unless docker

  describe ip6tables do
    it { should have_rule('-A INPUT -j http') }
    it { should have_rule('-A http -p tcp -m tcp --dport 80 -j ACCEPT') }
    it { should have_rule('-A http -p tcp -m tcp --dport 443 -j ACCEPT') }
    it { should have_rule('-N http') }
  end unless docker

  describe file '/etc/logrotate.d/nginx' do
    its('content') { should match %r{"/var/log/nginx/\*/\*/\*\.log" \{} }
    its('content') { should match /daily/ }
    its('content') { should match %r{\[ ! -f /run/nginx\.pid \] \|\| kill -USR1 `cat /run/nginx\.pid`} }
  end
end
