require_relative '../../spec_helper'

describe 'osl-nginx::logrotate' do
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
        expect(chef_run).to upgrade_logrotate_package('osl-nginx')
      end

      it do
        expect(chef_run).to enable_logrotate_app('nginx').with(
          path: '"/var/log/nginx/*/*/*.log"',
          frequency: 'daily',
          postrotate: '[ ! -f /run/nginx.pid ] || kill -USR1 `cat /run/nginx.pid`'
        )
      end
    end
  end
end
