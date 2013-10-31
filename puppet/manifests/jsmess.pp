$jsmess_deps = ["git", "openjdk-6-jdk", "libsdl1.2debian", "libsdl-ttf2.0-0", "libfontconfig1-dev"]

$clang_version = "3.2"
$clang_dir = "clang+llvm-${clang_version}-x86-linux-ubuntu-12.04"
$clang_filename = "${clang_dir}.tar.gz"
$clang_url = "http://llvm.org/releases/${clang_version}/${clang_filename}"

class { 'nodejs':
  version => 'stable',
}

class jsmess {
    include nodejs

    file { "/home/vagrant/src":
        owner => vagrant,
        group => vagrant,
        mode  => 775,
        recurse=> false,
        ensure => directory
    }
    
    exec { "/usr/bin/apt-get update":
        alias => "apt-get-update",
        cwd => "/root",
        user => "root",
    }

    package {
      $jsmess_deps:
        ensure => "latest",
        require => Exec["apt-get-update"];

      "python-software-properties":
        ensure => "latest";
    }

    file { "/home/vagrant/.emscripten":
        owner => vagrant,
        group => vagrant,
        mode => 664,
        source => "/vagrant/puppet/files/dot.emscripten"
    }

    exec { "/usr/bin/git clone https://github.com/jsmess/jsmess/":
        alias => "git-clone-jsmess",
        cwd => "/home/vagrant/src",
        require => Package[$jsmess_deps],
        creates => "/home/vagrant/src/jsmess",
        timeout => 1200
    }

    exec { "/usr/bin/git submodule update --init --recursive":
        alias => "git-submodules-jsmess",
        cwd => "/home/vagrant/src/jsmess",
        require => Package[$jsmess_deps],
        creates => "/home/vagrant/src/jsmess/third_party/emscripten",
        timeout => 1200
    }

    file { '/home/vagrant/src/jsmess/bios':
       ensure => 'link',
       target => '/vagrant/bios',
       require => Exec['git-clone-jsmess'],
       force => true,
    }

    file { '/home/vagrant/src/jsmess/games':
       ensure => 'link',
       target => '/vagrant/games',
       require => Exec['git-clone-jsmess'],
       force => true,
    }

    exec { "/usr/bin/wget ${clang_url}":
        alias => "wget-clang-llvm",
        cwd => "/home/vagrant/src",
        creates => "/home/vagrant/src/${clang_filename}",
        environment => ["PWD=/home/vagrant/src", "HOME=/home/vagrant"],
    }

    exec { "/bin/tar -zxf ${clang_filename}":
        alias => "untar-clang-llvm",
        cwd => "/home/vagrant/src",
        environment => ["PWD=/home/vagrant/src", "HOME=/home/vagrant"],
        creates => "/home/vagrant/src/${clang_dir}",
        require => Exec["wget-clang-llvm"]
    }

    exec { "/usr/bin/git pull origin master":
        user => vagrant,
        alias => "git-pull-jsmess",
        cwd => "/home/vagrant/src/jsmess",
        require => Exec["git-clone-jsmess"]
    }

}

group { "puppet":
  ensure => "present",
}

include jsmess

