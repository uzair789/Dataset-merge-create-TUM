--[[
-This script is a lua implementation of crate_train_val.py.
-It takes the pose_per_image table as input and splits the file to produce a train table and 
 a val table which are the samples used for training and validation respectively.
-train table contains 80% of the samples.
]]

print(" --- running create_train_val.lua --> Splitting the data into train_table and val_table...")

train_table={}
val_table={}

local j = 1
for i=1,#pose_per_image do
	if (i<=0.8*#pose_per_image) then
		train_table[i] = pose_per_image[i]
	else
		val_table[j] = pose_per_image[i]
		j=j+1  
	end
end


