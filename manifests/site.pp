#Utworz usera

node 'centos.infovidematrix.pl' {

 
        $user  			= "testuser"
        $group          	= "testuser"


include useradd
include add_bin
}
# Dodaj niezbędny software
class add_bin {

$install = [ 'elfutils-libelf-devel',  'gcc-c++',  'libaio-devel', 'libstdc++-devel', 'sysstat', 'unixODBC', 'unixODBC-devel', 'libXtst', 'libaio', 'libtool-ltdl', 'libX11', 
		'libXext', 'libXi', 'libX11-common', 'libxcb', 'libXau', 'xorg-x11-xauth', 'libICE', 'libSM', 'libXmu', 'libXt', 'xorg-x11-server-utils', 'libXcursor', 'libXfixes', 
		'libXinerama', 'libXrandr', 'libXrender', 'libXxf86vm', 'libXxf86misc', 'libmcpp', 'mcpp', 'xorg-x11-utils', 'libXv', 'libXxf86dga', 'libdmx', 'compat-libcap1', 'compat-libstdc++-33.x86_64',
		 'unzip' ]

   package { $install:
     ensure  => present,
     #ensure  => absent,
   }
  }

class useradd {

file { "/home/$user":
     ensure => "absent",
     #owner  => "$user",
     #group  => "$group",
     mode   => 700,
     require =>  [ user[$user], group[$group] ],
     force => "true",
     }

group { "$group":
      ensure  => "absent",
      gid => 1002,
      }

user { "$user":
      #ensure => "present",
      ensure  => "absent",
      home => "/home/$user",
      name => "$user",
      shell => "/bin/bash",
      password => '$6$AE6MY2Ew$NUjwbjdkAGC/DAnjicXex/k6/9gLDsUSqNrS3YanuGU2kb8B5dfu/n6TvqEX4KlRWhQgCEzcb8ukjFxDNLGxk.',
      managehome => true,
      uid => 1002,
      gid => 1002,
      before => Group["$group"],
      }
}
