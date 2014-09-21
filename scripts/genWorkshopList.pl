# author:       frode klevstul ( frode at klevstul dot com # www.klevstul.com )
# started:      14.09.20
# description:  generates a list of workshop maps, in mapgroup layout, for cs:go

use strict;

# update the $workshop_dir directory, to be the directory where workshop maps are stored on the server (full path)
my $workshop_dir    = "/home/steam/steamcmd/csgo/csgo/maps/workshop";

# declarations
my @dirs;
my $dir;
my @files;
my $file;

# get all sub directories in the workshop directory
opendir (D, "$workshop_dir");
@dirs = grep /\w/, readdir(D);
closedir(D);

# go through all workshop sub directories
foreach $dir (@dirs){
    # get all .bsp (map) files
    opendir (D, "$workshop_dir/$dir");
    @files = grep /.bsp/, readdir(D);
    closedir(D);

    # print a warning if no map files were found
    if ((scalar @files) == 0){
        print "WARNING: \"$dir\" workshop map directory is empty! Remember to comment out this map from \"subscribed_file_ids.txt\".\n";
    }

    # print to screen
    foreach $file (@files){
        $file =~ s{\.[^.]+$}{}; # remove extension
        print "\"workshop/" . $dir . "/" . $file . "\"   \"\"\n";
    }
}
