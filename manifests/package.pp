# == Class: windows_logstash::package
#
class windows_logstash::package (
  # $package_url,
  ) {
  
  exec { "Extract zip file":
    command   => "7z.exe x -y \"$zipfilesFolder\\p10404530_112030_MSWIN-x86-64_1of7.zip\"",
    path      => "C:/Program Files/7-Zip;${::path}",
    cwd       => $installFolder,
    creates   => "$installFolder/database/setup.exe",
    logoutput => on_failure,
  }
  
}
