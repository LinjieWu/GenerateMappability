import os,sys
dir = os.getcwd()

## Main code
f = open('GenerateMappability')
tmp = ''
line = f.readline()
while line:
    if line.find('SoftwareDir') == 0:
        tmp = tmp + 'SoftwareDir="' + dir + '"\n'
    else:
        tmp = tmp + line
    line = f.readline()
open('GenerateMappability','w').write(tmp)
os.system('unzip gemtools-1.7.1-i3.zip')
os.system('chmod 775 ./gemtools-1.7.1-i3/bin/*')
os.system('rm gemtools-1.7.1-i3.zip')
os.system('chmod 775 GenerateMappability')
