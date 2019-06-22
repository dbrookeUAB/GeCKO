# GeCKO

<!-- badges: start -->
<!-- badges: end -->

The goal of GeCKO is to ...

## Installation

``` r
# install.packages("remotes")
remotes::install_github("dbrookeUAB/GeCKO")
```

## Basic Usage

This is a basic example which shows you how to solve a common problem:

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



#### Making gRNA Oligos for [LentiCRISPR v2](https://www.addgene.org/52961/) or [LentiGuide-Puro](https://www.addgene.org/52963/)


``` r
# simple example
make_gRNAs(seqs = "TGTCAACGGGCGGCCACTGC",gene = "PAX6")
#>    gene_id  gRNA                 seqs     idt_id_F
#> 1:    PAX6 gRNA1 TGTCAACGGGCGGCCACTGC F-PAX6_gRNA1
#>             oligo-1 (5'->3')     idt_id_R          oligo-2 (5'->3')
#> 1: CACCGTGTCAACGGGCGGCCACTGC R-PAX6_gRNA1 AAACGCAGTGGCCGCCCGTTGACAC
```


```r
# using data.tables directly for a single gene
make_gRNAs(single_gene[,seq], gene = single_gene[,gene_id])
#>    gene_id  gRNA                 seqs      idt_id_F
#> 1:   GAPDH gRNA1 TTCCTCACCTGATGATCTTG F-GAPDH_gRNA1
#> 2:   GAPDH gRNA2 TCTGCTGTAGGCTCATTTGC F-GAPDH_gRNA2
#> 3:   GAPDH gRNA3 TTCCACTCACTCCTGGAAGA F-GAPDH_gRNA3
#> 4:   GAPDH gRNA4 ACTCACCCCAGCCTTCTCCA F-GAPDH_gRNA4
#> 5:   GAPDH gRNA5 CACTGGCGTCTTCACCACCA F-GAPDH_gRNA5
#> 6:   GAPDH gRNA6 TTCCAATATGATTCCACCCA F-GAPDH_gRNA6
#>             oligo-1 (5'->3')      idt_id_R          oligo-2 (5'->3')
#> 1: CACCGTTCCTCACCTGATGATCTTG R-GAPDH_gRNA1 AAACCAAGATCATCAGGTGAGGAAC
#> 2: CACCGTCTGCTGTAGGCTCATTTGC R-GAPDH_gRNA2 AAACGCAAATGAGCCTACAGCAGAC
#> 3: CACCGTTCCACTCACTCCTGGAAGA R-GAPDH_gRNA3 AAACTCTTCCAGGAGTGAGTGGAAC
#> 4: CACCGACTCACCCCAGCCTTCTCCA R-GAPDH_gRNA4 AAACTGGAGAAGGCTGGGGTGAGTC
#> 5: CACCGCACTGGCGTCTTCACCACCA R-GAPDH_gRNA5 AAACTGGTGGTGAAGACGCCAGTGC
#> 6: CACCGTTCCAATATGATTCCACCCA R-GAPDH_gRNA6 AAACTGGGTGGAATCATATTGGAAC
```


