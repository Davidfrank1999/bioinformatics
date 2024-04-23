---
tags:
  - Bversity
---

[[Assignment_6]]
## Data

| S.no | Name | ACCESSION | Length |
| ---- | ---- | ---- | ---- |
| 1 | Escherichia coli strain U 5/41 16S ribosomal RNA, partial sequence | NR_024570 | 1450 bp |
| 2 | Bacillus subtilis strain IAM 12118 16S ribosomal RNA, complete sequence | NR_112116 | 1550 bp |
| 3 | Bacillus cereus ATCC 14579 16S ribosomal RNA (rrnA), partial sequence | NR_074540 | 1512 bp |
| 4 | Klebsiella pneumoniae strain DSM 30104 16S ribosomal RNA, partial sequence | NR_036794 | 1534 bp |
| 5 | Bacillus velezensis strain FZB42 16S ribosomal RNA, complete sequence | NR_075005 | 1550 bp |

UNIVERSITY OF SALFORD,


```cardlink
url: https://www.ncbi.nlm.nih.gov/nuccore/NR_024570.1
title: "Escherichia coli strain U 5/41 16S ribosomal RNA, partial sequence - Nucleotide - NCBI"
host: www.ncbi.nlm.nih.gov
```


```cardlink
url: https://www.ncbi.nlm.nih.gov/nuccore/NR_112116.2?report=fasta
title: "Bacillus subtilis strain IAM 12118 16S ribosomal RNA, complete sequenc - Nucleotide - NCBI"
host: www.ncbi.nlm.nih.gov
```


```cardlink
url: https://www.ncbi.nlm.nih.gov/nuccore/NR_074540.1
title: "Bacillus cereus ATCC 14579 16S ribosomal RNA (rrnA), partial sequence - Nucleotide - NCBI"
host: www.ncbi.nlm.nih.gov
```


```cardlink
url: https://www.ncbi.nlm.nih.gov/nuccore/NR_036794.1
title: "Klebsiella pneumoniae strain DSM 30104 16S ribosomal RNA, partial sequ - Nucleotide - NCBI"
host: www.ncbi.nlm.nih.gov
```


```cardlink
url: https://www.ncbi.nlm.nih.gov/nuccore/NR_075005.2
title: "Bacillus velezensis strain FZB42 16S ribosomal RNA, complete sequence - Nucleotide - NCBI"
host: www.ncbi.nlm.nih.gov
```


### Step 1:Manifest File Creation

```python
!conda activate qiime2-amplicon-2023.9
```

Manifest file ⬇ modified
```python
!for folder in "B. cereus ATCC 14579 16S rRNA" "B. subtilis strain IAM 12118 16S rrna" "B. velezensis strain FZB42 16S rRNA" "E_coli strain U 5-41 16S rrna" "K. pneumoniae strain DSM 30104 16S rrna"
do
    ls "$folder"/*.fastq | \
    parallel -j0 --keep-order 'echo -e "{/}\t"$PWD"/{}"' >> manifest_single_end.txt
done

```

no need ⬇
```python
!echo "# paired-end PHRED 33 fastq manifest file for forward and reverse reads" > manifest1.txt
!echo -e "sample-id\tforward-absolute-filepath\treverse-absolute-filepath" >> manifest1.txt
!ls *.fastq | cut -d "_" -f 1 | sort | uniq | parallel -j0 --keep-order 'echo -e "{/}\t"$PWD"/{/}_R1.fastq\t"$PWD"/{/}_R2.fastq"' | tr -d "'" > !manifest2.txt
!mkdir manifest
!cat manifest1.txt manifest2.txt > manifest/manifest.tsv

```




Importing
```bash
qiime tools import \
  --type 'SampleData[PairedEndSequencesWithQuality]' \
  --input-path your_sequences.fastq.gz \
  --output-path your_sequences.qza \
  --input-format CasavaOneEightSingleLanePerSampleDirFmt

```





-----
FASTA files
Per-feature unaligned sequence data (i.e., representative FASTA sequences)
our data comes under this


