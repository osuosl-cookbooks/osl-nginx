require_relative '../../spec_helper'

describe 'osl-nginx::default' do
  ALL_PLATFORMS.each do |p|
    context "#{p[:platform]} #{p[:version]}" do
      cached(:chef_run) do
        ChefSpec::SoloRunner.new(p).converge(described_recipe)
      end

      include_context 'common_stubs'

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      it { expect(chef_run).to include_recipe('osl-selinux') }
      it { expect(chef_run).to create_selinux_module('osl-nginx') }
      it { expect(chef_run).to accept_osl_firewall_port('http') }
      it { expect(chef_run).to install_nginx_install('osuosl').with(source: 'repo') }
      it { expect(chef_run).to create_nginx_config('osuosl') }
      it { expect(chef_run.nginx_config('osuosl')).to notify('nginx_service[osuosl]').to(:restart).delayed }
      it { expect(chef_run).to enable_nginx_service('osuosl') }
      it { expect(chef_run).to start_nginx_service('osuosl') }
      it { expect(chef_run).to create_directory('/etc/nginx/includes.d') }

      it do
        expect(chef_run).to create_file('/etc/nginx/dhparam.pem').with(
          content: 'dh param key',
          mode: '0640',
          sensitive: true
        )
      end

      it do
        expect(chef_run.file('/etc/nginx/dhparam.pem')).to notify('nginx_service[osuosl]').to(:reload).delayed
      end
    end
  end
end
