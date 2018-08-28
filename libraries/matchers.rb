if defined?(ChefSpec)
  def create_nginx_app(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(
      :nginx_app,
      :create,
      resource_name
    )
  end

  def disable_nginx_app(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(
      :nginx_app,
      :disable,
      resource_name
    )
  end

  def enable_logrotate_app(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(
      :logrotate_app,
      :enable,
      resource_name
    )
  end
end
