# == Class: windows_logstash::service
#
class windows_logstash::service {

# Install Non-Sucking Service Manager
  package { nssm:
    ensure   => installed,
    provider => 'chocolatey'
  }

# Use nssm to create Logstash service  
  exec { 'Logstash as a service':
    command => 'C:/ProgramData/chocolatey/bin/nssm.exe install Logstash C:/ProgramData/logstash-1.4.2/bin/logstash.bat agent -f logstash.conf',
    unless  => 'c:/Windows/System32/cmd.exe /c sc query logstash',
    require => Package[ 'nssm' ]
  }

# Start service Logstash
  service { 'Logstash':
    ensure  => running,
    require => Exec[ 'Logstash as a service' ]
  }
  
}
