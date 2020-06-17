# ENSEMBL EXERCISE

## convertor.pl

<p>This script is to convert the Human Chromosome coordinates between GRCh37 to GRCh38 and vice-versa.</p>

Execute the convertor.pl using the below command,

`perl convertor.pl <seq_region_name> <source_version> <target_version> <start> <end> <strand>`

The list of arguments are,
- seq_region_name [e.g X]
- source_version [e.g GRCh37]
- target_version [e.g GRCh38]
- start [e.g 1000000]
- end [e.g 100100]
- strand  [e.g 1]

> e.g
>
> `perl convertor.pl X GRCh37 GRCh38 1000000 1000100 1`
>
>   GRCh38 Coordinates
>
>   ==================
>
>   Coordinate System: chromosome
>
>   Sequence Region: X
>
>   Sequence Region Start: 1039265
>
>   Sequence Region End: 1039365
>
>   Strand: 1

## GRCh37_to_GRCh38.pl (Alternative approach)

<p>We can also do the GRCh37 to GRCh38 conversion using the Assembly Projector. Right now it converts only GRCh37 to GRCh38.</p>

#### Advantages: 
- We can use the single adaptor to do the conversion.
- Extra options like MERGE_FRAGMENTS, CHECK_LENGTH.

#### Disadvantages:
- User needs to code to project other levels of feature  

> e.g
>
> `perl GRCh37_to_GRCh38.pl X 1000000 1000100 1`
>
> Converting the coordinates GRCh37 to GRCh38 ...
>
> GRCh38 Coordinates
>
> ==================
>
> Version: GRCh38
>
> Coordinate System: chromosome
> 
> Sequence Region: X
>
> Sequence Region Start: 1039265
>
> Sequence Region End: 1039365
