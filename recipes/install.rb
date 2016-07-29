packagecloud_repo node[:chef_base][:packagecloud_repo] do
  type "deb"
end

pkg_version = node['chef_task_server']['package_version']
pkg_action = if pkg_version.nil?
  :upgrade
else
  :install
end

package "task-server" do
  version pkg_version
  action pkg_action
  notifies :restart, 'service[task-server]', :delayed
end

service "task-server" do
  case node["platform"]
  when "ubuntu"
    if node["platform_version"].to_f >= 15.04
      provider Chef::Provider::Service::Systemd
    elsif node["platform_version"].to_f >= 9.10
      provider Chef::Provider::Service::Upstart
    end
  end
  action [ :enable, :start]
end

template "/etc/raintank/task-server.ini" do
  source 'task-server.ini.erb'
  mode '0644'
  owner 'root'
  group 'root'
  action :create
  # notifies ....
  notifies :restart, 'service[task-server]', :delayed
end

