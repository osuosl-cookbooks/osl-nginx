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
        expect(chef_run).to nothing_service('nginx')
      end
    end
  end
end
