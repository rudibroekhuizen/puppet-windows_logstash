# == Class: windows_logstash::config
#
class windows_logstash::config {

  # Cleanup .tmp files, caused by jruby bug, see https://github.com/jruby/jruby/issues/1237
  tidy { 'resource title':
    path => "C:/Windows/Temp/",
    recurse => 1,
    matches => [ "jffi*.*" ]
  }

}
