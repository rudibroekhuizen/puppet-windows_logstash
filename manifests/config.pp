# == Class: windows_logstash::config
#
class windows_logstash::config {

  # Cleanup jffi*.tmp files, caused by jruby bug, see https://github.com/jruby/jruby/issues/1237
  tidy { 'jffi_tmp':
    path => "c:/Windows/Temp/",
    recurse => 1,
    matches => [ "jffi*.*" ]
  }

}
