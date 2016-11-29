#!/usr/bin/python
import os
import math

#This script loads the output_log.txt and creates a data script with Image1 Image2 Transform format
#The output format is "Image1-num Image1 Image2-num Image2 tx ty tz qi qj qk qw norm_of_transform

# input file ----> output file
#'train.txt' ----> 'data_input_pairs_train.txt'
#'val.txt' ----> 'data_input_pairs_val.txt'

f1=open('val.txt')#change train.txt to val.txt or vice-versa when using for respective script

output_file = os.path.expanduser('~') + '/Desktop/data_input_pairs_val.txt'
try:
    os.remove(output_file)
except OSError:
    pass
f3 = open(output_file, 'a')	
i=1
for line in f1:
	aa=line.split(" ")
	Image1=aa[1]
	tx1=float(aa[3])
	ty1=float(aa[4])
	tz1=float(aa[5])
 	b=float(aa[6])
	c=float(aa[7])
	d=float(aa[8])
	a=float(aa[9])
	f2=open('val.txt')
	j=1
	for line2 in f2:
		bb=line2.split(" ")
		Image2=bb[1]
		if i>=j:
			j=j+1
		else:
			tx2=float(bb[3])	
			ty2=float(bb[4])
			tz2=float(bb[5])
			f=-float(bb[6]) #for conjugate
			g=-float(bb[7])
			h=-float(bb[8])
			e=float(bb[9])
			diff_x=tx2-tx1
			diff_y=ty2-ty1
			diff_z=tz2-tz1
			diff_axis=(a*e-b*f-c*g-d*h)
			diff_i=(b*e+a*f+c*h-d*g)
			diff_j=(a*g-b*h+c*e+d*f)
			diff_k=(a*h+b*g-c*f+d*e)

			#write a norm check to avoid small transformations
			norm=math.sqrt(diff_x*diff_x + diff_y*diff_y+ diff_z*diff_z+ diff_i*diff_i+ diff_j*diff_j+ diff_k*diff_k+ diff_axis*diff_axis)
			
			op = str(i)+" "+Image1+" "+str(j)+" "+Image2+" "+str(diff_x)+" "+str(diff_y)+" "+str(diff_z)+" "+str(diff_i)+" "+str(diff_j)+" "+str(diff_k)+" "+str(diff_axis)+" "+str(norm)
			f3.write(op)
			f3.write("\n")
			j=j+1
	i=i+1

f1.close()
f2.close()
f3.close()						