```python
import qiime2
import zipfile
import pandas as pd
import matplotlib.pyplot as plt

# Load the QIIME 2 artifact
qzv_file = 'path/to/your/file.qzv'
visualization = qiime2.Visualization.load(qzv_file)

# Export data from the .qzv file
with zipfile.ZipFile(visualization.export_data(), 'r') as zip_ref:
    zip_ref.extractall('extracted_data')

# Load data (adjust the file path accordingly)
data = pd.read_csv('extracted_data/data.tsv', sep='\t')

# Plot using Matplotlib
plt.plot(data['X-axis'], data['Y-axis'])
plt.xlabel('X-axis')
plt.ylabel('Y-axis')
plt.title('Your Title')
plt.show()

```

```python
!conda activate qiime2-amplicon-2023.9
```


```python
import qiime2
```
### Step 1: importing
```python
!qiime tools import \
  --type 'FeatureData[Sequence]' \
  --input-path "/home/frank/Documents/Bioinfromatics/Assignment/assi6/Qiime2_Jup/Data/gene_comb.fna" \
  --output-path gene_comb.qza

```

	A manifest file is commonly used in QIIME 2 to specify the mapping between sample identifiers and the paths to the corresponding sequence data files. In the context of your gene sequence data (`gene_comb.fna`), since this data is unaligned and not associated with quality scores, you don't need a manifest file for this specific import.
	
	The command we used earlier:
	
	```bash
	qiime tools import \
	  --type 'FeatureData[Sequence]' \
	  --input-path "/home/frank/Documents/Bioinfromatics/Assignment/assi6/Qiime2_Jup/Data/gene_comb.fna" \
	  --output-path gene_comb.qza
	```
	
	imports the sequences directly without the need for a manifest file. This is because the `--type 'FeatureData[Sequence]'` indicates that you are importing sequence data, and the format of your data (FASTA) is inherently associated with the sequences themselves.
	
	Manifest files are typically required when dealing with paired-end sequence data where you have separate files for forward and reverse reads. In those cases, you need to create a manifest file that specifies the mapping between sample identifiers and the paths to the forward and reverse read files.
	
	Since you are working with unaligned gene sequences in this case, the import command is simplified, and a manifest file is not needed. If you have any other questions or if there's a specific analysis you're aiming for, feel free to let me know!


### Step 2: Summarize Data
```python
!qiime feature-table tabulate-seqs \
  --i-data gene_comb.qza \
  --o-visualization gene_comb_summary.qzv
```
This command generates a summary of the imported sequences. You can view the summary using QIIME 2 Viewer.

### Step 3: Generate Phylogenetic Tree
If you plan to perform phylogenetic diversity analyses, you can generate a phylogenetic tree:
```python
!qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences gene_comb.qza \
  --o-alignment aligned-gene_comb.qza \
  --o-masked-alignment masked-aligned-gene_comb.qza \
  --o-tree unrooted-gene_comb-tree.qza \
  --o-rooted-tree rooted-gene_comb-tree.qza
```

### Step 4: Perform Diversity Analysis

```python
!qiime diversity core-metrics-phylogenetic \
  --i-phylogeny rooted-gene_comb-tree.qza \
  --i-table gene_comb.qza \
  --p-sampling-depth 1000 \  # Adjust the sampling depth as needed
  --output-dir core-metrics-results
```

```python
# Step 4: Perform Diversity Analysis
!qiime diversity core-metrics-phylogenetic \
    --i-phylogeny rooted-gene_comb-tree.qza \
    --i-table gene_comb.qza \
    --p-sampling-depth 1000 \
    --output-dir core-metrics-results

```

```python
!qiime diversity core-metrics-phylogenetic \
    --i-phylogeny rooted-gene_comb-tree.qza \
    --i-table gene_comb.qza \
    --p-sampling-depth 1000 \
    --m-metadata-file Metadatanafldnew.tsv \
    --output-dir core-metrics-results

```
This command computes various alpha and beta diversity metrics.

### Step 5: Visualize Diversity Results

```python
!qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/faith_pd_vector.qza \
  --m-metadata-file Metadatanafldnew.tsv \
  --o-visualization alpha-group-significance.qzv

!qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file Metadatanafldnew.tsv \
  --o-visualization beta-group-significance.qzv

```
These commands generate visualizations for alpha and beta diversity results.