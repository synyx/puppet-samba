# == Class samba::server::install
#
class samba::server::install {
  if fact('os.family') == 'Debian' {
    apt::source { 'samba':
      location => 'https://apt.van-belle.nl/debian buster-samba413',
      release  => 'main contrib non-free',
      repos    => '',
      key      => {
        id     => '3843C126C596738E7C8775B5E6F6A3C7EB7A89CF',
        source => 'https://apt.van-belle.nl/louis-van-belle.gpg-key.asc',
      },
      include  => {
        src => false,
        deb => true,
      },
    }
  }
  package { 'samba':
    ensure => installed
  }
}
