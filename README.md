osl-nginx Cookbook
===================
This cookbook is a wrapper cookbook for the nginx opscode community cookbook. It
primarily features a definition to manage vhosts using our standard
configuration. It also ensure a few other settings are used by OSL default.

Attributes
==========

- `node['osl-nginx']['recipes']` - nginx recipes to include in run list
- `node['osl-nginx']['hostname']` - Default to `node['fqdn']`. Determines which
  folder under files/default to look for. If more than one server need access to
  a vhost.
- `node['osl-nginx']['server_port']` - Default server port for nginx. Defaults
  to `80`.
- `node['osl-nginx']['directory_index']` - An array of the supported index
  files. Defaults to `[ "index.html", "index.htm", "index.php" ]`

Recipes
=======

Except for the 'default' recipe, all other recipes are OSL specific.

default
-------

Includes the nginx recipes defined in `node['osl-nginx']['recipes']`.

project\_\*
-----------

Project specific virtual hosts will be managed within these recipes.

logrotate
---------

Set logrotation for nginx log files.

Usage
=====

osl-nginx::default
-------------------
Installs nginx with the default recipe. You can define which nginx recipes to
include with the `node['osl-nginx']['recipes']` attribute.  e.g.  Adding more
nginx recipes in a run list:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[osl-nginx]"
  ]
  override_attributes {
    "osl-nginx" => {
      "recipes" => ["default", "http_realip_module"]
    }
  }
}
```

Definitions
===========

This wrapper cookbook provides definitions for managing virtual hosts.

nginx\_app
----------

``nginx_app`` is similar to apache2's ``web_app``. It includes an OSL specific
template and creates log directories, and can manage ssl options for virtual
hosts.

This definition includes some recipes to make sure the system is configured to
have nginx and some sane default modules:

* `osl-nginx::default`

It will then configure the template and enable or disable the site per the
`enable` parameter.

### Parameters:

Current parameters used by the definition:

- `name` - The name of the site. Also defines the ``server_name`` variable in
  the vhost.  the template will be written to
  ``#{node['nginx']['dir']/sites-available/#{params['name']}.conf``
- `cookbook` - Name of the cookbook to pull the nginx template from. Defaults
  to`osl-nginx`.
- `template` - Default ``nginx_app.conf.erb``, source template file.
- `enable` - Default true. Passed to the ``nginx_site`` definition.
- ``cookbook_include`` - Name of the cookbook to pull the optional include file
  from. Defaults to pulling from the cookbook being called from.
- ``include_name`` - Boolean (optional). Adds the `include` directive to the
  vhost config file. Defaults to `false`.
- ``include_name`` - Name of the include file (sans .conf). Defaults to `name`.
- ``include_resource`` - Type of chef resource to use include file from.
  Currently only supports ``cookbook_file`` or ``template``. Defaults to
  ``cookbook_file``.
- ``server_aliases`` - Additional server names to be included. Must be an array of aliases.
- `directory` - Creates the Defaults to `/var/www/#{params['name']}`.
- ``ssl_enable`` - Enables ssl support. Note that ``ssl_enable``, ``cert_file``, and
  ``cert_key`` must be defined in order to populate the directive.
- ``cert_file`` - Path to ssl cert.
- ``cert_key`` - Path to ssl key.
- ``directive_http`` - An array of nginx config directives to include only in
  the http vhost.
- ``directive_https`` - An array of nginx config directives to include only in
  the https vhost.

To use the default ``nginx_app``, for example:

``` ruby
nginx_app "www.example.com" do
  server_aliases ["www.example.org", "test.example.com"]
  directory "/var/www/www.example.com"
  ssl_enable true
end
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for
contributing. If this is a private cookbook, remove this section.

e.g.

1. Fork the repository on Github
2. Create a named feature branch (like ``add_component_x``)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: OSU Open Source Lab (chef@osuosl.org)
