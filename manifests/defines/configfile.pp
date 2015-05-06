#
#
define windows_logstash::configfile (
  $source = undef,
  $order  = 10,
) {

  file { "logstash.conf":
    path => C:/ProgramData/logstash-1.4.2/conf.d/logstash.conf,
    content => "input",
  }

}
