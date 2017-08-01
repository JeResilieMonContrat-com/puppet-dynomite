class dynomite::config inherits dynomite {
  file { $dynomite::config_file:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('dynomite/config.yml.erb'),
    require => Package[$dynomite::package_name],
    notify  => Service[$dynomite::service_name],
  }
}