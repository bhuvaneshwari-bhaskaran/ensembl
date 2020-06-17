#!/usr/bin/env perl

# Script to convert the chromosome coordinates from GRCh37 to GrCh38 and vice-versa
# usage perl convertor.pl <seq_region_name> <source_version> <target_version> <start> <end> <strand>

use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Bio::EnsEMBL::DBSQL::DBAdaptor;

my $coord_name = 'chromosome';
my $seq_region_name = $ARGV[0];
my $source_version = $ARGV[1];
my $target_version = $ARGV[2];
my $start = $ARGV[3];
my $end = $ARGV[4];
my $strand = $ARGV[5];
my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
    -host => 'ensembldb.ensembl.org',
    -user => 'anonymous',
    -port => 3337
);


my $db_adaptor = $registry->get_DBAdaptor( 'Human', 'Core', 'assemblymapper');
my $mapper_adaptor = $db_adaptor->get_AssemblyMapperAdaptor();
my $cs_adaptor  = $db_adaptor->get_CoordSystemAdaptor();

my $chr_source = $cs_adaptor->fetch_by_name($coord_name, $source_version);
my $chr_target = $cs_adaptor->fetch_by_name($coord_name, $target_version);
my $asm_mapper = $mapper_adaptor->fetch_by_CoordSystems( $chr_source, $chr_target );

# Map to targe coordinate system from source coordinate system.
my @coords = $asm_mapper->map( $seq_region_name, $start, $end, $strand, $chr_source );

foreach my $coord (@coords){
    printf("%s Coordinates\n==================\nCoordinate System: %s\nSequence Region: %s\nSequence Region Start: %s\nSequence Region End: %s\nStrand: %s\n",
    $target_version, $coord->coord_system->name, $coord->name, $coord->start, $coord->end, $coord->strand);
}
exit;