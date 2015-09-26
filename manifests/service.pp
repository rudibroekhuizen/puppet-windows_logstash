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
    require => Package[ 'nssm' ]
  }

  # Use nssm to create Logstash service  
  exec { 'Logstash as a service':
    command => 'nssm.exe install Logstash C:/ProgramData/logstash-1.4.2/bin/logstash.bat agent -f ../conf.d',
    unless  => "C:\\Windows\\System32\\cmd.exe /C sc query Logstash",
  }
  
  # Set stdout file
  exec { 'Logstash stdout':
    command => 'nssm.exe set Logstash AppStdout C:/ProgramData/logstash-1.4.2/nssm/stdout.log',
    unless  => "C:\\Windows\\System32\\cmd.exe /C sc query Logstash",
    require => Exec[ 'Logstash as a service' ]
  }

  # Start service Logstash
  service { 'Logstash':
    ensure  => running,
    require => [Exec[ 'Logstash as a service', Exec[ 'Logstash stdout' ]]
  }
  
}
