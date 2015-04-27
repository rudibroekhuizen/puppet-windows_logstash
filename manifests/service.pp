# == Class: windows_logstash::service
#
class windows_logstash::service {

windows_service { 'Logstash':
  ensure      => present,
  description => 'logstash',
  binary      => 'C:\ProgramData\logstash-1.4.2\bin\logstash.bat "agent -f logstash.conf',
}

  # Install Non-Sucking Service Manager
  package { nssm:
    ensure   => installed,
    provider => 'chocolatey',
  }

  exec { 'install ls service':
    command => 'c:\windows\nssm.exe install Logstash C:\ProgramData\logstash-1.4.2\bin\logstash.bat "agent -f logstash.conf",
    cwd     => 'c:\windows',
    unless  => 'c:\Windows\System32\cmd.exe /c sc query logstash',
    require => File[ 'nssm', 'c:\logstash\logstash.bat' ],
  }

  service { 'Logstash':
    ensure  => running,
    require => Exec[ 'install ls service' ],
  }
  
  

