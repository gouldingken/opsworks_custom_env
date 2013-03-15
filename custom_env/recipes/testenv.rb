# Set up app's custom configuration in the environment.
# See https://forums.aws.amazon.com/thread.jspa?threadID=118107

Chef::Log.info("Listing Env Variables")

#command "export TEST_VAR=helloNode"
#Chef::Log.info("To go in #{@deploy[:deploy_to]}/shared/config/vars.json")

env_vars = Array.new
node[:custom_env].each do |k, v|
  env_vars.push("#{k}=#{v}")
  Chef::Log.info("added env var: #{k}=#{v}")
end



node[:custom_node_env] = env_vars.join(' ')


Chef::Log.info("env vars for node: #{node[:custom_node_env]}")
