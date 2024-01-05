#!/usr/bin/env perl

#  Copyright (C) 2009-2022 Amba Kulkarni (ambapradeep@gmail.com)
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either
#  version 2 of the License, or (at your option) any later
#  version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.



=head1  call_gen.pl


=head1 DESCRIPTION

This script invokes the Hindi generator.

=head1 EXAMPLES

This is invoked within a shell program after doing the agreement.

=head1 AUTHORS

Amba Kulkarni

ambapradeep@gmail.com

License: GPL

=cut

$SCLINSTALLDIR=$ARGV[0];
$| = 1;

while($in = <STDIN>){

 chomp($in);
 print $in; # We do not add the field separator \t, since it has already been added by the previous programme agreement.pl

 @f = split(/\t/,$in);

 if($in) {
	 #open (TMP,">>/tmp/bb");
	 #print TMP $f[14],"\n";
	 #close (TMP);
   my $out = &call_gen($f[14]);
   print $out;
 } 
 print "\n";
}

sub call_gen{
my($in) = @_;


my($out,$str,$ans);
   $out = "";
   $str = "";
   $ans = "";
      $in =~ s/\/$//;
      ($rt,$cat,$gen,$num,$per,$tam) = split(/ /,$in);
      #print "TAM = $tam\n";

      if($rt =~ /^(.*-)([^\-]+)$/) { $pUrva = $1; $rt = $2;} else {$pUrva = "";}
      # ($rt,$tam) = split(/:/,&handle_hE($rt,$tam));
      #($rt,$cat) = split(/:/,&handle_Bavaw($rt,$cat));
      #($rt,$tam) = split(/:/,&handle_apanA($rt,$tam));
      if($rt =~ /\-/) {$rt =~ s/\-/__/g;}
 
      #$out = `$SCLINSTALLDIR/MT/prog/hn/word_gen/test/new_gen.out $show $not $rt $cat $gen $num $per $tam`;
      
      ##########################
      #open (TMP, ">/tmp/mar_in");
      if($cat eq "v") {
         $tam =~ s/tam://;
         if ( $tam eq "wa_asa_I" ) {
		print $rt."wa_";
         $str = "asa<cat:$cat><tam:I><gender:$gen><number:$num><person:$per>";
      }
      elsif ($tam eq "Ne_sATI") {
         $str = "$rt<cat:n><cat:v><suff:Ne><parsarg:sATI>";
         
         }
      else {
               $str = "$rt<cat:$cat><tam:$tam><gender:$gen><number:$num><person:$per>";
               }
              }
      if($cat eq "P") {
         $tam =~ s/tam://;
	 if ($rt eq "mI") { $gen = "any";}
	 elsif ($rt eq "wU") { $gen = "any";}
	 elsif ($rt eq "wo") { $gen = "m";}
	 elsif ($rt eq "wI") { $gen = "f";}
	 elsif ($rt eq "we") { $gen = "n";}
	 #elsif ($rt eq "hA") { $gen = "n";}
         $str = "$rt<cat:$cat><gender:$gen><number:$num><parsarg:$tam>";
      }
      if($cat eq "avy") {
         $tam =~ s/tam://;
         if (($rt eq "Aja") || ($rt eq "nehamI") || ($rt eq "Aja")) {
             $str = "$rt<cat:n><gender:m><number:eka><parsarg:0>";
             }
             
             else {
         $str = "$rt<cat:$cat>";
      }
      }
      if($cat eq "n") {
         $tam =~ s/tam://;
         $str = "$rt<cat:$cat><gender:$gen><number:$num><parsarg:$tam>";
      }
	
      $ans = "echo '$str' | lt-proc -ct /home/amruta/satemrmt-scl/MT/prog/mar/word_gen/mar_gen.bin";
      open (TMP,">>/tmp/xx");
      print TMP $ans,"\n";
      close(TMP);
      $out = `$ans`;
      open (TMP,">>/tmp/yy");
      print TMP $out;
      close(TMP);

      $out =~ s/__/-/g;
      $out = $pUrva.$out;
$out;
}
1;


sub handle_hE{

 my($rt,$tam) = @_;
 my($ans);

 if((($rt =~ /_ho1/) || ($rt eq "ho1"))&& ($tam eq "wA_hE")) {
     $rt =~ s/_ho1/_hE/;
     $rt =~ s/ho1/hE/;
     $tam = "hE";
 }
 elsif((($rt =~ /_ho1/) || ($rt eq "ho1"))&& ($tam eq "yA")) {
     $rt =~ s/_ho1/_WA/;
     $rt =~ s/ho1/WA/;
     $tam = "WA";
 }
 elsif(($rt =~ /_ho1/) || ($rt eq "ho1")){
   $rt =~ s/_ho1/_ho/;
   $rt =~ s/ho1/ho/;
 }
$ans = $rt.":".$tam;
}
1;

sub handle_Bavaw{

 my($rt, $cat) = @_;
 my($ans);

 if(($rt eq "Apa") && ($cat eq "n")) {
     $rt = "Apa";
     $cat = "P";
 }

$ans = $rt.":".$cat;
}
1;

sub handle_apanA{

 my($rt,$tam) = @_;
 my($ans);

 if(($rt eq "apanA") && ($tam eq "kA")) {
     $rt = "apanA";
     $tam = "0";
 }
 if(($rt eq "apanA") && ($tam eq "kI")) {
     $rt = "apanI";
     $tam = "0";
 }
 if(($rt eq "apanA") && ($tam eq "ke")) {
     $rt = "apanA";
     $tam = "1";
 }
$ans = $rt.":".$tam;
}
1;
