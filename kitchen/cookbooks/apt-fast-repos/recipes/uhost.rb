#
#
# Cookbook Name:: apt-fast-repos
# Recipe:: default
#
# Copyright 2012, raptium
#
# All rights reserved - Do Not Redistribute
#
#

file "/etc/apt/sources.list" do
    action :create
    content ""
    ignore_failure true
end

apt_repository "uhost" do
    uri "http://ubuntu.uhost.hk"
    distribution node['lsb']['codename']
    components ["main", "restricted", "universe", "multiverse"]
    action :add
    notifies :run, "execute[apt-get update]"
end

%w{updates backports security}.each do |t|
    apt_repository "uhost-#{t}" do
        uri "http://ubuntu.uhost.hk"
        distribution "#{node['lsb']['codename']}-#{t}"
        components ["main", "restricted", "universe", "multiverse"]
        action :add
        notifies :run, "execute[apt-get update]"
    end
end
