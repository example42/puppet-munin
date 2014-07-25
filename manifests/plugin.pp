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
# Define the configuration file of an existing plugin in-line:
# munin::plugin { 'nginx':
#   content_config => "[nginx*]\nenv.url http://localhost/nginx_status";
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
  $source         = '',
  $source_config  = '',
  $linkplugins    = '',
  $content        = '',
  $content_config = '',
  $enable         = true ) {

  $ensure = bool2ensure($enable)

  include munin

  if $source {
    file { "Munin_plugin_${name}":
      ensure  => $ensure,
      path    => "${munin::plugins_dir}/${name}",
      owner   => root,
      group   => root,
      mode    => '0755',
      require => Package['munin-node'],
      notify  => Service['munin-node'],
      source  => "puppet:///modules/${source}",
    }

    if $linkplugins == true {
      file  { "/etc/munin/plugins/${name}":
        ensure => link,
        target => "${munin::plugins_dir}/${name}",
      }
    }
  }

  if $content {
    file { "Munin_plugin_${name}":
      ensure  => $ensure,
      path    => "${munin::plugins_dir}/${name}",
      owner   => root,
      group   => root,
      mode    => '0755',
      require => Package['munin-node'],
      notify  => Service['munin-node'],
      content => $content,
    }

    if $linkplugins == true {
      file  { "/etc/munin/plugins/${name}":
        ensure => link,
        target => "${munin::plugins_dir}/${name}",
      }
    }
  }

  if $source_config {
    file { "Munin_plugin_conf_${name}":
      ensure  => $ensure,
      path    => "${munin::conf_dir_plugins}/${name}",
      owner   => root,
      group   => root,
      mode    => '0644',
      require => Package['munin-node'],
      notify  => Service['munin-node'],
      source  => "puppet:///modules/${source_config}",
    }
  }

  if $content_config {
    file { "Munin_plugin_conf_${name}":
      ensure  => $ensure,
      path    => "${munin::conf_dir_plugins}/${name}",
      owner   => root,
      group   => root,
      mode    => '0644',
      require => Package['munin-node'],
      notify  => Service['munin-node'],
      content => $content_config,
    }
  }
}
