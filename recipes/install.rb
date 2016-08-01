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

haproxy_addr = find_haproxy
db_host = unless haproxy_addr.nil?
	    haproxy_addr
	  else
	    node['chef_task_server']['db_host']
	  end
rabbitmq_url = unless haproxy_addr.nil?
	    "amqp://guest:guest@#{haproxy_addr}:5672/"
	  else
	    node['chef_task_server']['rabbitmq_url']
	  end

template "/etc/raintank/task-server.ini" do
  source 'task-server.ini.erb'
  mode '0644'
  owner 'root'
  group 'root'
  action :create
  variables({
    db_host: db_host,
    rabbitmq_url: rabbitmq_url
  })
  # notifies ....
  notifies :restart, 'service[task-server]', :delayed
end

