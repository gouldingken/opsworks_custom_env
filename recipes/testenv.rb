# Set up app's custom configuration in the environment.
# See https://forums.aws.amazon.com/thread.jspa?threadID=118107

rightscale_marker :begin
log "Hello World! You should try Chef with RightScale!"
log "my_app: #{node[:custom_env][:my_app]}"
rightscale_marker :end