#!/usr/bin/perl

use strict;
while(1){
  sleep(10);
  my $m=`acpi -b`;
  ## print "m is: $m";
  $m =~ s/(Battery 0: \w*,) (\d+)%(.*)/$2/ge;
  if ($m < 20) {
    ## print("now m is:".$m."\n");
    my $call = "ratpoison -c \"echo "."Battery at ".$2."% ".$3."   \"";
    system("$call")
  } 
}
