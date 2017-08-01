class dynomite::install inherits dynomite {
  if $dynomite::manage_package {
    package { $dynomite::package_name:
      ensure => $dynomite::package_ensure,
    }
  }
}