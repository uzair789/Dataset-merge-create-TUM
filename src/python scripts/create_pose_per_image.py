#!/usr/bin/python
import os

#This script loads the rgb.txt and the pose.txt and filters out the poses finding the most similar pose per image. Hence the output of this script will be a text file with each image and the most similar pose.

f1=open('Datasets_files/rgb.txt')
#f3=open('output_log.txt','a')

output_file = os.path.expanduser('~') + '/Desktop/output_log.txt'
try:
    os.remove(output_file)
except OSError:
    pass
f3 = open(output_file, 'a')	
#the name of output_file is output_log.txt. It will be created at the Desktop

c=0
for line in f1:  # loading each line from rgb.txt
 
   if line[0] != '#': 
     a = line.split(" ") #creating an array separated on " "
     ts_rgb = a[0].split(".")  #picking the timestamp value  
#     print ts_rgb
		
     	
     flag=0
     c=c+1
     print(c)				
     v=0
     min_val = 100000000	
     f2=open('Datasets_files/groundtruth.txt')
     for line2 in f2: #loading each line from groundtruth.txt
       if line2[0] != '#':
	 b = line2.split(" ")	 	
         ts_gt = b[0].split(".")
	# print ts_gt
	 # do the comparison here
#	 flag = 0
#	 print ts_rgb[0]
#	 print ts_gt[0]
	 if (ts_rgb[0] == ts_gt[0]):
#		print "inf f"
		diff = abs(int(ts_rgb[1])-int(ts_gt[1]+'00'))	
#		print (ts_rgb,
		#print (ts_rgb[1],ts_gt[1]+'00')
#		print min_val 
#		print ("diff="+str(diff))
		if diff < min_val:
#	           print "finding the min val"
		   min_val=diff	
		   op = (line.rstrip() + " " + line2)
#		   print "min achieved"	
		   flag = 1
     if flag ==1:
           print op
	   print min_val
	   f3.write(op)	

#     c=c+1
#     if c==500:
# 	break



f1.close()
f2.close()
f3.close()
