# == Class samba::server::params
#
class samba::server::params {
  case $facts['os']['family'] {
    'Redhat': { $service_name = 'smb' }
    'Debian': {
      case $facts['os']['name'] {
        'Debian': {
          if (versioncmp($facts['os']['release']['major'], '8') >= 0) {
            $service_name = 'smbd'
          } else {
            $service_name = 'samba'
          }
        }
        'Ubuntu': {
          $service_name = 'smbd'
          $nmbd_name = 'nmbd'
        }
        default: { $service_name = 'samba' }
      }
    }
    'Gentoo': { $service_name = 'samba' }
    'Archlinux': {
      $service_name = 'smbd'
      $nmbd_name = 'nmbd'
    }

    # Currently Gentoo has $::osfamily = "Linux". This should change in
    # Factor 1.7.0 <http://projects.puppetlabs.com/issues/17029>, so
    # adding workaround.
    'Linux': {
      case $facts['os']['name'] {
        'Gentoo':  { $service_name = 'samba' }
        default: { fail("${facts['os']['name']} is not supported by this module.") }
      }
    }
    default: { fail("${facts['os']['family']} is not supported by this module.") }
  }
}
