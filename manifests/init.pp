class dnsmasq($only_dns = true, $puppet_ip = false) {
    package { "dnsmasq":
        ensure => present
    }

    file { "/etc/default/dnsmasq":
        content => template("dnsmasq/dnsmasq.default.erb"),
        owner => root,
        group => root,
        mode => 0644,
        notify => Exec["reload-dnsmasq"]
    }

    file { "/etc/dnsmasq.conf":
        content => template("dnsmasq/dnsmasq.conf.erb"),
        owner => root,
        group => root,
        mode => 0644,
        notify => Exec["reload-dnsmasq"]
    }

    file { "/etc/dnsmasq-additional-hosts":
        content => template("dnsmasq/dnsmasq-additional-hosts.erb"),
        owner => root,
        group => root,
        mode => 0644,
        notify => Exec["reload-dnsmasq"]
    }

    exec { "reload-dnsmasq":
        command => "/usr/sbin/service dnsmasq restart",
        refreshonly => true,
        require => Package[dnsmasq]
    }
}
