# == Class: windows_logstash::packages
#
class windows_logstash::packages (
  # $package_url,
  ) {
  
  # Install javaruntime
  package { javaruntime:
    ensure   => installed,
    provider => 'chocolatey',
  }
  
  # Extract logstash zip file
  exec { "Extract zip file":
    command   => "7z.exe x -y \"$zipfilesFolder\\logstash-1.4.2.zip\"",
    path      => "C:/Program Files/7-Zip;${::path}",
    cwd       => $installFolder,
    creates   => "$installFolder/database/setup.exe",
    logoutput => on_failure,
  }
  
}
