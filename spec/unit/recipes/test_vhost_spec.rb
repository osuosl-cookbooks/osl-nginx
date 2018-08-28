require_relative '../../spec_helper'

describe 'osl-nginx::_test_vhost' do
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
        expect(chef_run).to create_nginx_app('test.osuosl.org').with(
          server_aliases: %w(test1.osuosl.org test2.osuosl.org),
          directory: '/var/www/test.osuosl.org',
          ssl_enable: true,
          cert_file: '/etc/pki/tls/certs/test.osuosl.org.pem',
          cert_key: '/etc/pki/tls/private/test.osuosl.org.key',
          directive_http: ['rewrite ^ https://$server_name$request_uri? permanent;']
        )
      end

      it do
        expect(chef_run).to create_nginx_app('test-include.osuosl.org').with(
          directory: '/var/www/test-include.osuosl.org',
          include_config: true
        )
      end

      it do
        expect(chef_run).to create_nginx_app('test-include-name.osuosl.org').with(
          directory: '/var/www/test-include-name.osuosl.org',
          include_config: true,
          include_name: 'test'
        )
      end
    end
  end
end
