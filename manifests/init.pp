# == Class: windows_logstash
#
# Full description of class windows_logstash here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'windows_logstash':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class windows_logstash (
  $configfile_hash = { 'logstash.conf' => { content => 'input { generator { count => 1 } } output { file { path => "C:/Windows/Temp/logstash.output" } }'
                                          },
                     },
  ){

  # Install package
  class { 'windows_logstash::package':
  }

  # Apply other config stuff
  class { 'windows_logstash::config':
    require => Class ["windows_logstash::package"],
  }
  
  # Create logstash configfiles
  class { 'windows_logstash::configfile':
    require => Class ["windows_logstash::config"],
  }

  # Install Logstash as a service
  class { 'windows_logstash::service':
    require => Class ["windows_logstash::configfile"],
  }


}
