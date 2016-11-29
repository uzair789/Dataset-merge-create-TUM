#!/usr/bin/python
import os

#this script splits the pose_per_image.txt file into two files(one for training and one for validation)
# outputs --> train.txt (contains 80% of the data) and val.txt (contains 20% of the data)

f1=open('pose_per_image.txt')
num_lines = sum(1 for line in f1) #calculating the number of lines in the file

#reloading the file
f1=open('pose_per_image.txt')

output_file1 = os.path.expanduser('~') + '/Desktop/train.txt'

output_file2 = os.path.expanduser('~') + '/Desktop/val.txt'
try:
    os.remove(output_file1)
    os.remove(output_file2)
except OSError:
    pass
f2 = open(output_file1, 'a')
f3 = open(output_file2, 'a')	



i=1
for line in f1:
	if (i<(0.8 * (num_lines-1) + 1)):
		f2.write(line)
		i=i+1
	else:
		f3.write(line)
		



f1.close()
f2.close()
f3.close()


