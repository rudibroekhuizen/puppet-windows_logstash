# == Define: windows_logstash::defines::configfile
#
define windows_logstash::defines::configfile (
  $content = template("windows_logstash/logstash.conf.erb"),
) {

  file { $title:
    ensure  => present,
    path    => "C:/ProgramData/logstash-1.4.2/conf.d/${title}",
    content => $content,
  }

}
