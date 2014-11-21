# == Class: windows_logstash::service
#
class windows_logstash::service {

nssm install logstash C:\ProgramData\logstash.bat "agent -f logstash-16.conf"
