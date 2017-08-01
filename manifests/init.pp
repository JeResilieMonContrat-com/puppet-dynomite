# Class: dynomite
# ===========================
#
# Main class, includes all other classes :
# - dynomite::config : Create the main configuration file
# - dynomite::install : Install the required dynomite packages
# - dynomite::service : Setup, enable and start the dynomite service
#
# Parameters
# ----------
#
# @param manage_package [Boolean]
#   Install the dynomite package.
#   Default value : true
# @param package_name [Variant[String, Array[String]]]
#   The name of the dynomite package.
#   Default value : dynomite
# @param package_ensure [String]
#   The ensure parameter of the dynomite package.
#   Default value : present
# @param config_file [String]
#   The path to the dynomite configuration file.
#   Default value : /etc/dynomite/dynomite.yml
# @param manage_service [Boolean]
#   Manage or not the dynomite service.
#   Default value : true
# @param service_name [String]
#   The name of the dynomite service.
#   Default value : dynomite
#
# Dynomite specific parameters (see https://github.com/Netflix/dynomite/blob/v0.5.9/README.md#configuration) :
# @param datacenter [Optional[String]]
#   The datacenter config entry.
#   Default value : undef
# @param rack [Optional[String]]
#   The rack config entry.
#   Default value : undef
# @param dyn_listen_address [String]
#   The dyn_listen_address config entry.
#   Default value : 127.0.0.1
# @param dyn_listen_port [Integer[1, 65535]]]
#   The dyn_listen_port config entry.
#   Default value : 8101
# @param dyn_seed_provider [String]
#   The dyn_seed_provider config entry.
#   Default value : simple_provider
# @param dyn_seeds [Variant[Array[Hash], Array[String]]]
#   The dyn_seeds config entry, must be an array of Hash or strings
#   Example : { address => '10.0.0.1', port => 8101, rack => 'rack', dc => 'dc', token => '1234' }
#   Default value : []
# @param client_listen_address [String]
#   The client_listen_address config entry.
#   Default value : '127.0.0.1'
# @param client_listen_port [Integer[1, 65535]]
#   The client_listen_port config entry.
#   Default value : 8102
# @param servers [Variant[Array[Hash], Array[String]]]
#   The servers config entry, must be an array of Hash or strings.
#   Default value : [{ address => '127.0.0.1', port => 6379, weight => 1 }]
# @param token [String]
#   The token config entry.
#   Default value : undef
# @param secure_server_option [String]
#   The secure_server_option config entry.
#   Default value : none
# @param pem_key_file [Stdlib::Absolutepath]
#   The pem_key_file config entry.
#   Default value : /etc/dynomite/key.pem
# @param data_store [Enum['redis', 'memcached']]
#   The data_store config entry, must be one of 'redis' or 'memcached'.
#   Default value : redis (dynomite default)
# @param stat_listen_address [String]
#   The stat_listen_address config entry.
#   Default value : 127.0.0.1
# @param stat_listen_port [Integer[1, 65535]]
#   The stat_listen_port config entry.
#   Default value : 22222
# @param timeout [Optional[Integer]]
#   The timeout config entry.
#   Default value : undef
# @param max_msgs [Integer]
#   The max_msgs config entry.
#   Default value : 200000 (dynomite default)
# @param mbuf_size [Integer]
#   The mbuf_size config entry.
#   Default value : 16384 (dynomite default)
# @param write_consistency [Enum['DC_ONE', 'DC_QUORUM', 'DC_SAFE_QUORUM']]
#   The write_consistency config entry, must be one of DC_ONE, DC_QUORUM and DC_SAFE_QUORUM
#   Default value : DC_ONE (dynomite default)
#
#
# Examples
# --------
#
# class {
#   'dynomite':
#     token                 => '1234',
#     rack                  => 'rack1',
#     datacenter            => 'DC1',
#     dyn_listen_address    => '0.0.0.0',
#     client_listen_address => '0.0.0.0',
#     dyn_seeds             => [
#       {
#         address => '10.0.1.2',
#         port    => 8101,
#         rack    => 'rack2',
#         dc      => 'DC1',
#         token   => '1234',
#       },
#       {
#         address => '10.0.1.3',
#         port    => 8101,
#         rack    => 'rack3',
#         dc      => 'DC1',
#         token   => '1234',
#
#       }
#     ],
# }
#
#
# Copyright
# ---------
#
# Copyright 2017 Yoann Laissus <yoann.laissus@gmail.com>
#
class dynomite (
  Boolean $manage_package,
  Variant[String, Array[String]] $package_name,
  String $package_ensure,
  String $config_file,
  Boolean $manage_service,
  String $service_name,
  Optional[String] $datacenter,
  Optional[String] $rack,
  String $dyn_listen_address,
  Integer[1, 65535] $dyn_listen_port,
  String $dyn_seed_provider,
  Variant[Array[Hash], Array[String]] $dyn_seeds,
  String $client_listen_address,
  Integer[1, 65535] $client_listen_port,
  Variant[Array[Hash], Array[String]] $servers,
  String $token,
  String $secure_server_option,
  Stdlib::Absolutepath $pem_key_file,
  Enum['redis', 'memcached'] $data_store,
  String $stat_listen_address,
  Integer[1, 65535] $stat_listen_port,
  Optional[Integer] $timeout,
  Integer $max_msgs,
  Integer $mbuf_size,
  Enum['DC_ONE', 'DC_QUORUM', 'DC_SAFE_QUORUM'] $write_consistency,
) {
  include dynomite::install
  include dynomite::config
  include dynomite::service

  Class['::dynomite::install']
  -> Class['::dynomite::config']
  ~> Class['::dynomite::service']
}
