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
    action :delete
    ignore_failure true
end

apt_repository "fast-mirror" do
    uri "mirror://mirrors.ubuntu.com/mirrors.txt"
    distribution node['lsb']['codename']
    components ["main", "restricted", "universe", "multiverse"]
    action :add
    notifies :run, "execute[apt-get update]"
end

%w{updates backports security}.each do |t|
    apt_repository "fast-mirror-#{t}" do
        uri "mirror://mirrors.ubuntu.com/mirrors.txt"
        distribution "#{node['lsb']['codename']}-#{t}"
        components ["main", "restricted", "universe", "multiverse"]
        action :add
        notifies :run, "execute[apt-get update]"
    end
end
