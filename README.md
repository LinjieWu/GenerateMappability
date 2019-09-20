# GenerateMappability
Generate mappability file for BICseq2 by gemtools.

# Setup
git clone https://github.com/LinjieWu/GenerateMappability.git

cd ./GenerateMappability

python setup.py

# Usage
Usage: GenerateMappability.sh [options]

      -r  Reference sequence
      
      -l  Read length of sequencing data
      
      -o  Prefix of output direction (Default ./tmp)
      
      -t  Number of thread (Default 4)
      
      -h  Display help info.

Example: GenerateMappability.sh -r hg19.fa -l 150 -t 20 -o hg19_mappability

# Note
Gemtools need long time when the genome size is large (50 min for human chr1 with 20 threads).
