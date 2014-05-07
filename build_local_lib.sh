#!/bin/sh
set -e

if [ ! -f local-lib-2.000011.tar.gz ];then
  wget http://cpan.metacpan.org/authors/id/E/ET/ETHER/local-lib-2.000011.tar.gz
fi
if [ ! -d local-lib-2.000011 ];then
  tar xzf local-lib-2.000011.tar.gz
fi

if [ ! -d perl5 ];then
    cd local-lib-2.000011
    perl Makefile.PL --bootstrap=$(pwd)/../perl5
    make
    make install
fi

PKG="$(pwd)/.."

eval "$(perl -I$PKG/perl5 -Mlocal::lib=$PKG/perl5)"

cpan -i Net::Amazon::EC2 File::Slurp LWP Digest::HMAC Params::Validate XML::Simple Moose Crypt::SSLeay DateTime::Locale DateTime::TimeZone DBD::Mysql IO::Socket::SSL

