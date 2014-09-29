osl-nginx Cookbook
===================
This cookbook is a wrapper cookbook for the nginx opscode community cookbook. It
contains a definition to manage vhosts and add custom functionality such as
munin graphing and nagios checks. In addition is can automatically calculate max
hosts settings based on available memory.

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
- `cookbook` - Optional. Cookbook where the source template is. If this is not
  defined, Chef will use the named template in the cookbook where the definition
  is used.
- `template` - Default ``nginx_app.conf.erb``, source template file.
- `enable` - Default true. Passed to the ``nginx_site`` definition.

### Examples:

Unlike the ``web_app`` definition, not all of the parameters are passed to the
template. You are still provided the option if you want to have a custom
template in your own cookbook by using the `@params` variable. Here is a list of
all of the parameters available for the default template:

- ``server_aliases`` - ServerAlias directive. Must be an array of aliases.
- `directory` - Creates the Defaults to `/var/www/#{params['name']}.
- `custom_config` - Optional. Adds the include directive. Pulls source from
  `files/default/#{node['osl-nginx']['hostname']}/#{params['name']}`
- `ssl_enable` - Enables ssl support. Note that `ssl_enable`, `cert_file`, and
  `cert_key` must be defined in order to populate the directive.
- `cert_file` - Path to ssl cert.
- `cert_key` - Path to ssl key.
- `cert_chain` - Optional, path to ssl cert chain.

To use the default ``nginx_app``, for example:

``` ruby
    nginx_app "www.example.com" do
      server_aliases ["www.example.org", "test.example.com"]
      docroot "/var/www/www.example.com/yes"
      enable_ssl true
    end
```

#### Custom includes:

Sometimes you will need to have custom settings for a vhost. You can add the
``custom_config`` parameter to ``nginx_app`` to include a custom file.
osl-nginx will look for the file within
`files/default/#{node['osl-nginx']['hostname']/#{@params['name']}}`. If the file
is not in that location then it will not load. You can include custom files from
different cookbooks by passing in the cookbook parameter.

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
Authors:

Anthony Miller (armiller@osuosl.org)
Lance Albertson (lance@osuosl.org)
