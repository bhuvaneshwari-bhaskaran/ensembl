#!/usr/bin/env perl

# Script to convert the chromosome coordinates from GRCh37 to GrCh38 and vice-versa
# usage perl GRCh37_to_GRCh38.pl <seq_region_name> <start> <end> <strand>

use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Bio::EnsEMBL::DBSQL::DBAdaptor;
use Bio::EnsEMBL::Utils::AssemblyProjector;

my $coord_name = 'chromosome';
my $seq_region_name = $ARGV[0];
my $start = $ARGV[1];
my $end = $ARGV[2];

# connect to GRCh37 database
my $dba_old = new Bio::EnsEMBL::DBSQL::DBAdaptor(
    -host   => 'ensembldb.ensembl.org',
    -port   => 3337,
    -user   => 'anonymous',
    -dbname => 'homo_sapiens_core_100_37',
    -group  => 'core_old',
);

# connect to GRCh38 database
my $dba_new = new Bio::EnsEMBL::DBSQL::DBAdaptor(
    -host   => 'ensembldb.ensembl.org',
    -port   => 3306,
    -user   => 'anonymous',
    -dbname => 'homo_sapiens_core_100_38',
    -group  => 'core_new',
);

my $assembly_projector = Bio::EnsEMBL::Utils::AssemblyProjector->new(
    -OLD_ASSEMBLY    => 'GRCh37',
    -NEW_ASSEMBLY    => 'GRCh38',
    -ADAPTOR         => $dba_new,
);

# fetch the slice by region
my $slice_adaptor = $dba_old->get_SliceAdaptor;
my $slice = $slice_adaptor->fetch_by_region( $coord_name, $seq_region_name, $start, $end, 1, 'GRCh37');
my $new_slice = $assembly_projector->old_to_new($slice);

print "Converting the coordinates GRCh37 to GRCh38 ...\n";
printf("GRCh38 Coordinates\n==================\nVersion: GRCh38\nCoordinate System: %s\nSequence Region: %s\nSequence Region Start: %s\nSequence Region End: %s\n",
$new_slice->coord_system_name, $new_slice->seq_region_name, $new_slice->seq_region_start, $new_slice->seq_region_end);

exit;