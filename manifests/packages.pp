# == Class: windows_logstash::packages
#
class windows_logstash::packages {
  
  # Copy logstash-1.4.2.zip to Temp
  file { 'C:/Windows/Temp/logstash-1.4.2.zip':
    source             => 'puppet:///modules/windows_logstash/logstash-1.4.2.zip',
    source_permissions => ignore,
  }
  
  # Extract logstash zip file to c:\ProgramData
  exec { "Extract zip file":
    command   => "7z.exe x -y \"c:\\Windows\\Temp\\logstash-1.4.2.zip\"",
    path      => "C:/Program Files/7-Zip;${::path}",
    cwd       => "C:/ProgramData",
    creates   => "C:/ProgramData/logstash-1.4.2",
    logoutput => on_failure,
    require   => File['C:/Windows/Temp/logstash-1.4.2.zip'],
  }
  
  # Install javaruntime
  package { javaruntime:
    ensure   => installed,
    provider => 'chocolatey',
  }
  
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
