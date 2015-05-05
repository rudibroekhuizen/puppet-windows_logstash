#
#
define logstash::configfile(
  $source = undef,
  $order  = 10,
) {

  file_fragment { $name:
    tag     => "LS_CONFIG_${::fqdn}",
    source  => $source,
    order   => $order,
    before  => [ File_concat['ls-config'] ]
  }

}
