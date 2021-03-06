class maverick_web::maverick_docs (
    $server_hostname = $maverick_web::server_fqdn,
) {
    
    /*
    # Install maverick docs
    oncevcsrepo { "github-maverick_docs":
        gitsource   => "https://github.com/goodrobots/maverick",
        dest        => "/srv/maverick/software/maverick-docs",
        revision    => "gh-pages",
    }
    */
    file { "/srv/maverick/software/maverick-docs":
        ensure      => absent,
        force       => true,
    }

    nginx::resource::location { "web-maverick-docs":
        ensure          => present,
        ssl             => true,
        location        => "/web/maverick-docs",
        location_alias  => "/srv/maverick/software/maverick/docs",
        index_files     => ["maverick.html"], # index.html is for github hosted docs
        server          => $server_hostname,
        require         => [ Class["maverick_gcs::fcs"], Class["nginx"] ],
    }
    
}