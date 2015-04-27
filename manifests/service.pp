# == Class: windows_logstash::service
#
class windows_logstash::service {

 # Install Non-Sucking Service Manager
  package { nssm:
    ensure   => installed,
    provider => 'chocolatey'
  }

  exec { 'Logstash as a service':
    command => 'c:\windows\nssm.exe install Logstash3 C:\ProgramData\logstash-1.4.2\bin\logstash.bat agent -f logstash.conf",
    cwd     => 'c:\windows',
    unless  => 'c:\Windows\System32\cmd.exe /c sc query logstash',
    require => Package[ 'nssm' ]
  }

  service { 'Logstash3':
    ensure  => running,
    require => Exec[ 'Logstash as a service' ]
  }
  
}
