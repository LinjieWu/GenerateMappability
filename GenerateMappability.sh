#!/bin/bash
######################################################################
####   Generate mappability file for BICseq2
####   Aurthor: Linjie Wu
####   Date: 20190919
######################################################################
SoftwareDir='.'
export PATH=${SoftwareDir}/src/gemtools-1.7.1-i3/bin/:$PATH

#### Usage
usage(){
    echo -e "Program: Generate mappability file for BICseq2"
    echo -e "Usage: GenerateMappability [options]"
    echo -e "      -r  reference sequence"
    echo -e "      -l  read length of sequencing data"
    echo -e "      -o  prefix of output file (Default tmp)"
    echo -e "      -h  display help info."
    echo -e "example: GenerateMappability -r hg19.fa -l 150 -o hg19"
exit 1
}
## No parameters
if [ $# == 0 ]
then
usage
exit
fi

refFile=''
readLength=''
output='tmp'
while getopts :r:l:o:h FLAG; do
  case $FLAG in
    r)  
      refFile=$OPTARG
      ;;
    l) 
      readLength=$OPTARG
      ;;
    o)  
      output=$OPTARG
      ;;
    h)  
      usage
      ;;
    \?) 
      usage
      ;;
  esac
done
shift $((OPTIND-1))

if [ $refFile == '' ] || [ $readLength != '' ] ; then
usage
exit
fi

### gemtools
gem-indexer -T 4 -c dna -i ${output}_mappability.ref -o ${output}
gem-mappability -T 4 -I ${output}.gem -l ${readLength} -o ${output}
gem-2-wig -I ${output}.gem -i ${output}.mappability -o ${output}_${readLength}
 
### Generate mappability for ProkaBIC-seq
python ${SoftwareDir}/Mappability.py ${readLength} ${output}

### remove temporary files
rm ${output}.gem
rm ${output}.log
rm ${output}.mappability
rm ${output}_${readLength}.wig