# Set up app's custom configuration in the environment.
# See https://forums.aws.amazon.com/thread.jspa?threadID=118107

Chef::Log.info("Listing Env Variables")
node[:custom_env].each do |application, vars|
  Chef::Log.info("application: #{application}")
  vars.each do |k, v|
    Chef::Log.info("#{k}: #{v}")
  end
end
