$packages = ["erlang-base", "erlang-reltool", "make"]
package { $packages:
  ensure => latest
}

file { "/var/www/":
  ensure => "directory",
  recurse => true,
  owner => "deploy",
  group => "deploy"
}

class rebar($base_path = "/tmp/rebar") {

  $rebar_dependencies = ["git-core"]
  package { "rebar dependencies":
    name => $rebar_dependencies,
    ensure => installed
  }

  exec { "rebar fetch":
    command => "git clone git://github.com/rebar/rebar.git ${base_path}",
    path => ["/usr/bin", "/bin"],
    creates => $base_path,
    notify => Exec["rebar make"]
  }

  exec { "rebar make":
    cwd => $base_path,
    # command => "/bin/bash -c 'cd $base_path && make'",
    command => "make",
    environment => ['HOME=/root'],
    path => ["/usr/bin", "/bin"],
    require => [ Package["erlang-base"], Package["erlang-reltool"], Package["make"], Exec["rebar fetch"] ],
    creates => "${base_path}/rebar",
    # refreshonly => true
  }

  file { "rebar install":
    path => "/usr/local/bin/rebar",
    source => "${base_path}/rebar",
    mode => "a+x",
    require => Exec["rebar make"]
  }
}

include rebar

file { "gossiperl service":
  path => "/etc/init.d/gossiperl",
  content => template("init.script"),
  mode => "0755"
}

file { "gossiperl defaults":
  path => "/etc/default/gossiperl",
  content => template("default"),
}
