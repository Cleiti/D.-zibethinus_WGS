# D.zibethinus_WGS
Replication of WGS analysis of Durian, from paper by Teh et. al. (doi:10.1038/ng.3972). Course project in Genome Analysis 2023, Uppsala University.

For Project plan and aim, see Wiki

For project notebook with recorded progress, use the following link: https://colab.research.google.com/drive/1f7bKYuTVSuLHd1ELmxQJjbu3FGZvmAFK?usp=sharing (NB: the notebook is originally for private use and not edited for reading)

The following document describes the detailed workflow and results of the analyses.

## Workflow

![Untitled Diagram (2)](https://github.com/Cleiti/D.zibethinus_WGS/assets/52427029/0ad68d07-3566-461c-b2d4-935b4b898c95)

### Raw data

This project used three kinds of input raw data: genomic short Illumina reads and genomic long PacBio reads, as well as transcriptomic short Illumina reads. All the input files were in **.fq.gz** format

### Short reads preprocessing

Raw illumina reads, both genomic and transcriptomic, were Quality Controlled, trimmed, and Quality Controlled again. The programs used were **FastQC** and **Trimmomatic**. The code for these jobs can be found in folders "DNA_prep_illumina" and "RNA_prep". Transcriptome reads from only one experiment (SRR6040095) needed trimming, and the rest were left unchanged.

The genomic reads passed QC well, while transcriptomic reads did not (both before and after trimming), failing among others in metrics of overrepresenteed sequences and per sequence GC content. The analysis was nevertheless continued with the same data.

### Initial assembly

The initial assembly was made using long genomic PacBio reads. No initial preprocessing was made, because the assembly software used - **Canu** - includes a QC. The command outputed a **.fasta** file with an assembly. The code for this job can be found in folder "DNA_prep_assembly_pacbio".

### Assembly improvement

The assembly based on genomic long reads was further improved using genomic short reads. The reads were first indexed and aligned to the assembly using software **BWA** with options **index** and **mem**, creating an alignment file in **.sam** format. The alignment was converted to a compressed format **.bam**, as well as sorted by position and indexed, using **SAMtools**.

The initial assembly was subsequently corrected with the alignment using software **Pilon**. The final assembly was Quality Controlled using **QUAST** and the sequence repeats were softmasked using **RepeatMasker**.

The code for these jobs can be found in folder "DNA_post_assembly_pacbio".

