require_relative '../../spec_helper'

describe 'osl-nginx::mon' do
  ALL_PLATFORMS.each do |p|
    context "#{p[:platform]} #{p[:version]}" do
      cached(:chef_run) do
        ChefSpec::SoloRunner.new(p).converge('osl-nginx::default', described_recipe)
      end

      include_context 'common_stubs'

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      case p
      when CENTOS_7
        it do
          expect(chef_run).to create_template('/etc/munin/plugin-conf.d/nginx').with(
            source: 'munin/nginx.erb',
            owner: 'root',
            group: 'root',
            mode: '0644'
          )
        end
      when CENTOS_8
        it do
          expect(chef_run).to_not create_template('/etc/munin/plugin-conf.d/nginx')
        end
      end
    end
  end
end
