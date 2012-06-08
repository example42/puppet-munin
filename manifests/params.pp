# Class: munin::params
#
# This class defines default parameters used by the main module class munin
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to munin class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class munin::params {

  ### Module Specific parameters
  $server = '127.0.0.1'
  $server_local = false
  $grouplogic = ''
  $extra_plugins = false
  $autoconfigure = true

  $package_perlcidr = $::operatingsystem ? {
    /(?i:Centos|Redhat|Scientific)/ => $::operatingsystemrelease ? {
      4        => 'perl-Net-CIDR-Lite',
      default  => 'perl-Net-CIDR',
    },
    default => 'libnet-cidr-perl',
  }

  $package_server = $::operatingsystem ? {
    default => 'munin',
  }

  $config_file_server = '/etc/munin/munin.conf'
  $template_server = 'munin/munin.conf.erb'

  $include_dir = '/etc/munin/munin-conf.d'

  $conf_dir_plugins = '/etc/munin/plugin-conf.d'

  $conf_dir_active_plugins = '/etc/munin/plugins/'

  $web_dir = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => '/var/cache/munin/www',
    default                   => '/var/www/html/munin',
  }

  $plugins_dir = $::operatingsystem ? {
    default => '/usr/share/munin/plugins',
  }

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'munin-node',
  }

  $service = $::operatingsystem ? {
    default => 'munin-node',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    /(?i:Ubuntu)/ => $::operatingsystemrelease ? {
      '12.04'  => 'munin',
      default => 'munin-node',
    },
    default => 'munin-node',
  }

  $process_args = $::operatingsystem ? {
    /(?i:Ubuntu)/ => $::operatingsystemrelease ? {
      '12.04'  => 'munin-node',
      default => '',
    },
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'munin',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/munin',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/munin/munin-node.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/munin',
    default                   => '/etc/sysconfig/munin',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/munin/munin-node.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/munin',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/munin',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/munin/munin.log',
  }

  $port = '4949'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = 'false'
  $template = 'munin/munin-node.conf.erb'
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
