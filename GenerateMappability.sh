#!/bin/bash
######################################################################
####   Generate mappability file for BICseq2
####   Aurthor: Linjie Wu
####   Date: 20190919
######################################################################
SoftwareDir='.'
export PATH=${SoftwareDir}/gemtools-1.7.1-i3/bin/:$PATH

#### Usage
usage(){
    echo -e "Program: Generate mappability file for BICseq2"
    echo -e "Usage: GenerateMappability [options]"
    echo -e "      -r  Reference sequence"
    echo -e "      -l  Read length of sequencing data"
    echo -e "      -o  Prefix of output direction (Default ./tmp)"
    echo -e "      -t  Number of thread (Default 4)"
    echo -e "      -h  Display help info."
    echo -e "example: GenerateMappability -r hg19.fa -l 150 -t 20 -o hg19_mappability"
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
T='4'
while getopts :r:l:o:t:h FLAG; do
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
    t)
      T=$OPTARG
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


## Create path
if [ ! -x "$output" ]; then
mkdir -p ${output}
fi

## Seperate reference
python ${SoftwareDir}/SplitReference.py ${refFile} ${output}
echo -e 'Split reference genome'

### gemtools
files=$(ls ${output})
for file in ${files[@]}
do
python ${SoftwareDir}/ReshapeReference.py ${output}/${file} ${output}
gem-indexer -T ${T} -c dna -i ${output}/${file} -o ${output}/${file}
gem-mappability -T ${T} -I ${output}/${file}.gem -l ${readLength} -o ${output}/${file}
gem-2-wig -I ${output}/${file}.gem -i ${output}/${file}.mappability -o ${output}/${file}_${readLength}
### Generate mappability for ProkaBIC-seq
python ${SoftwareDir}/Mappability.py ${readLength} ${output}/${file}
### remove temporary files
rm ${output}/${file}.gem
rm ${output}/${file}.log
rm ${output}/${file}.mappability
rm ${output}/${file}_${readLength}.wig
rm ${output}/${file}_${readLength}.sizes
rm ${output}/${file}
echo -e 'Finished '${file}
done

