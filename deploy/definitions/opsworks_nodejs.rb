Chef::Log.info("Using override for opsworks_nodejs")

#--can't define or use 'node' variables here...

define :opsworks_nodejs do
  deploy = params[:deploy_data]
  application = params[:app]

  #-------------- environment vars (temp location) --------------
  env_vars = Array.new
  node[:custom_env].each do |k, v|
    env_vars.push("#{k}=#{v}")
    Chef::Log.info("added env var: #{k}=#{v}")
  end
  node[:custom_node_env] = env_vars.join(' ')

  Chef::Log.info("env vars for node: #{node[:custom_node_env]}")
  #------------------------------------

  service 'monit' do
    action :nothing
  end

  node[:dependencies][:npms].each do |npm, version|
    execute "/usr/local/bin/npm install #{npm}" do
      cwd "#{deploy[:deploy_to]}/current"
    end
  end

  template "#{deploy[:deploy_to]}/shared/config/opsworks.js" do
    cookbook 'opsworks_nodejs'
    source 'opsworks.js.erb'
    mode '0660'
    owner deploy[:user]
    group deploy[:group]
    variables(:database => deploy[:database], :memcached => deploy[:memcached], :layers => node[:opsworks][:layers])
  end

  template "#{node[:monit][:conf_dir]}/node_web_app-#{application}.monitrc" do
    source 'node_web_app.monitrc.erb'
    cookbook 'opsworks_nodejs'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
        :environment_vars => env_vars,
        :deploy => deploy,
        :application_name => application,
        :monitored_script => "#{deploy[:deploy_to]}/current/server.js"
    )
    notifies :restart, resources(:service => 'monit'), :immediately
  end
end
