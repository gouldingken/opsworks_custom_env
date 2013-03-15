This cookbook can be used to set environment variables for Node.js layers.
Expects attributes of the form:

{
  "custom_env": {
  "TEST_VAR": "alongpassword45435",
  "TEST_VAR2": "1001"
  }
}


UNDER DEVELOPMENT


Opsworks Set-Up
---------------

The `opsworks_custom_env::configure` recipe should be added as a custom recipe to the _Setup_, _Configure_, and _Deploy_ events.

A deploy is not necessary to update custom application environment values. Instead, update the Stack's custom JSON, then choose to _Run Command_ > _execute recipes_ and enter `opsworks_custom_env::update` into the _Recipes to execute_ field. 

Executing this recipe... NOT YET IMPLEMENTED
