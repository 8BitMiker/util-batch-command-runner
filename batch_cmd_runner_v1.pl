#!/usr/bin/perl

use strict;
use warnings;
use 5.18.0;
use Data::Dumper;
$|++;

# Run Commands One After One

my $cmd = [];
my $time = time;

my $eval = ($ARGV[0] && -f $ARGV[0] && -T $ARGV[0]) ? 'scalar <>' : 'scalar <DATA>'; 

say $eval =~ m~<>$~ ? "File detected running commands" : "No file detected using defaults";

my $line; # temporary line
LOOP: 
{	
	last unless $line = eval $eval;
	chomp $line;
	
	push @{$cmd}, $_; # Not required but may be useful later?
	say qq~Running: ${line}~;
	system qq`${line}`;
	warn "Somthing went wrong with:\n\t${line}\n" if $?;
	
	redo LOOP;
}

warn qq~All Done!\n~;


# print Dumper $cmd; # debug

__END__
cp /var/www/drupal/8/themes/default/css/style.css /var/www/drupal/8/themes/default/css/style_$(perl -e 'print time').css
scp d3ntistry@142.150.115.27:/var/www/drupal/8/themes/default/css/style.css /var/www/drupal/8/themes/default/css/
scp -r -v d3ntistry@142.150.115.27:/var/www/drupal/8/themes/default/css/images /var/www/drupal/8/themes/default/css/
drush --root=/var/www/drupal/8 cr @sites
drush --root=/var/www/drupal/8 ard @sites
df -h /
