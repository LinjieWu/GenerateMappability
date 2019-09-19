# GenerateMappability
Generate mappability file for BICseq2 by gemtools.

# Setup
git clone https://github.com/LinjieWu/GenerateMappability.git

cd ./GenerateMappability

python setup.py

# Usage
Usage: GenerateMappability [options]

      -r  Reference sequence
      
      -l  Read length of sequencing data
      
      -o  Prefix of output direction (Default ./tmp)
      
      -t  Number of thread (Default 4)
      
      -h  Display help info.

Example: GenerateMappability -r hg19.fa -l 150 -t 10 -o hg19_mappability
