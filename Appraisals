# encoding: utf-8

%w{ 4.1.1 4.0.5 3.2.18 }.each do |version|
  appraise "activerecord-#{version}" do
    gem 'activerecord', version
    gem 'jdbc-sqlite3', platform: :jruby
  end
end
