# == Class: windows_logstash::package
#
class windows_logstash::package (
  $package_url,
  ) {

# Download logstash package
  wget::fetch { "https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.zip":
    source      => "https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.zip",
    destination => "c:\Windows\Temp",
    timeout     => 0,
    verbose     => false,
    #require     => File["/home/${username}"],
  }

}
