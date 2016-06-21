# extractSeq
extracSeq is a bash script (awk embebed), that giving a contig name and positions (start and end), return the corresponding sequence from your fasta.

#Usage
extractSeq need five (and intuitive), parameters (order is important):

* The contig name where are the coordinates that you want.
* Start position of your gene.
* End position of your gene.
* Fasta file to dive.
* Output name (optional, by default is "output").
* Strand where are your gene (default: +).

Example:

	bash extractSeq.bash contig0001 500 2000 Ecoli.fasta myoutput +

This means that we dive in file Ecoli.fasta, searching the contig "contig0001" and then extract the sequence on the position 500 to 2000.

Real example:
In the example folder there is a fasta (Ecoli.fasta), where the contigs names are like:

* NODE\_1\_length\_350779\_cov\_17.5196
* NODE\_2\_length\_328984\_cov\_17.2607

So, applying the usage will be:

	bash extractSeq.bash NODE_1_length_350779_cov_17.5196 500 1400 example/Ecoli.fasta testgene -

This will give a testgene.fasta with the reverse complementary sequence.

#Output
Following the same example, the output is a fasta (testgene.fasta), with the positions in the header indicating if are complement or not:

	>NODE_1_length_350779_cov_17.5196 Ecoli.fasta c(500:1400)
	TCTTTCGGTGTATTGTCCAGCTCCAGCGGCAGAGCCACGTTGCCAAAAACAGTACGCGAAG
	AGAGCAGGTTAAAATGCTGGAAAATCATACCAATCTGGCGGCGAGCTTTGGTCAACTCGGA
	TTCTGACAGCGTGGTCAGTTCCTGTCCATCGACCAGCACGCTACCCTCGGTTGGGCGCTCC
	AGCAGGTTTACACAACGTATAAGCGTACTCTTACCCGCGCCTGAGGCACCGATAACGCCAT
	AAATTTGCCCAGCTGGCACATGCAGGCTGACGTTGTTCAACGCCTGGATGGTGCGGGTGCC
	CTGGTGGAACACTTTGGTGATATTCGAAAGTTTTATCATTGATTATTTATTATCGTCATTA
	AGTTAGTCGTGGCATTTCGAATGCCTGAAACGGGCAACGCCGTCAATGAAATGGATGTTAA
	GGCATCCAGACGTCTAAATCAATCAGGTTTATGCGAAGAGCACTTTCTTGCAGGTCGAAAC
	ATGCGATACTAGCGTCACATGCCTTATTAAGGAGCTATAAAAGGTGGCGAAGAGCGTACCC
	GCAATTTTTCTTGACCGTGATGGCACCATTAATGTCGATCACGGCTATGTCCATGAGATCG
	ATAACTTTGAATTTATCGACGGTGTTATTGACGCCATGCGCGAGCTAAAAAAAATGGGCTT
	CGCGCTGGTGGTAGTCACCAACCAGTCTGGCATTGCTCGCGGTAAATTTACTGAAGCACAG
	TTTGAAACGCTGACCGAGTGGATGGACTGGTCGCTGGCGGACCGCGATGTCGATCTGGATG
	GTATCTATTATTGCCCGCATCATCCGCAGGGTAGTGTTGAAGAGTTTCGCCAGGTCTGCGA
	CTGCCGCAAACCACATCCGGGGATGCTTTTGTCGGCACGCGATTATT
	
