# == Class: windows_logstash::service
#
class windows_logstash::service {

  # Install Non-Sucking Service Manager
  package { nssm:
    ensure   => installed,
    provider => 'chocolatey',
  }

  # Use nssm to create Logstash service  
  exec { 'Logstash as a service':
    command => 'C:/ProgramData/chocolatey/bin/nssm.exe install Logstash C:/ProgramData/logstash-1.4.2/bin/logstash.bat agent -f ../conf.d',
    unless  => "C:\\Windows\\System32\\cmd.exe /C sc query Logstash",
    require => Package[ 'nssm' ]
  }
  
  # Set nssm Logstash service stdout file
  exec { 'Logstash stdout':
    command => 'C:/ProgramData/chocolatey/bin/nssm.exe set Logstash AppStdout C:/ProgramData/logstash-1.4.2/nssm/stdout.log',
    #unless  => "C:\\Windows\\System32\\cmd.exe /C sc query Logstash",
    require => Exec[ 'Logstash as a service' ]
  }

  # Set nssm Logstash service sterr file
  exec { 'Logstash stderr':
    command => 'C:/ProgramData/chocolatey/bin/nssm.exe set Logstash AppStderr C:/ProgramData/logstash-1.4.2/nssm/stderr.log',
    #unless  => "C:\\Windows\\System32\\cmd.exe /C sc query Logstash",
    require => Exec[ 'Logstash as a service' ]
  }
  
  # Disable WM_CLOSE, WM_QUIT in the shutdown options. Without it, NSSM can't stop Logstash properly
  exec { 'Logstash shutdown options':
    command => 'C:/ProgramData/chocolatey/bin/nssm.exe set Logstash AppStopMethodSkip 6',
    #unless  => "C:\\Windows\\System32\\cmd.exe /C sc query Logstash",
    require => Exec[ 'Logstash as a service' ]
  } ->
  
  # Start service Logstash
  service { 'Logstash':
    ensure  => running,
    #require => [Exec[ 'Logstash as a service' ], Exec[ 'Logstash stdout' ]]
  }
  
}
