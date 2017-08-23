#
# Cookbook:: task3_database
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
package 'net-tools'

execute 'mysql-community-repo' do
  command 'yum localinstall https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm -y'
  action :run
end

mysql_service 'foo' do
  port '3306'
  version '5.7'
  initial_root_password 'Ch4ng3me'
  action [:create, :start]
end

bash 'DBSchema' do
  code <<-SHELL
    mysql -S /var/run/mysql-foo/mysqld.sock -uroot -pCh4ng3me -e "create database task3 character set utf8 collate utf8_bin;"
    SHELL
  not_if "mysql -S /var/run/mysql-foo/mysqld.sock -uroot -pCh4ng3me -e 'show databases' | grep task3"
end