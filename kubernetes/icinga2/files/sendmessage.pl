#!/usr/bin/perl
#
# Copyright (c) 2001 SymLABS <symlabs@symlabs.com>, All Rights Reserved.
# See README for license. NO WARRANTY.
#
# 15.3.2001, Sampo Kellomaki <sampo@iki.fi>
# July, 2001, J-Phone specific experimentation and hacks
#             by Felix Gaehtgens <felix@symlabs.com>
# 1.8.2001, Checked in CVS and clarified, Sampo Kellomaki <sampo@symlabs.com>
# $Id: sendmessage.pl,v 1.4 2001/09/28 20:08:25 sampo Exp $
#
# Send a message given on command line
#
# Test Net::SMPP in ESME role
#
# Usage: ./sendmessage.pl *message*

use Net::SMPP;
use Data::Dumper;

$trace            = 1;
$Net::SMPP::trace = 1;
$sysid            = '9321';
$pw               = 'ttmlmb';
$host             = '10.51.37.196';
$port             = 6200;
$ton              = '1';
$npi              = '1';
$SrcAdrTON        = '1';
$SrcAdrNPI        = '1';
$DestAdrTON       = '1';
$DestAdrNPI       = '1';
$data_coding      = 'UCS2';
$facil            = 0x00010003;       # NF_PDC | GF_PVCY
my $phone = $ARGV[0];
my $mymsg = $ARGV[1];

foreach $argnum ( 2 .. $#ARGV ) {

    $mymsg = join( " ", $mymsg, $ARGV[$argnum] );

}
my $multimsg = 0;
if ( length($mymsg) > 128 ) {
    $multimsg = 1;
}
$vers    = 0x4;    #3.4
$if_vers = 0x33;

### Connect and bind

( $smpp, $resp ) = Net::SMPP->new_transmitter(
    $host,

    #    smpp_version => $vers,
    #    interface_version => $if_vers,
    system_id       => $sysid,
    password        => $pw,
    addr_ton        => $ton,
    addr_npi        => $npi,
    source_addr_ton => $SrcAdrTON,
    source_addr_npi => $SrcAdrNPI,
    dest_addr_ton   => $DestAdrTON,
    dest_addr_npi   => $DestAdrNPI,
    system_type     => 'client01',

    #    facilities_mask => $facil,
    port => $port,
) or die "Can't contact server: $!";

###
### Typical session in synchronous mode
###

warn "Sending submit_sm";
$multimsg = 0;
$sent_no  = 0;
$origref  = $ref = 160;    #160
$textptr  = 0;
$finished = 0;

# $esmclass=0x00;
# $esmclass=0x40 x1xxxxxx;
$esmclass = 0x40;

#print "FELIX: Now checking length of string: ".length ($mymsg)."\n";
# $msgtext = $mymsg;
printf "Now sending: (multimsg = %.8x) (len: %d) %s\n", $multimsg,
  length($msgtext), $msgtext;
$msgref = sprintf "%.8d", $ref;
print "MESSAGE REFERENCE: $msgref   REF= $ref\n";

if ( length($mymsg) > 128 ) {
    $multimsg_maxparts = int( length($mymsg) / 128 );
    if ( length($mymsg) % 128 ) {
        $multimsg_maxparts++;
    }
    $multimsg_curpart = 1;
    print "multimsgsparts: $multimsg_maxparts\n";
}
$msgtext = substr( $mymsg, 0, 128, "" );
while ( length($msgtext) ) {

    ### See V4, p. 77

    if ($multimsg_curpart) {
        @udh_ar = map { sprintf "%x", $_ } $origref, $multimsg_maxparts,
          $multimsg_curpart;
        $udh = pack( "hhhhhh", 0x05, 0x00, 0x03, @udh_ar );
        $multimsg =
          pack( "nCC", $origref, $multimsg_curpart, $multimsg_maxparts );
        printf STDERR "\nI AM SETTING MULTIPART: len=%d\n", multimsg;
    }
    else {
        $multimsg = undef;
    }
    printf "Now sending: (multimsg = %.8x) (len: %d) %s\n", $multimsg,
      length($msgtext), $msgtext;
    $msgref = sprintf "%.8d", $ref;
    print "MESSAGE REFERENCE: $msgref   REF= $ref\n";

    $resp = $smpp->submit_sm(    #message_class=>0,
        protocol_id      => 0x00,              # telematic_interworking
        validity_period  => '',                # "default"
        source_addr_ton  => $SrcAdrTON,
        source_addr      => '9321',
        destination_addr => $phone,
        esm_class        => $esmclass,
        data_coding      => $data_coding,
        short_message    => $udh . $msgtext,

        #  PDC_MessageClass => "\x20\x00",
        #  PDC_PresentationOption => "\x01\xff\xff\xff",
        #  PDC_AlertMechanism => "\x01",
        #  PDC_Teleservice => "\x04",
        #  PDC_MultiPartMessage => $multimsg,
        #  PDC_PredefinedMsg => "\0",
        #  PVCY_AuthenticationStr => "\x01\x00\x00",

        #  source_subaddress => "\x01\x00\x00",  # PDC_Originator_Subaddr
        #  dest_subaddress => "\x01\x00\x00"
    ) or die "Response indicated error: ";

    $multimsg_curpart++;
    $msgtext = substr( $mymsg, 0, 128, "" );
    $ref++;
}

# warn "################";

# warn Dumper $resp;

# warn "################";

$resp = $smpp->unbind() or die "teo";

# warn Dumper $resp;
warn "Done.";

#EOF