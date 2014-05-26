node default {
  # class { "rubybuild":
  #   ruby_version => "2.0.0-p451",
  #   version_in_dir => false,
  #   ruby_install_dir => "/opt/rubies/ruby-2.0.0-p451"
  # }
  
  exec { "install chruby":
    command => "/bin/bash -c 'cd /tmp && wget -O chruby-0.3.8.tar.gz https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz && tar -xvzf chruby-0.3.8.tar.gz && cd chruby-0.3.8/ && make install'",
    creates => "/usr/local/share/chruby/chruby.sh",
    # require => [ Class["rubybuild"] ]
  }
  
  file { "/etc/profile.d/chruby.sh":
    ensure => present,
    owner => root,
    group => root,
    mode => 0755,
    content => "source /usr/local/share/chruby/chruby.sh
  chruby 2.0.0-p451
  ",
    require => [ Exec["install chruby"] ]
  }
  
  exec { "install bundler":
    command => "/bin/bash -c 'source /usr/local/share/chruby/chruby.sh && chruby ruby-2.0.0-p451 && gem install bundler'",
    # require => Class["rubybuild"],
    creates => "/opt/rubies/ruby-2.0.0-p451/bin/bundle"
  }

}
