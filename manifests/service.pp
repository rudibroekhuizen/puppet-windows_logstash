# == Class: windows_logstash::service
#
class windows_logstash::service {

  # Install Non-Sucking Service Manager
  package { nssm:
    ensure   => installed,
    provider => 'chocolatey',
  }

  # Settings for all nssm execs
  Exec { 
    path    => 'C:/ProgramData/chocolatey/bin',
    unless  => "C:\\Windows\\System32\\cmd.exe /C sc query Logstash",
    require => Package[ 'nssm' ]
  }

  # Use nssm to create Logstash service  
  exec { 'Logstash as a service':
    command => 'nssm.exe install Logstash C:/ProgramData/logstash-1.4.2/bin/logstash.bat agent -f ../conf.d',
  }

  # Start service Logstash
  service { 'Logstash':
    ensure  => running,
    require => Exec[ 'Logstash as a service' ]
  }
  
}
