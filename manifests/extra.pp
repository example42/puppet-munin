# class munin::extra
# 
# This class provides some custom extra munin-plugins
# To use it just include it, or cipy and paste parts of it
# in your manifests
#
# Usage:
# include munin::extra
#
class munin::extra {

  munin::plugin { 'apache_activity':
    source => 'munin/plugins/apache_activity',
  }

  munin::plugin { 'lighttpd':
    source => 'munin/plugins/lighttpd',
  }

  munin::plugin { 'puppet_runs':
    source => 'munin/plugins/puppet_runs',
  }

}
