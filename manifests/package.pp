# == Class: windows_logstash::package
#
class windows_logstash::package {
  
  # Install javaruntime
  package { javaruntime:
    ensure   => 7.0.75,
    provider => 'chocolatey',
  }
  
  # Download logstash using opentable/download_file module
  download_file { 'logstash-1.4.2.zip' :
    url                   => 'http://download.elastic.co/logstash/logstash/logstash-1.4.2.zip',
    destination_directory => 'C:/Windows/Temp',
    #require              => File[ 'c:\temp' ],
  }
  
  # Extract logstash zip file to c:\ProgramData
  # To try: windows::unzip, https://forge.puppetlabs.com/counsyl/windows
  exec { "Extract zip file":
    command   => "7z.exe x -y \"c:\\Windows\\Temp\\logstash-1.4.2.zip\"",
    path      => "C:/Program Files/7-Zip;${::path}",
    cwd       => "C:/ProgramData",
    creates   => "C:/ProgramData/logstash-1.4.2",
    logoutput => on_failure,
    require   => Download_file['logstash-1.4.2.zip'],
  }

 # gem install jruby-win32ole -i C:\ProgramData\logstash-1.4.2\vendor\bundle\jruby\1.9  
 package { jruby-win32ole:
    ensure          => installed,
    provider        => gem,
    install_options => [{"--install-dir" => "C:/ProgramData/logstash-1.4.2/vendor/bundle/jruby/1.9"}],
    require         => Exec['Extract zip file'],
  } 
  
  # Set JAVA_HOME
  windows_env { 'JAVA_HOME=%ProgramFiles%\Java\jre7':
    type => REG_EXPAND_SZ,
  }
  
}
