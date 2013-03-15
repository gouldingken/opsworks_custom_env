Chef::Log.info("Using override for opsworks_nodejs")
tenv_vars = Array.new
node[:custom_env].each do |k, v|
  tenv_vars.push("#{k}=#{v}")
end

Chef::Log.info("env vars for node: #{tenv_vars.join(' ')}")

define :opsworks_nodejs do
  deploy = params[:deploy_data]
  application = params[:app]
  env_vars = params[:env]

  Chef::Log.info("opsworks_nodejs: #{env_vars}")

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
