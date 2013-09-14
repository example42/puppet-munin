# Configures munin as fast-cgi for either apache or nginx
#
# [*fcgi_runlevels*]
#   The runleves which should have a fcgi container
#
# [*fcgi_command*]
#   The command to spawn a fcgi container
#
class munin::cgi (
  $fcgi_runlevels   = params_lookup('fcgi_runlevels'),
  $fcgi_command     = params_lookup('fcgi_command'),
  $fcgi_reload_init = params_lookup('fcgi_reload_init'),) inherits munin {
  if !defined(Package['spawn-fcgi']) {
    package { 'spawn-fcgi': ensure => $munin::manage_file; }
  }

  inittab { 'mufc': # MUnin Fast Cgi
    ensure   => $munin::manage_file,
    runlevel => $munin::cgi::fcgi_runlevels,
    action   => 'respawn',
    command  => $munin::cgi::fcgi_command,
    require  => Package['spawn-fcgi'];
  }

  if $fcgi_reload_init {
    exec { 'munin::cgi::reload inittab':
      command     => '/sbin/init q',
      refreshonly => true,
      subscribe   => Inittab['mufc'];
    }
  }
}
