#! /usr/bin/perl -w
################################################################################
# Copyright 2004-2011 MERETHIS
# Centreon is developped by : Julien Mathis and Romain Le Merlus under
# GPL Licence 2.0.
# 
# This program is free software; you can redistribute it and/or modify it under 
# the terms of the GNU General Public License as published by the Free Software 
# Foundation ; either version 2 of the License.
# 
# This program is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
# PARTICULAR PURPOSE. See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along with 
# this program; if not, see <http://www.gnu.org/licenses>.
# 
# Linking this program statically or dynamically with other modules is making a 
# combined work based on this program. Thus, the terms and conditions of the GNU 
# General Public License cover the whole combination.
# 
# As a special exception, the copyright holders of this program give MERETHIS 
# permission to link this program with independent modules to produce an executable, 
# regardless of the license terms of these independent modules, and to copy and 
# distribute the resulting executable under terms of MERETHIS choice, provided that 
# MERETHIS also meet, for each linked independent module, the terms  and conditions 
# of the license of that module. An independent module is a module which is not 
# derived from this program. If you modify this program, you may extend this 
# exception to your version of the program, but you are not obliged to do so. If you
# do not wish to do so, delete this exception statement from your version.
# 
# For more information : contact@centreon.com
# 
# SVN : $URL$
# SVN : $Id$
#
####################################################################################
#
# Plugin init
#

use strict;
use FindBin;

use vars qw($PROGNAME);
use Getopt::Long;
use vars qw($opt_h $opt_s $opt_o);

#################################################
### Plugin var init
##
$PROGNAME = "$0";

sub print_help ();
sub print_usage ();

Getopt::Long::Configure('bundling');
GetOptions
    ("h"   => \$opt_h, "help"         => \$opt_h,
     "s=s" => \$opt_s, "status=s"     => \$opt_s,
     "o=s" => \$opt_o, "output=s"     => \$opt_o);


##################################################
#### Verify Options
##

if ($opt_h) {
    print_help();
    exit 0;
}

if (!defined($opt_s)) {
    print_usage && exit 0;
}
if ($opt_s ne "0" && $opt_s ne "1" && $opt_s ne "2" && $opt_s ne "3") {
    print_usage;
    exit 0;
} 
if (!$opt_o) {
    $opt_o = "OK";
}

#################################################
## result
#

$opt_o .= "\n";
print $opt_o;
exit $opt_s;

sub print_usage () {
    print "Usage: $PROGNAME -s 2 -o 'This service is CRITICAL'\n";
    print "   -s (--status)     Value between 0 and 3 to return the Nagios status (Required)\n";
    print "                             0 returns OK status\n";
    print "                             1 returns WARNING status\n";
    print "                             2 returns CRITICAL status\n";
    print "                             3 returns UNKNOWN status\n";
    print "   -o (--output)     Output message that must be returned (Default: 'OK')\n";
    print "   -h (--help)       Usage help\n";
}

sub print_help () {
    print "##############################################\n";
    print "#    Copyright (c) 2004-2011 Centreon        #\n";
    print "#    Bugs to http://forge.centreon.com/      #\n";
    print "##############################################\n";
    print_usage();
    print "\n";
