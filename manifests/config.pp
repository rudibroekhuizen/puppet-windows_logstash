# == Class: windows_logstash::config
#
class windows_logstash::config {
  
  # Create directory to store logstash config files
  file { "C:/ProgramData/logstash-1.4.2/conf.d":
    ensure             => directory,
    source_permissions => ignore,
  }

  # Create a basic Logstash config file logstash.conf. Logstash will apply every file in the conf.d directory.
  windows_logstash::defines::configfile { 'logstash.conf': 
    content => template("windows_logstash/logstash.conf.erb")
    require => File["C:/ProgramData/logstash-1.4.2/conf.d"],
  }
    
  # Cleanup jffi*.tmp files, caused by jruby bug, see https://github.com/jruby/jruby/issues/1237
  tidy { 'jffi_tmp':
    path    => "c:/Windows/Temp/",
    recurse => 1,
    matches => [ "jffi*.*" ]
  }

}
