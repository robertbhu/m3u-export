#!/usr/bin/perl
$in_body = 0;

opendir DIR, "." or die "unable to read directory: $!";
@files = grep /\.m3u$/i, readdir DIR;
if ($#files < 0) {
    print STDERR "Oops, no .m3u files found\n";
    print STDERR "press Enter to terminate...\n";
    $_ = <>;
}
@input = @files;
closedir DIR;
$outputdir = "o";
mkdir($outputdir,777);

print "Processing...\n";
while ($FILE = shift @files) {
    open(FILEHANDLE, $FILE) or warn "Can't open $FILE: $!\n";
    $in_body = 0;
    $i++;
    $outputfile = $outputdir . "\\" . $FILE;
#    print $outputfile;
    open(OUTPUTHANDLE, ">$outputfile") or warn "Can't open $FILE for write: $!\n";
    
    LINE: while (<FILEHANDLE>) {

#	print OUTPUTHANDLE "Debug0: ", $_, "\n"; # print current line

	chomp;		# remove newline
	s/E:\\music\\iTunes\\iTunes Music\\Music\\iTunes\\iTunes Media\\Music/../i;
	tr#\\#/#;
	print OUTPUTHANDLE $_, "\n"; # print current line
    }
}

print $i, " files processed, results in directory ", $outputdir, "\n";
