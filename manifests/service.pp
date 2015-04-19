# == Class: windows_logstash::service
#
class windows_logstash::service {

  # Install Non-Sucking Service Manager
  package { nssm:
    ensure   => installed,
    provider => 'chocolatey',
  }

nssm install Logstash C:\ProgramData\logstash-1.4.2\bin\logstash.bat "agent -f logstash-16.conf"