```r
# using data.tables directly for a multiple genes
make_gRNAs(many_genes[,seq], gene = many_genes[,gene_id])
#>     gene_id  gRNA                 seqs      idt_id_F
#>  1:   CCND1 gRNA1 CGAAGGTCTGCGCGTGTTTG F-CCND1_gRNA1
#>  2:   CCND1 gRNA2 CTTGCACACCCACCGACGTG F-CCND1_gRNA2
#>  3:   CCND1 gRNA3 GATGTCCACGTCCCGCACGT F-CCND1_gRNA3
#>  4:   CCND1 gRNA4 GTTCGTGGCCTCTAAGATGA F-CCND1_gRNA4
#>  5:   CCND1 gRNA5 TGTTTGTTCTCCTCCGCCTC F-CCND1_gRNA5
#>  6:   CCND1 gRNA6 GAAGCGTGTGAGGCGGTAGT F-CCND1_gRNA6
#>  7:   GAPDH gRNA1 TTCCTCACCTGATGATCTTG F-GAPDH_gRNA1
#>  8:   GAPDH gRNA2 TCTGCTGTAGGCTCATTTGC F-GAPDH_gRNA2
#>  9:   GAPDH gRNA3 TTCCACTCACTCCTGGAAGA F-GAPDH_gRNA3
#> 10:   GAPDH gRNA4 ACTCACCCCAGCCTTCTCCA F-GAPDH_gRNA4
#> 11:   GAPDH gRNA5 CACTGGCGTCTTCACCACCA F-GAPDH_gRNA5
#> 12:   GAPDH gRNA6 TTCCAATATGATTCCACCCA F-GAPDH_gRNA6
#> 13:    TP53 gRNA1 CCGGTTCATGCCGCCCATGC  F-TP53_gRNA1
#> 14:    TP53 gRNA2 CGCTATCTGAGCAGCGCTCA  F-TP53_gRNA2
#> 15:    TP53 gRNA3 CCCCGGACGATATTGAACAA  F-TP53_gRNA3
#> 16:    TP53 gRNA4 GAGCGCTGCTCAGATAGCGA  F-TP53_gRNA4
#> 17:    TP53 gRNA5 CCCCTTGCCGTCCCAAGCAA  F-TP53_gRNA5
#> 18:    TP53 gRNA6 ACTTCCTGAAAACAACGTTC  F-TP53_gRNA6
#>              oligo-1 (5'->3')      idt_id_R          oligo-2 (5'->3')
#>  1: CACCGCGAAGGTCTGCGCGTGTTTG R-CCND1_gRNA1 AAACCAAACACGCGCAGACCTTCGC
#>  2: CACCGACTCACCCCAGCCTTCTCCA R-CCND1_gRNA2 AAACTGGAGAAGGCTGGGGTGAGTC
#>  3: CACCGCACTGGCGTCTTCACCACCA R-CCND1_gRNA3 AAACTGGTGGTGAAGACGCCAGTGC
#>  4: CACCGTTCCAATATGATTCCACCCA R-CCND1_gRNA4 AAACTGGGTGGAATCATATTGGAAC
#>  5: CACCGCCGGTTCATGCCGCCCATGC R-CCND1_gRNA5 AAACGCATGGGCGGCATGAACCGGC
#>  6: CACCGCGCTATCTGAGCAGCGCTCA R-CCND1_gRNA6 AAACTGAGCGCTGCTCAGATAGCGC
#>  7: CACCGCCCCGGACGATATTGAACAA R-GAPDH_gRNA1 AAACTTGTTCAATATCGTCCGGGGC
#>  8: CACCGGAGCGCTGCTCAGATAGCGA R-GAPDH_gRNA2 AAACTCGCTATCTGAGCAGCGCTCC
#>  9: CACCGCCCCTTGCCGTCCCAAGCAA R-GAPDH_gRNA3 AAACTTGCTTGGGACGGCAAGGGGC
#> 10: CACCGACTTCCTGAAAACAACGTTC R-GAPDH_gRNA4 AAACGAACGTTGTTTTCAGGAAGTC
#> 11: CACCGCTTGCACACCCACCGACGTG R-GAPDH_gRNA5 AAACCACGTCGGTGGGTGTGCAAGC
#> 12: CACCGGATGTCCACGTCCCGCACGT R-GAPDH_gRNA6 AAACACGTGCGGGACGTGGACATCC
#> 13: CACCGGTTCGTGGCCTCTAAGATGA  R-TP53_gRNA1 AAACTCATCTTAGAGGCCACGAACC
#> 14: CACCGTGTTTGTTCTCCTCCGCCTC  R-TP53_gRNA2 AAACGAGGCGGAGGAGAACAAACAC
#> 15: CACCGGAAGCGTGTGAGGCGGTAGT  R-TP53_gRNA3 AAACACTACCGCCTCACACGCTTCC
#> 16: CACCGTTCCTCACCTGATGATCTTG  R-TP53_gRNA4 AAACCAAGATCATCAGGTGAGGAAC
#> 17: CACCGTCTGCTGTAGGCTCATTTGC  R-TP53_gRNA5 AAACGCAAATGAGCCTACAGCAGAC
#> 18: CACCGTTCCACTCACTCCTGGAAGA  R-TP53_gRNA6 AAACTCTTCCAGGAGTGAGTGGAAC
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
#> 
#>    gene_id  gRNA                 seqs     idt_id_F
#> 1:    PAX6 gRNA1 TGTCAACGGGCGGCCACTGC F-PAX6_gRNA1
#>               oligo-1 (5'->3')     idt_id_R            oligo-2 (5'->3')
#> 1: newTGTCAACGGGCGGCCACTGCends R-PAX6_gRNA1 forGCAGTGGCCGCCCGTTGACAboth
```

