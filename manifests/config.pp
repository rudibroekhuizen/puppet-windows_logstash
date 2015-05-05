# == Class: windows_logstash::config
#
class windows_logstash::config {

  # Create the logstash config file logstash.conf using define configfile
  file_concat { 'ls-config':
    ensure  => 'present',
    tag     => "LS_CONFIG_${::fqdn}",
    path    => "C:/ProgramData/logstash/bin/logstash.conf",
    notify  => $notify_service,
  }

  # Cleanup jffi*.tmp files, caused by jruby bug, see https://github.com/jruby/jruby/issues/1237
  tidy { 'jffi_tmp':
    path => "c:/Windows/Temp/",
    recurse => 1,
    matches => [ "jffi*.*" ]
  }

}
