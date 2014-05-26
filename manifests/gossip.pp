$packages = ["erlang-base"]
package { $packages:
  ensure => latest
}

file { "/var/www/":
  ensure => "directory",
  recurse => true,
  owner => "www-data",
  group => "www-data"
}
