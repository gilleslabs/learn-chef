# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "jdoe"
client_key               "#{current_dir}/jdoe.pem"
validation_client_name   "4thcoffee-validator"
validation_key           "#{current_dir}/4thcoffee-validator.pem"
chef_server_url          "https://mychefserver.example.com/organizations/4thcoffee"
cookbook_path            ["#{current_dir}/../cookbooks"]
