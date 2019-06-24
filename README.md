# GeCKO  <img src="man/figures/logo.png" align="right" alt="" width="120" />
  
<br></br>    
<!-- badges: start -->
[![Build Status](https://travis-ci.org/dbrookeUAB/GeCKO.svg?branch=master)](https://travis-ci.org/dbrookeUAB/GeCKO)[![Developmental Status](https://travis-ci.org/dbrookeUAB/GeCKO.svg?branch=Developmental)](https://travis-ci.org/dbrookeUAB/GeCKO)[![Code Size](https://img.shields.io/github/languages/code-size/dbrookeUAB/GeCKO.svg)](https://github.com/dbrookeUAB/GeCKO)
[![Last Commit](https://img.shields.io/github/last-commit/dbrookeUAB/GeCKO.svg)](https://github.com/dbrookeUAB/GeCKO/commits/master)
[![Codecov test coverage](https://codecov.io/gh/dbrookeUAB/GeCKO/branch/master/graph/badge.svg)](https://codecov.io/gh/dbrookeUAB/GeCKO?branch=master)
<!-- badges: end -->

The goal of GeCKO is to ...

## Installation

``` r
# install.packages("remotes")
remotes::install_github("dbrookeUAB/GeCKO")
```

## Basic Usage

Make sure to cite this paper. 
[O. Shalem et al., Genome-scale CRISPR-Cas9 knockout screening in human cells. Science (80-. ). 343, 84–87 (2014)](https://science.sciencemag.org/content/343/6166/84)


[Zhang Lab Website](http://genome-engineering.org)

### Loading gRNA sequences from the GeCKO Library


``` r
library(GeCKO)
human <- get_library(species = "human") 

# not run
# mouse <- get_library(species = "mouse")

human
#>             gene_id          UID                  seq
#>      1:        A1BG HGLibA_00001 GTCGCTGAGCTCCGATTCGA
#>      2:        A1BG HGLibA_00002 ACCTGTAGTTGCCGGCGTGC
#>      3:        A1BG HGLibA_00003 CGTCAGCGTCACATTGGCCA
#>      4:        A1BG HGLibB_00001 CAATGTGACGCTGACGTGCC
#>      5:        A1BG HGLibB_00002 TGTCTCCGCAGGTGTCACCT
#>     ---                                              
#> 123407: hsa-mir-99a HGLibA_64379 ATCTACGGGTTTATGCCAAT
#> 123408: hsa-mir-99b HGLibA_64380 CACCCGTAGAACCGACCTTG
#> 123409: hsa-mir-99b HGLibA_64381 CCCGTAGAACCGACCTTGCG
#> 123410: hsa-mir-99b HGLibA_64382 CGCACACAAGCTCGTGTCTG
#> 123411: hsa-mir-99b HGLibA_64383 TCGTGTCTGTGGGTCCGTGT
```

#### Looking for a specific gene

``` r
library(GeCKO)
human <- get_library(species = "human") 

# using data.table notation DT[i,j,by]
single_gene<- human[gene_id=="GAPDH"]
single_gene
#>    gene_id          UID                  seq
#> 1:   GAPDH HGLibA_18613 TTCCTCACCTGATGATCTTG
#> 2:   GAPDH HGLibA_18614 TCTGCTGTAGGCTCATTTGC
#> 3:   GAPDH HGLibA_18615 TTCCACTCACTCCTGGAAGA
#> 4:   GAPDH HGLibB_18588 ACTCACCCCAGCCTTCTCCA
#> 5:   GAPDH HGLibB_18589 CACTGGCGTCTTCACCACCA
#> 6:   GAPDH HGLibB_18590 TTCCAATATGATTCCACCCA
```

#### Retrieving Multiple Genes


``` r
library(GeCKO)
human <- get_library(species = "human") 
many_genes<-human[gene_id %in% c("GAPDH","TP53", "CCND1")]
man_genes
#>     gene_id          UID                  seq
#>  1:   CCND1 HGLibA_08071 CGAAGGTCTGCGCGTGTTTG
#>  2:   CCND1 HGLibA_08072 CTTGCACACCCACCGACGTG
#>  3:   CCND1 HGLibA_08073 GATGTCCACGTCCCGCACGT
#>  4:   CCND1 HGLibB_08064 GTTCGTGGCCTCTAAGATGA
#>  5:   CCND1 HGLibB_08065 TGTTTGTTCTCCTCCGCCTC
#>  6:   CCND1 HGLibB_08066 GAAGCGTGTGAGGCGGTAGT
#>  7:   GAPDH HGLibA_18613 TTCCTCACCTGATGATCTTG
#>  8:   GAPDH HGLibA_18614 TCTGCTGTAGGCTCATTTGC
#>  9:   GAPDH HGLibA_18615 TTCCACTCACTCCTGGAAGA
#> 10:   GAPDH HGLibB_18588 ACTCACCCCAGCCTTCTCCA
#> 11:   GAPDH HGLibB_18589 CACTGGCGTCTTCACCACCA
#> 12:   GAPDH HGLibB_18590 TTCCAATATGATTCCACCCA
#> 13:    TP53 HGLibA_51047 CCGGTTCATGCCGCCCATGC
#> 14:    TP53 HGLibA_51048 CGCTATCTGAGCAGCGCTCA
#> 15:    TP53 HGLibA_51049 CCCCGGACGATATTGAACAA
#> 16:    TP53 HGLibB_50984 GAGCGCTGCTCAGATAGCGA
#> 17:    TP53 HGLibB_50985 CCCCTTGCCGTCCCAAGCAA
#> 18:    TP53 HGLibB_50986 ACTTCCTGAAAACAACGTTC
```

``` r
library(GeCKO)
human <- get_library(species = "human") 
single_gene<- human[gene_id=="GAPDH"]
# simple example
make_gRNAs(seqs = "TGTCAACGGGCGGCCACTGC",gene = "PAX6")
#>    gene_id                  seq          oligo-1 (5'->3')
#> 1:    PAX6 TGTCAACGGGCGGCCACTGC CACCGTGTCAACGGGCGGCCACTGC
#>             oligo-2 (5'->3')
#> 1: AAACGCAGTGGCCGCCCGTTGACAC
```




``` r
library(GeCKO)
human <- get_library(species = "human") 
single_gene<- human[gene_id=="GAPDH"]
# using data.tables directly for a single gene
make_gRNAs(single_gene[,seq], gene = single_gene[,gene_id])
#>    gene_id                  seq          oligo-1 (5'->3')
#> 1:   GAPDH TTCCTCACCTGATGATCTTG CACCGTTCCTCACCTGATGATCTTG
#> 2:   GAPDH TCTGCTGTAGGCTCATTTGC CACCGTCTGCTGTAGGCTCATTTGC
#> 3:   GAPDH TTCCACTCACTCCTGGAAGA CACCGTTCCACTCACTCCTGGAAGA
#> 4:   GAPDH ACTCACCCCAGCCTTCTCCA CACCGACTCACCCCAGCCTTCTCCA
#> 5:   GAPDH CACTGGCGTCTTCACCACCA CACCGCACTGGCGTCTTCACCACCA
#> 6:   GAPDH TTCCAATATGATTCCACCCA CACCGTTCCAATATGATTCCACCCA
#>             oligo-2 (5'->3')
#> 1: AAACCAAGATCATCAGGTGAGGAAC
#> 2: AAACGCAAATGAGCCTACAGCAGAC
#> 3: AAACTCTTCCAGGAGTGAGTGGAAC
#> 4: AAACTGGAGAAGGCTGGGGTGAGTC
#> 5: AAACTGGTGGTGAAGACGCCAGTGC
#> 6: AAACTGGGTGGAATCATATTGGAAC
```


``` r
library(GeCKO)
human <- get_library(species = "human") 

many_genes<-human[gene_id %in% c("GAPDH","TP53", "CCND1")]
# using data.tables directly for a multiple genes
make_gRNAs(many_genes[,seq], gene = many_genes[,gene_id])
#>     gene_id                  seq          oligo-1 (5'->3')
#>  1:   CCND1 CGAAGGTCTGCGCGTGTTTG CACCGCGAAGGTCTGCGCGTGTTTG
#>  2:   CCND1 CTTGCACACCCACCGACGTG CACCGCTTGCACACCCACCGACGTG
#>  3:   CCND1 GATGTCCACGTCCCGCACGT CACCGGATGTCCACGTCCCGCACGT
#>  4:   CCND1 GTTCGTGGCCTCTAAGATGA CACCGGTTCGTGGCCTCTAAGATGA
#>  5:   CCND1 TGTTTGTTCTCCTCCGCCTC CACCGTGTTTGTTCTCCTCCGCCTC
#>  6:   CCND1 GAAGCGTGTGAGGCGGTAGT CACCGGAAGCGTGTGAGGCGGTAGT
#>  7:   GAPDH TTCCTCACCTGATGATCTTG CACCGTTCCTCACCTGATGATCTTG
#>  8:   GAPDH TCTGCTGTAGGCTCATTTGC CACCGTCTGCTGTAGGCTCATTTGC
#>  9:   GAPDH TTCCACTCACTCCTGGAAGA CACCGTTCCACTCACTCCTGGAAGA
#> 10:   GAPDH ACTCACCCCAGCCTTCTCCA CACCGACTCACCCCAGCCTTCTCCA
#> 11:   GAPDH CACTGGCGTCTTCACCACCA CACCGCACTGGCGTCTTCACCACCA
#> 12:   GAPDH TTCCAATATGATTCCACCCA CACCGTTCCAATATGATTCCACCCA
#> 13:    TP53 CCGGTTCATGCCGCCCATGC CACCGCCGGTTCATGCCGCCCATGC
#> 14:    TP53 CGCTATCTGAGCAGCGCTCA CACCGCGCTATCTGAGCAGCGCTCA
#> 15:    TP53 CCCCGGACGATATTGAACAA CACCGCCCCGGACGATATTGAACAA
#> 16:    TP53 GAGCGCTGCTCAGATAGCGA CACCGGAGCGCTGCTCAGATAGCGA
#> 17:    TP53 CCCCTTGCCGTCCCAAGCAA CACCGCCCCTTGCCGTCCCAAGCAA
#> 18:    TP53 ACTTCCTGAAAACAACGTTC CACCGACTTCCTGAAAACAACGTTC
#>              oligo-2 (5'->3')
#>  1: AAACCAAACACGCGCAGACCTTCGC
#>  2: AAACCACGTCGGTGGGTGTGCAAGC
#>  3: AAACACGTGCGGGACGTGGACATCC
#>  4: AAACTCATCTTAGAGGCCACGAACC
#>  5: AAACGAGGCGGAGGAGAACAAACAC
#>  6: AAACACTACCGCCTCACACGCTTCC
#>  7: AAACCAAGATCATCAGGTGAGGAAC
#>  8: AAACGCAAATGAGCCTACAGCAGAC
#>  9: AAACTCTTCCAGGAGTGAGTGGAAC
#> 10: AAACTGGAGAAGGCTGGGGTGAGTC
#> 11: AAACTGGTGGTGAAGACGCCAGTGC
#> 12: AAACTGGGTGGAATCATATTGGAAC
#> 13: AAACGCATGGGCGGCATGAACCGGC
#> 14: AAACTGAGCGCTGCTCAGATAGCGC
#> 15: AAACTTGTTCAATATCGTCCGGGGC
#> 16: AAACTCGCTATCTGAGCAGCGCTCC
#> 17: AAACTTGCTTGGGACGGCAAGGGGC
#> 18: AAACGAACGTTGTTTTCAGGAAGTC
```


## Using custom 5' and 3' sequences for gRNA oligos

``` r
# add2 uses a list input
library(GeCKO)
make_gRNAs(seqs = "TGTCAACGGGCGGCCACTGC",gene = "PAX6",
            add2 = list(
              seq1_5p = "new",
              seq1_3p = "ends",
              seq2_5p = "for", 
              seq2_3p = "both")
            )
#>    gene_id                  seq            oligo-1 (5'->3')
#> 1:    PAX6 TGTCAACGGGCGGCCACTGC newTGTCAACGGGCGGCCACTGCends
#>               oligo-2 (5'->3')
#> 1: forGCAGTGGCCGCCCGTTGACAboth
```


