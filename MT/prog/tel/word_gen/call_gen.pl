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
   my $out = &call_gen($f[14],"ON","NOT");
   print $out,"\t";
## next lines are for karwari prayoga output
   my $out = &call_gen($f[15],"ON","NOT");
   print $out;
 } 
 print "\n";
}

sub call_gen{
my($in,$show,$not) = @_;

my($out);
      $in =~ s/\/$//;
      ($rt,$cat,$gen,$num,$per,$tam) = split(/ /,$in);
      if($rt =~ /^(.*-)([^\-]+)$/) { $pUrva = $1; $rt = $2;} else {$pUrva = "";}
      ($rt,$tam) = split(/:/,&handle_hE($rt,$tam));
      ($rt,$cat) = split(/:/,&handle_Bavaw($rt,$cat));
      ($rt,$tam) = split(/:/,&handle_apanA($rt,$tam));
	  #if($rt =~ /\-/) {$rt =~ s/\-/__/g;}
      if($rt =~ /.\-./) {$rt =~ s/\-/__/g;} 
 
      #$out = `$SCLINSTALLDIR/MT/prog/hn/word_gen/test/new_gen.out $show $not $rt $cat $gen $num $per $tam`;
	  $num=~ s/s/sg/;
	  $num=~ s/p/pl/; # temporarily added

      ##########################
      open (TMP, ">/tmp/tel_in");
      open (TMP1, ">>/tmp/tel_in1");
      	
      #mA_vAdu, where we need generation for vAdu.
      if($rt=~/(.*)_(.*)/){
	$rt=$2;
	$rt1=$1;
	$flag=1;
	}

      # open (TMP, ">>/tmp/tel_in"); # to get info of all words
	if ($cat eq "v") {
		$cat = "verb";
		if (($gen eq "f")&&($num eq "sg")){
		$gen = "fn";
		}
		if (($gen eq "n")&&($num eq "sg")){
		$gen = "fn";
		}
		if (($gen eq "m")&&($num eq "pl")){
		$gen = "mf";
		}
		if (($gen eq "f")&&($num eq "pl")){
		$gen = "mf";
		}
		#ke gacCawaH .
		if($tam eq "wU" && $gen=~/m|f|n/) {
			$tam ="wunn";
		}
		##tams which dont require gen/num/per
		chomp($tam);
		if($tam !~/^A$|^A_A$|^A_aMdi$|^A_alle$|^A_ani$|^A_annamAta$|^A_ata$|^A_e$|^A_le$|^A_leVMdi$|^A_o$|^A_rA$|^A_uta$|^AjFArWa$|^AjFArWa_ammA$|^AjFArWa_ayyA$|^AjFArWa_le$|^AjFArWa_manu$|^AjFArWa_rA$|^AjFArWa_ve$|^a$|^a_A$|^a_aMdi$|^a_alle$|^a_ani$|^a_annamAta$|^a_ata$|^a_e$|a_le$|^a_leVMdi$|^a_o$|^a_rA$|^a_uta$|^aku$|^iwi$|^iwi_A$|^iwi_aMdi$|^iwi_alle$|^iwi_ani$|^iwi_annamAta$|^iwi_ata$|^iwi_e$|^iwi_le$|^iwi_leVMdi$|iwi_o$|^iwi_rA$|^iwi_uta$|^uxu$|^uxu_A$|^uxu_aMdi$|^uxu_alle$|^uxu_ani$|^uxu_annamAta$|^uxu_ata$|^uxu_e$|^uxu_le$|^uxu_leVMdi$|^uxu_o$|^uxu_rA$|^uxu_uta$|^wA$|^wA_A$|^wA_aMdi$|^wA_alle$|^wA_ani$|^wA_annamAta$|^wA_ata$|^wA_e$|^wA_le$|^wA_leVMdi$|^wA_o$|^wA_rA$|^wA_uta$|^wunn$|^wunn_A$|^wunn_aMdi$|^wunn_alle$|^wunn_ani$|^wunn_annamAta$|^wunn_ata$|^wunn_e$|^wunn_le$|^wunn_leVMdi$|^wunn_o$|^wunn_rA$|^wunn_uta$|^xA$|^xA_A$|^xA_aMdi$|^xA_alle$|^xA_ani$|^xA_annamAta$|^xA_ata$|^xA_e$|^xA_le$|^xA_leVMdi$|^xA_o$|^xA_rA$|^xA_uta$/) {
			$gen = "any";
			$per = "any";
			$num = "any";
		}
		#veVlYlu<cat:v><gnp:3_pu_e><tam:wunn>
			#$gen=~ s/m/pu/;
			#$tam=~ s/tunn/wunn/;
			#if($gen=~/^m$|^f$|^n$/) {
			#			$per = "3";
			#}
			if ($per =~/^1$|^2$/) {
				$gen="any";
			}
			#if(($per=~/s/)&&($gen=~/pu/)){
			#$wrd="^".$rt."<cat:".$cat."><gnp:23\_".$num."><tam:".$tam.">\$"; 
			#}
			#if(($per=~/any/)&&($gen=~/any/)&&($num=~/any/)){
			#$wrd="^".$rt."<cat:".$cat."><gnp:any><tam:".$tam.">\$"; 
			#}
			#else{
				#$wrd="^".$rt."<cat:".$cat."><gnp:3\_".$gen."\_".$num."><tam:".$tam.">\$"; }
			$wrd="^".$rt."<lcat:".$cat."><gen:".$gen."><num:".$num."><per:".$per."><tam:".$tam."><suffix:".$tam.">\$"; 
		}
	elsif (($cat eq "n") || ($cat eq "P")) {
      		#^sIwani/sIwa<cat:n><num:eka><parsarg:ni>$
		$cat=~s/^n$/noun/g;
		$cat=~s/^P$/pronoun/g;
		$gen=~s/^m$|^n$|^f$/any/g; #for time being gender is considered any for vanaM
		$per=~s/a/any/g;
		
		if (($rt=~/^axi$|^ixi$|^exi/)){
			$gen = "fn";
		}
		#yuvAm agacCawAm. 
		if (($rt=~/^nuvvu$|/ && $num eq "pl")){
			$gen = "mIru";
		}
		#since "vAdu" and "vAlYlu" are different pdgm, this mapping is done Apr 21_2023, Param
		if (($rt eq "vAdu")&&($cat eq "noun")){
		$cat="pronoun"; $gen="m"; $per="3";
			if ($num eq "pl") { $gen ="mf"; $rt="vAlYlu"; }
		}
		if (($rt eq "awanu")&&($num eq "pl")){
		$rt="vAlYlu"; $cat="pronoun"; $gen="mf"; $per="3";
		}
		if (($rt eq "iwanu")&&($num eq "pl")){
		$rt="vIlYlu"; $cat="pronoun"; $gen="mf"; $per="3";
		}
		#AmeV P f p 3 0 wAH gacCanwi .
		if (($rt eq "AmeV")&&($num eq "pl")){
			$rt="vAlYlu";
		}
		if (($rt eq "ImeV")&&($num eq "pl")){
			$rt="vIlYlu";
		}
		#wAni gacCanwi .
		if (($rt eq "axi")&&($num eq "pl")){
			$rt="avi";
		}
		if (($rt eq "ixi")&&($num eq "pl")){
			$rt="ivi";
		}
		#vayaM gacCAmaH
		if (($rt eq "nuvvu")&&($num eq "pl")){
			$rt="mIru";
		}
		#vayaM gacCAmaH
		if (($rt eq "nenu")&&($num eq "pl")){
			$rt="manaM";
		}

		#$tam=~ s/2/ni/;
		#$wrd="^".$rt."<cat:".$cat."><num:".$num."><parsarg:".$tam.">\$"; 
		if (($cat eq "noun") ) {
			$wrd="^".$rt."<lcat:".$cat."><gen:".$gen."><num:".$num."><per:3><cm:".$tam."><suffix:".$tam.">\$"; }
		else {
			$wrd="^".$rt."<lcat:".$cat."><gen:".$gen."><num:".$num."><per:".$per."><cm:".$tam."><suffix:".$tam.">\$"; }
	}		#print "$wrd";
	else {
		$wrd=$rt."_".$tam;
	     }

		if (($cat eq "avy" && $rt=~/^[\.,_\-]$/) ) {
			$wrd=$rt;
		}
		
		#		saH awra AgacCawi.
		#sA awra AgacCawi.
		#waw awra AgacCawi.
		#saH wawra gacCawi.
		#sA wawra gacCawi.
		#aw wawra gacCawi.
		if (($cat eq "avy" && $rt=~/^(akkada|ikkada)$/ && $tam == "ki") ) {
			$wrd=$rt . "ki";
		}
	
	if ($flag == 1) { $wrd=$rt1."_".$wrd; $flag=0;}

      print TMP $wrd;
      print TMP1 $wrd;
      close (TMP);
      close (TMP1);
	  #system("/usr/bin/lt-proc -c -g  $SCLINSTALLDIR/MT/prog/tel/word_gen/telugu-apertium.mogen < /tmp/tel_in > /tmp/tel_out");
	  #system("/usr/bin/lt-proc -c -g  $SCLINSTALLDIR/MT/prog/tel/word_gen/tel_apertium_v1.1.mogen < /tmp/tel_in > /tmp/tel_out");
	  #updated new generator 17/04/2023
		  system("/usr/bin/lt-proc -c -g  $SCLINSTALLDIR/MT/prog/tel/word_gen/tel_apertium_v2.5.mogen < /tmp/tel_in > /tmp/tel_out");
		  open(TELGEN,"</tmp/tel_out");
		  $out=<TELGEN>;
		  $out=~s/\/.*//;
		  $out=~s/ ?NW ?//g;
		  chomp($out);
		  close(TELGEN);
  #genWrd;
  #   print $out;

      ########################
=head
=cut
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
