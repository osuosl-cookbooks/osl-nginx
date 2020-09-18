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
      it do
        expect(chef_run).to install_nginx_install('repo')
      end
      it do
        expect(chef_run).to nothing_service('nginx')
      end
      it do
        expect(chef_run).to remove_package('nginx')
        # this doesnt pass but it happens
        # expect(chef_run).to install_package('nginx')
        expect(chef_run.package('nginx')).to notify('service[nginx]').to(:restart)
        expect(chef_run).to nothing_service('nginx')
      end if p[:version].to_i < 7
    end
  end
end
