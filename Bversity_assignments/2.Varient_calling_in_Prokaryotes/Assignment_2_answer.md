---
tags:
  - Bversity
---
Name : David Franklin D.

Contact: davidfranklin1999@gmail.com

Mobile: 7339695655

Assignment: 2

Title: Genomics and Variant Calling analysis

![](https://lh7-us.googleusercontent.com/ippav0Ki1NVVgQvj2wGhNJfUepM9Gex7xz6ik_BitFP2D6fE1hPGLOC6M0uekvjvi_EimHJTp-nb2JF8dZLLeCLrmQJXplbMrESr6KfCcAH5Pfyda8ittpZwh5NVAd4U5Gx4GBnO6Z5rsyK6GzUmlFw "horizontal line")

# Questions
  
Answer the following questions below and upload them in the google form.

Analyze how the *E. coli* Ara-3 population evolved over time by identifying genetic variants compared to the reference strain REL606.

1. Mention evolutionary trends observed in the Ara-3 population.
    
2. Discuss the implications of your findings of *E. coli* evolution in about 350 words.
---
# Answer

## Background information
The long-term E. coli experiment, often referred to as the Lenski experiment, is a groundbreaking study in evolutionary biology conducted by Dr. Richard Lenski at Michigan State University. Initiated in 1988, the experiment involves the cultivation of several populations of Escherichia coli bacteria in a controlled laboratory environment, with the aim of observing evolution in action over extended periods.

Each population of E. coli is grown in a nutrient-rich medium and allowed to replicate for generations under identical conditions. The experiment involves daily transfers of a small portion of the population to fresh medium, thus mimicking the process of natural selection and adaptation to new environments.

The significance of the experiment lies in its demonstration of evolutionary principles, including genetic mutation, natural selection, and adaptation, within a relatively short timeframe. Over the course of thousands of generations, the E. coli populations have exhibited various evolutionary changes, such as improved growth rates, altered metabolic pathways, and the development of new traits.

The long-term E. coli experiment provides valuable insights into the mechanisms of evolutionary change and has contributed to our understanding of fundamental biological processes. It remains one of the most enduring and influential studies in the field of evolutionary biology.


![[Pasted image 20240301170337.png]]
**Figure 1: Evolutionary tree of the *E. coli* strains over the period of the experiment (from article)**

---
## Data Samples

1. ref genome - 
		rel606
  

2. Sample: Evolved clone isolated from LTEE population Ara-3 at 25,000 generations

		https://www.ncbi.nlm.nih.gov/sra/SRX3288920[accn]
		ZDB488 (SRR6178310)
		genomic DNA isolated, fragmented, and used in normal Illumina library prep
		1 ILLUMINA (Illumina HiSeq 2500) run: 2.5M spots, 507.1M bases, 225.7Mb downloads
```cardlink
url: https://www.ncbi.nlm.nih.gov/sra/SRX3288920[accn
title: "ZDB488 - SRA - NCBI"
host: www.ncbi.nlm.nih.gov
```


  

3. Sample: Evolved clone isolated from LTEE population Ara-3 at 31,500 generations

		https://www.ncbi.nlm.nih.gov/sra/SRX3288939[accn]
		ZDB25 (SRR6178291)
		genomic DNA isolated, fragmented, and used in normal Illumina library prep
		1 ILLUMINA (Illumina HiSeq 2500) run: 2.7M spots, 552.2M bases, 244.5Mb downloads

```cardlink
url: https://www.ncbi.nlm.nih.gov/sra/SRX3288939[accn
title: "ZDB25 - SRA - NCBI"
host: www.ncbi.nlm.nih.gov
```

  

## Methodology

The steps taken in the variant calling process (snippy)
1. Quality checking of samples was conducted using FastQC.
2. The reference genome was indexed using BWA (Burrows-Wheeler Aligner) for alignment.
3. Alignment of reads to the reference genome was performed using BWA.
4. SAM files generated from the alignment were converted to the more compact BAM format using Samtools.
5. The BAM files were sorted for efficient data processing using Samtools.
6. Aligned reads were processed to create a pileup, facilitating variant calling, using Samtools.
7. Variant calling was executed using Bcftools to identify genomic variations.
8. Variants were filtered using vcfutils.pl to refine the variant list.
9. Annotation of the reference genome was conducted using Prokka to identify and annotate genetic features.
10. SnpEff was employed to assess the functional impact of genetic variants on genes and other genomic features.

## Output

### core alignment summary Variant info

| ID                 | LENGTH  | ALIGNED | UNALIGNED | VARIANT | HET  | MASKED | LOWCOV |
| ------------------ | ------- | ------- | --------- | ------- | ---- | ------ | ------ |
| SRR6178291_1_fastq | 4629812 | 4380437 | 228789    | 30      | 1120 | 0      | 19466  |
| SRR6178310_1_fastq | 4629812 | 4471983 | 142721    | 24      | 1071 | 0      | 14037  |
| Reference          | 4629812 | 4629812 | 0         | 0       | 0    | 0      | 0      |
SRR6178291
![[Pasted image 20240301231323.png]]



SRR6178310
![[Pasted image 20240301231142.png]]


## Variant information  


| **POS** | **TYPE** | **REF** | **ALT** | Str and | **EFFECT**                                                            | **GENE** | **PRODUCT**                                           |
| ------- | -------- | ------- | ------- | ------- | --------------------------------------------------------------------- | -------- | ----------------------------------------------------- |
| 9972    | snp      | T       | G       | -       | missense_variant c.521A>C p.Asn174Thr                                 | satP     | Succinate-acetate/proton symporter SatP               |
| 10563   | snp      | G       | A       |         |                                                                       |          |                                                       |
| 81158   | snp      | A       | C       | +       | missense_variant c.734A>C p.Glu245Ala                                 | setA     | Sugar efflux transporter A                            |
| 216480  | snp      | C       | T       |         |                                                                       |          |                                                       |
| 247796  | snp      | T       | C       | -       | missense_variant c.79A>G p.Ser27Gly                                   | fadE     | Acyl-coenzyme A dehydrogenase                         |
| 281923  | snp      | G       | T       |         |                                                                       |          |                                                       |
| 398061  | snp      | G       | C       | +       | missense_variant c.134G>C p.Gly45Ala                                  | secF     | Protein translocase subunit SecF                      |
| 473901  | ins      | C       | CCG     | -       | frameshift_variant c.1403_1404dupCG p.Ala469fs                        | ybaL     | Putative cation/proton antiporter YbaL                |
| 648692  | snp      | C       | T       | -       | missense_variant c.206G>A p.Arg69His                                  | mrdB     | Peptidoglycan glycosyltransferase MrdB                |
| 734488  | snp      | C       | T       | -       | missense_variant c.772G>A p.Ala258Thr                                 | gltA     | Citrate synthase                                      |
| 943475  | snp      | C       | T       | -       | missense_variant c.27G>A p.Met9Ile                                    | infA     | Translation initiation factor IF-1                    |
| 1331794 | snp      | C       | A       | +       | missense_variant c.2375C>A p.Thr792Lys                                | topA_1   | DNA topoisomerase 1                                   |
| 1607915 | del      | AT      | A       | -       | frameshift_variant c.17delA p.Asn6fs                                  |          | hypothetical protein                                  |
| 2333538 | ins      | A       | AT      |         |                                                                       |          |                                                       |
| 2389878 | snp      | G       | T       | -       | missense_variant c.99C>A p.Ser33Arg                                   | mepA     | Penicillin-insensitive murein endopeptidase           |
| 2446984 | snp      | A       | C       |         |                                                                       |          |                                                       |
| 2611312 | del      | CT      | C       | -       | frameshift_variant c.440delA p.Gln147fs                               | qseE     | Sensor histidine kinase QseE                          |
| 2665639 | snp      | A       | T       | -       | missense_variant c.299T>A p.Leu100Gln                                 | rplS     | 50S ribosomal protein L19                             |
| 2843036 | snp      | G       | A       | -       | synonymous_variant c.594C>T p.Gly198Gly                               | amiC     | N-acetylmuramoyl-L-alanine amidase AmiC               |
| 2999330 | snp      | G       | A       |         |                                                                       |          |                                                       |
| 3260564 | del      | GTTTCGC | G       | -       | conservative_inframe_deletion c.1609_1614delGCGAAA p.Ala537_Lys538del | ftsH     | ATP-dependent zinc metalloprotease FtsH               |
| 3288025 | snp      | T       | A       | -       | missense_variant c.236A>T p.Gln79Leu                                  | arcB     | Aerobic respiration control sensor protein ArcB       |
| 3339313 | snp      | A       | C       | +       | missense_variant c.152A>C p.Tyr51Ser                                  | fis      | DNA-binding protein Fis                               |
| 3401754 | snp      | C       | A       | -       | missense_variant c.233G>T p.Arg78Leu                                  | rpsG     | 30S ribosomal protein S7                              |
| 3463900 | snp      | C       | T       | -       | missense_variant c.653G>A p.Arg218His                                 | envZ     | Osmolarity sensor protein EnvZ                        |
| 3481820 | snp      | A       | G       | +       | missense_variant c.136A>G p.Thr46Ala                                  | malT     | HTH-type transcriptional regulator MalT               |
| 3488669 | snp      | A       | C       | -       | missense_variant c.538T>G p.Ser180Ala                                 | glpR     | Glycerol-3-phosphate regulon repressor                |
| 3893548 | del      | CCA     | C       |         |                                                                       |          |                                                       |
| 3909807 | snp      | G       | T       |         |                                                                       |          |                                                       |
| 3911965 | del      | AT      | A       | +       | frameshift_variant c.49delT p.Ser17fs                                 |          | hypothetical protein                                  |
| 4100183 | snp      | A       | G       | -       | missense_variant c.1048T>C p.Ser350Pro                                | hslU     | ATP-dependent protease ATPase subunit HslU            |
| 4107018 | snp      | T       | A       | -       | synonymous_variant c.369A>T p.Pro123Pro                               |          | hypothetical protein                                  |
| 4180200 | snp      | T       | G       |         |                                                                       |          |                                                       |
| 4201958 | snp      | A       | C       | -       | missense_variant c.602T>G p.Leu201Arg                                 | iclR     | Transcriptional repressor IclR                        |
| 4363338 | snp      | C       | A       | +       | synonymous_variant c.744C>A p.Gly248Gly                               | yjeM     | Inner membrane transporter YjeM                       |
| 4431393 | del      | TGG     | T       | +       | frameshift_variant c.3526_3527delGG p.Gly1176fs                       | tamB     | Translocation and assembly module subunit TamB        |
| 4433347 | snp      | A       | G       | +       | missense_variant c.136A>G p.Lys46Glu                                  | ytfQ     | ABC transporter periplasmic-binding protein YtfQ      |
| 4616538 | snp      | A       | C       | +       | missense_variant c.1010A>C p.Tyr337Ser                                | nadR     | Trifunctional NAD biosynthesis/regulator protein NadR |


----

## Conclusion
### 1. Evolutionary Trends Observed in the Ara-3 Population:

Comparing the evolved clones isolated from the LTEE population Ara-3 at 25,000 and 31,500 generations to the reference strain REL606, several evolutionary trends emerge:

1. **Genetic Variation Accumulation**: Both samples exhibit a significant accumulation of genetic variants compared to the reference strain. This indicates ongoing evolution and genetic divergence over time within the Ara-3 population.
    
2. **Single Nucleotide Polymorphisms (SNPs)**: Analysis reveals numerous SNPs in both samples, suggesting nucleotide substitutions that may contribute to phenotypic diversity and adaptation within the population.
    
3. **Insertions and Deletions (Indels)**: The presence of insertions and deletions in the evolved clones indicates genomic rearrangements and structural variations that could impact gene function and regulatory mechanisms.
    
4. **Missense and Frameshift Variants**: Many of the observed mutations result in missense variants, altering the amino acid sequence of proteins. Additionally, frameshift variants are detected, leading to changes in reading frames and potentially impacting protein structure and function.
    
5. **Variants in Coding Regions**: Several variants are located within coding regions of genes, highlighting potential targets of natural selection and adaptive evolution. These mutations may confer selective advantages, allowing the population to better adapt to its environment.
    
| Evolutionary Trends                  | Ara-3 Population                                                                                                                                         |
| ------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Accumulation of Genetic Variants     | Demonstrates accumulation of SNPs, insertions, and deletions over time.                                                                                  |
| Selection for Beneficial Mutations   | Likely subjected to natural selection favoring mutations enhancing fitness in the experimental environment.                                              |
| Diversification of Genomic Landscape | Exhibits diverse genetic changes, including missense mutations and frameshift variants, reflecting ongoing evolutionary dynamics.                        |
| Evolutionary Trade-zOffs             | May involve mutations with both positive and negative fitness effects, highlighting complex interactions between mutation, selection, and genetic drift. |
### 2. Implications of Findings on E. coli Evolution:

The observed evolutionary trends in the Ara-3 population have significant implications for our understanding of E. coli evolution and broader evolutionary processes:

1. **Adaptation to Environmental Changes**: The accumulation of genetic variants reflects the adaptive response of E. coli to its environment over thousands of generations. Through natural selection, beneficial mutations that enhance fitness become fixed in the population, facilitating adaptation to changing ecological conditions.
    
2. **Diversification and Speciation**: The emergence of genetic diversity within the Ara-3 population suggests the potential for speciation and the formation of distinct ecotypes. As populations diverge genetically, reproductive isolation may occur, leading to the evolution of new species over evolutionary time scales.
    
3. **Genomic Plasticity and Evolutionary Innovation**: The presence of structural variations and functional mutations underscores the genomic plasticity of E. coli and its capacity for evolutionary innovation. Genetic changes enable the exploration of new ecological niches and the acquisition of novel metabolic capabilities, driving evolutionary trajectories.
    
4. **Biotechnological and Clinical Relevance**: Understanding the dynamics of E. coli evolution has implications for various fields, including biotechnology and clinical microbiology. Knowledge of adaptive evolution mechanisms can inform the development of microbial strains for industrial applications and enhance our ability to combat antibiotic resistance and infectious diseases.
    

In conclusion, the study of E. coli evolution in the LTEE experiment provides invaluable insights into the mechanisms and dynamics of evolutionary change. By elucidating the genetic basis of adaptation and diversification, we gain a deeper understanding of life's remarkable capacity for innovation and survival in response to selective pressures.

---
