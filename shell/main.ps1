mkdir ~/chef-repo
cd ~/chef-repo
mkdir .chef
cd ~/chef-repo/.chef
mkdir trusted-certs

cp $env:SystemDrive/vagrant/cert/jdoe.pem ~/chef-repo/.chef/.
cp $env:SystemDrive/vagrant/cert/4thcoffee-validator.pem ~/chef-repo/.chef/.
cp $env:SystemDrive/vagrant/cert/knife.rb ~/chef-repo/.chef/.
cp $env:SystemDrive/vagrant/cert/mychefserver.example.com.crt ~/chef-repo/.chef/trusted_certs/.

Set-WinUserLanguageList -LanguageList fr-FR -Force
