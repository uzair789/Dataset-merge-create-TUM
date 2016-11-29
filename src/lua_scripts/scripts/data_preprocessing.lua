--[[
-This is a master script which does the entire data pre-processing and creates train_pairs.txt
and val_pairs.txt.
- train_pairs.txt and val_pairs.txt contain samples from all the datasets merged together.
]]

--[[
********************************************************************************************
* IF train_pairs.txt AND val_pairs.txt EXIST, THEN DELETE THEMBEFORE LAUNCHING THIS SCRIPT *
********************************************************************************************
]]

--local del = io.popen('rm *.txt') -- command to delete train_pairs.txt and val_pairs.txt if exist.

Datasets_to_merge = {}
--input the names of the datasets to be merged in the table below:
Datasets_to_merge = {"freiburg1","freiburg2"}


for datasets_count =1,#Datasets_to_merge do
	s_app = "TUM/"..Datasets_to_merge[datasets_count].."/"
	
	print("PROCESSING DATASET ---> "..s_app)
	paths.dofile('scripts/create_pose_per_image.lua') -- generates a table called 'pose_per_image'
	paths.dofile('scripts/create_train_val.lua') -- generates two tables ---> 1)train_table 2)val_table 
	paths.dofile('scripts/create_data_input_pairs.lua') -- generates the train_pairs.txt and val_pairs.txt
    print("\n")
end
print("DONE!! train_pairs.txt and val_pairs.txt creation complete.")


