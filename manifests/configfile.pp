# == Class: windows_logstash::configfile
#
class windows_logstash::configfile {

  create_resources('windows_logstash::defines::configfile', $windows_logstash::configfile_hash)
  
}
