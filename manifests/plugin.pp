# Define: munin::plugin
#
# Adds or configures a Munin plugin
#
# Usage:
# Define the configuration file of an existing plugin:
# munin::plugin { 'squid':
#   source_config => 'example42/munin/squid-config',
# }
#
# Provide a custom plugin:
# munin::plugin { 'redis':
#   source => 'example42/munin/redis',
# }
#
# Provide a custom plugin with a custom configuration:
# munin::plugin { 'redis':
#   source        => 'example42/munin/redis',
#   source_config => 'example42/munin/redis-conf',
# }
#
define munin::plugin (
  $source = '',
  $source_config = '',
  $enable = true ) {

  include munin

  $ensure = bool2ensure($enable)

  if $source {
    file { "Munin_plugin_${name}":
      path    => "${munin::plugins_dir}/${name}",
      owner   => root,
      group   => root,
      mode    => '0755',
      ensure  => $ensure,
      require => Package['munin-node'],
      notify  => Service['munin-node'],
      source  => "puppet:///$source",
    }
  }

  if $source_config {
    file { "Munin_plugin_conf_${name}":
      path    => "${munin::conf_dir_plugins}/${name}",
      owner   => root,
      group   => root,
      mode    => '0644',
      ensure  => $ensure,
      require => Package['munin-node'],
      notify  => Service['munin-node'],
      source  => "puppet:///$source_config",
    }
  }
}
