maintainer       "Sasaki"
maintainer_email "info@sasaki.com"
license          "All rights reserved"
description      "Writes custom ENV values for Node.js apps"
version          "0.0.1"

#recipe "custom_env::configure", "Intended as part of configure/deploy OpsWorks events."
#recipe "custom_env::update", "Can be run independently of OpsWorks configure/deploy events."
recipe "custom_env::testenv", "Test some logging..."

depends "rightscale"