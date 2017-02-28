# extractSeq
extracSeq is a bash script (awk embedded), that giving a contig name and positions (start and end), return the corresponding sequence from your fasta.

##Usage
extractSeq need five (and intuitive), parameters (order is important):

* The contig name where are the coordinates that you want.
* Start position of your gene.
* End position of your gene.
* Fasta file to dive.
* Output name (optional, by default is "output").
* Strand where are your gene (default: +).

Example:

	bash extractSeq.bash contig0001 500 2000 + myoutput Ecoli.fasta

This means that we dive in file Ecoli.fasta, searching the contig "contig0001" and then extract the sequence on the position 500 to 2000.

Real example:
In the example folder there is a fasta (Ecoli.fasta), where the contigs names are like:

* NODE\_1\_length\_350779\_cov\_17.5196
* NODE\_2\_length\_328984\_cov\_17.2607

So, applying the usage will be:

	bash extractSeq.bash NODE_1_length_350779_cov_17.5196 500 1400 - testgene example/Ecoli.fasta

This will give a testgene.fasta with the reverse complementary sequence.

##Output
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
	CTGCCGCAAACCACATCCGGGGATGCTTTTGT
	
##NOTES
* Be careful with coordinates, if your contig have 100 nucleotides and you specify the coord 50,101. the script only write to 100.

* Make sure the coordinates begin from lower value to upper e.g (1 10, 400 425, etc).
* IUPAC ambiguity codes of the two possible nucleotides are converted as following: R↔Y, K↔M, S and W unchanged.
* Ambiguity codes of the three possible nucleotides are converted as following: B↔V, D↔H.
* Upper and lower case is preserved and can be used to mark regions of interest.