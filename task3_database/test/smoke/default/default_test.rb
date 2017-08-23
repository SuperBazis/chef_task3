# # encoding: utf-8

# Inspec test for recipe task3_database::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe service('mysql-foo') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port(3306) do
  it { should be_listening }
end

describe file('/var/run/mysql-foo/mysqld.sock') do
 it { should exist }
end

describe mysql_session('root', 'Ch4ng3me', 'localhost', 3306, '/var/run/mysql-foo/mysqld.sock').query('show databases') do
  its('stdout') { should match /task3/ }
end