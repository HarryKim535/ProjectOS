import sys

if1 = open(sys.argv[1],'br')
if2 = open(sys.argv[2],'br')
out = if1.read() + if2.read()
of = open(sys.argv[3],'bw')
of.write(out)

if1.close()
if2.close()
of.close()
