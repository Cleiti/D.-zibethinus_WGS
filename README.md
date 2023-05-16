# D.zibethinus_WGS
Replication of WGS analysis of Durian, from paper by Teh et. al. (doi:10.1038/ng.3972). Course project in Genome Analysis 2023, Uppsala University.

For Project plan and aim, see Wiki

For project notebook with recorded progress, use the following link: https://colab.research.google.com/drive/1f7bKYuTVSuLHd1ELmxQJjbu3FGZvmAFK?usp=sharing (NB: the notebook is originally for private use and not edited for reading)

The following document describes the detailed workflow and results of the analyses.

## Workflow

![Untitled Diagram (2)](https://github.com/Cleiti/D.zibethinus_WGS/assets/52427029/0ad68d07-3566-461c-b2d4-935b4b898c95)

### Short reads preprocessing

Raw illumina reads, both genomic and transcriptomic, were Quality Controlled, trimmed, and Quality Controlled again. The programs used were FastQC and Trimmomatic. The code for these jobs can be found in folders "DNA_prep_illumina" and "RNA_prep". Transcriptome reads from only one experiment (SRR6040095) needed trimming, and the rest were left unchanged.

The genomic reads passed QC well, while transcriptomic reads did not (both before and after trimming), failing among others in metrics of overrepresenteed sequences and per sequence GC content. The analysis was nevertheless continued with the same data.

### Initial assembly

The initial assembly was made using long genomic PacBio reads. No initial preprocessing was made, because the assembly software used - Canu - includes a QC. The code for this job can be found in folder "DNA_prep_assembly_pacbio".

### 
