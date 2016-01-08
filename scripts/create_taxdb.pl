#!/usr/bin/perl

use warnings;      # avoid d'oh! bugs
use strict;        # avoid d'oh! bugs
$|=1;
use Data::Dumper;  # easy printing, sometimes only used during coding

use Bio::Perl;
use Bio::LITE::Taxonomy;
use Bio::LITE::Taxonomy::NCBI;
use Bio::LITE::Taxonomy::NCBI::Gi2taxid qw/new_dict/;

new_dict (in => "/data/db/taxonomy/gi_taxid_nucl.dmp",
          out => "/data/db/taxonomy/gi_taxid_nucl.bin");

