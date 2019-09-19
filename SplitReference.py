### Seperate referecne genome
import os,sys
ref = sys.argv[1]
Outdir = sys.argv[2]

f = open(ref)
line = f.readline()

result=''
while line:
    if line[0] == '>' and len(result)>1000:
        if os.path.exists(Outdir+'/'+f2):
            os.system('rm '+ Outdir+'/'+f2)
        open(Outdir+'/'+f2,'w').write(result)
    if line[0] == '>':
       result = line
       f2 = line.strip('>')
       f2 = f2.strip('\n')
       f2 = f2.strip(' ')
       flag = f2.find(' ')
       if flag > 0:
           f2 = f2[:flag] 
    else:
        result = result + line
    line = f.readline()

open(Outdir+'/'+f2,'w').write(result)
f.close()