--[[
-This file is a lua implementation of create_data_input_pairs.py.
-It takes as input the create_pose_per_image.txt as input and computes the transformations between the images.

img1 ---> img2 --- 7 dimensional transform
1    ---> 2    --- 7 dim vector
1    ---> 3    --- 7 dim vector
1    ---> 4    --- 7 dim vector
. 
.
.
1    ---> n    --- 7 dim vector
2    ---> 3    --- 7 dim vector
2    ---> 4    --- 7 dim vector
.
.
.
2    ---> n    --- 7 dim vector
.
.
n    ---> n    ---7 dim vector

-Both the train.txt and the val.txt ane passed over a for loop and train_pairs.txt and val_pairs.txt are created
]]
print(" --- running create_data_input_pairs.lua --> generating the train_pairs.txt and the val_pairs.txt")

train_val = {}
output = {}
train_val_s = {'train_table','val_table'}
train_val = {train_table,val_table}
output = {'train_pairs.txt','val_pairs.txt'}


for i=1,#train_val do
	print(" --- computing the transformations for ---> "..train_val_s[i])
	local output_file = io.open(output[i],"a+")
	for ii = 1,#train_val[i] do
		ts_1, img1, ts_2, tx1, ty1, tz1, b, c, d, a = unpack(train_val[i][ii]:split(" "))
		for jj=1,#train_val[i] do
			if ii<jj then
				ts_12, img2, ts_22, tx2, ty2, tz2, f, g, h, e = unpack(train_val[i][jj]:split(" "))
				f = -f --taking the conjugate
				g = -g
				h = -h
				diff_x = tx2-tx1
				diff_y = ty2-ty1
				diff_z = tz2-tz1
				diff_axis=(a*e-b*f-c*g-d*h)
				diff_i=(b*e+a*f+c*h-d*g)
				diff_j=(a*g-b*h+c*e+d*f)
				diff_k=(a*h+b*g-c*f+d*e)

				--computing a norm of the transformation
				norm=math.sqrt(diff_x*diff_x + diff_y*diff_y+ diff_z*diff_z+ diff_i*diff_i+ diff_j*diff_j+ diff_k*diff_k+ diff_axis*diff_axis)
				op = ii.." "..img1.." "..jj.." "..img2.." "..diff_x.." "..diff_y.." "..diff_z.." "..diff_i.." "..diff_j.." "..diff_k.." "..diff_axis.." "..norm
				output_file:write(op.."\n")
			end
		end
	end
	output_file:close(output[i])
end
