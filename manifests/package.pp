# == Class: windows_logstash::package
#
class windows_logstash::package {
  
  #https://code.google.com/p/rely-ops/source/browse/ops_logging/manifests/windows/shipper.pp
  
  # Copy logstash-1.4.2.zip to Temp
  #file { 'C:/Windows/Temp/logstash-1.4.2.zip':
  #  source             => 'puppet:///modules/windows_logstash/logstash-1.4.2.zip',
  #  source_permissions => ignore,
  #}
  download_file { 'logstash-1.4.2.zip' :
    url                   => 'http://download.elastic.co/logstash/logstash/logstash-1.4.2.zip',
    destination_directory => 'C:/Windows/Temp',
    #require              => File[ 'c:\temp' ],
  }
  
  
  # better solution: windows::unzip, https://forge.puppetlabs.com/counsyl/windows
  # Extract logstash zip file to c:\ProgramData
  exec { "Extract zip file":
    command   => "7z.exe x -y \"c:\\Windows\\Temp\\logstash-1.4.2.zip\"",
    path      => "C:/Program Files/7-Zip;${::path}",
    cwd       => "C:/ProgramData",
    creates   => "C:/ProgramData/logstash-1.4.2",
    logoutput => on_failure,
    require   => Download_file['logstash-1.4.2.zip'],
  }
  
  # Install javaruntime
  package { javaruntime:
    ensure   => installed,
    provider => 'chocolatey',
  }
  
 # gem install jruby-win32ole -i C:\ProgramData\logstash-1.4.2\vendor\bundle\jruby\1.9  
 package { jruby-win32ole:
    ensure          => installed,
    provider        => gem,
    install_options => [{"--install-dir" => "C:/ProgramData/logstash-1.4.2/vendor/bundle/jruby/1.9"}],
    require         => Exec['Extract zip file'],
  } 
  
  #windows_env { 'JAVA_HOME=%ProgramFiles%\Java\jre7':
  #  type    => REG_EXPAND_SZ,
  #}
  
}
