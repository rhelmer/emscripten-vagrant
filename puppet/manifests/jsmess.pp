$jsmess_deps = ["git", "openjdk-6-jdk", "libsdl1.2debian", "libsdl1.2-dev", "libsdl-ttf2.0-0", "libfontconfig1-dev", "gtk+-2.0", "gconf-2.0"]

$clang_version = "3.2"
$clang_dir = "clang+llvm-${clang_version}-x86-linux-ubuntu-12.04"
$clang_filename = "${clang_dir}.tar.gz"
$clang_url = "http://llvm.org/releases/${clang_version}/${clang_filename}"

class { 'nodejs':
  version => 'stable',
}

class vcsrepo { 
  
}

class jsmess {

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
    
    vcsrepo { "/home/vagrant/src/jsmess":
      alias => "git-clone-jsmess",
      ensure => latest,
      provider => git,
      source => 'git://github.com/jsmess/jsmess.git',
      revision => 'master',
      require => Package[$jsmess_deps],
      owner => "vagrant"
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
       require => Vcsrepo['git-clone-jsmess'],
       force => true,
    }

    file { '/home/vagrant/src/jsmess/games':
       ensure => 'link',
       target => '/vagrant/games',
       require => Vcsrepo['git-clone-jsmess'],
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

}

group { "puppet":
  ensure => "present",
}

include nodejs
include vcsrepo
include jsmess

