# Set up app's custom configuration in the environment.
# See https://forums.aws.amazon.com/thread.jspa?threadID=118107

Chef::Log.info("Listing Env Variables")
Chef::Log.info("my_app: #{node[:custom_env][:my_app]}")
