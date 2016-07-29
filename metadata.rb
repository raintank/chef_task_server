name             'chef_task_server'
maintainer       'Raintank, Inc.'
maintainer_email 'cookbooks@raintank.io'
license          'Apache 2.0'
description      'Installs/Configures chef_task_server'
long_description 'Installs/Configures chef_task_server'
version          '0.1.0'

depends 'chef_base', '~> 0.1.9'
depends 'logrotate', '~> 1.9.1'
depends 'packagecloud', '~> 0.2.0'
