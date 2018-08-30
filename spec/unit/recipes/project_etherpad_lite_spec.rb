require_relative '../../spec_helper'

describe 'osl-nginx::project_etherpad_lite' do
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
        expect(chef_run).to create_nginx_app('etherpad-lite.osuosl.org').with(
          template: 'etherpad/etherpad-lite.osuosl.org.erb'
        )
      end

      it do
        expect(chef_run).to create_nginx_app('etherpad-lite.osuosl.org-back').with(
          template: 'etherpad/etherpad-lite.osuosl.org-back.erb',
          enable: false
        )
      end

      it do
        expect(chef_run).to create_nginx_app('nginx_status').with(
          template: 'etherpad/nginx_status.erb'
        )
      end
    end
  end
end
