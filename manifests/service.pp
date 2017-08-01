class dynomite::service inherits dynomite {
  if $dynomite::manage_service {
    service { $dynomite::service_name:
      ensure => running,
      enable => true,
    }
  }
}