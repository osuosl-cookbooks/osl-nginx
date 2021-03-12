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
        expect(chef_run).to install_nginx_install('osuosl').with(source: 'repo')
      end
      it do
        expect(chef_run).to create_nginx_config('osuosl')
      end
      it do
        expect(chef_run).to enable_nginx_service('osuosl')
      end
      it do
        expect(chef_run).to start_nginx_service('osuosl')
      end
      it do
        expect(chef_run).to create_directory('/etc/nginx/includes.d')
      end
      %w(sites-available sites-enabled).each do |d|
        it do
          expect(chef_run).to delete_directory("/etc/nginx/#{d}").with(recursive: true)
        end
      end
    end
  end
end
