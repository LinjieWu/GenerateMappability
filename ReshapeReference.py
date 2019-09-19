#reshape referfence sequence
import os,sys
refFile = sys.argv[1]
output = sys.argv[2]

## unfold (Circular DNA)
ref = ''
f = open(refFile)
line = f.readline()
while line:
    if line[0] == '>':
        tag = line
    else:
    	if len(line) == 51:
    		sys.exit(0)
        ref = ref + line.strip('\n')
    line = f.readline()

f.close()

## reshape
if os.path.exists(output+'/tmp_mappability.ref'):
    os.system('rm '+output+'/tmp_mappability.ref')

f = open(output+'/tmp_mappability.ref','a')
f.write(tag)
for c in range(0,len(ref),50):
    f.write(ref[c:min(c+50,len(ref))] + '\n')

os.system('rm '+refFile)
os.system('mv ' + output+'/tmp_mappability.ref '+refFile)
