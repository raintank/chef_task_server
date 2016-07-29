default[:chef_task_server]['log_level'] = 2
default[:chef_task_server]['addr'] = ":8082"
default[:chef_task_server]['db_host'] = "localhost"
default[:chef_task_server]['db_port'] = 3306
default[:chef_task_server]['db_name'] = "task_server"
default[:chef_task_server]['db_user'] = "task_server"
default[:chef_task_server]['db_password'] = "secret"
default[:chef_task_server]['stats_enabled'] = false
default[:chef_task_server]['statsd_addr'] = "localhost:8125"
default[:chef_task_server]['statsd_type'] = "standard"
default[:chef_task_server]['admin_key'] = "changeme"
default[:chef_task_server]['exchange'] = "events"
default[:chef_task_server]['rabbitmq_url'] = "amqp://guest:guest@localhost:5672/"