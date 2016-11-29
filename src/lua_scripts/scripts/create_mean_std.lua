--[[This script computs the mean and the standard deviation.
steps:
1- First a table of image names of the images from the dataset is created.
2- The table of image names is used to calculate the mean and the std values per channel 
over all the images.
3- The mean and the std values are currently only displayed and not saved to a text file.
In future, they will be saved to a txt file and then that file will be used to access the 
values.
--]]

require 'image'
--function to load and crop the images
local function loadImage(path)


   local input = image.load(path, 3, 'float')

   --resize the image 
   input = image.crop(input, "c",480,480) 
   --image.display(input) --For debugging purpose
   --crop the image to 480*480
   input = image.scale(input, 227, 227) 
   --check if it is 227 or 224 for the size
   --think of a more general way to do it
   --random crops to increase dataset ? like in imagenet
   --importance of where to crop
   
  -- image.display(input) --For debugging purpose

     return input
end

--loading the rgb image names from train.txt
print("Creating the Images names table...")
local file = io.open("train.txt")--loading the train.txt as it contains all the image names used 
--in training
image_names={}
kk = 0 
if file then
	for line in file:lines() do
		--print(line)
    	kk= kk+1
        timestamp, img_name, ts, tx, ty, tz, qx, qy, qz, qw = unpack(line:split(" ")) 
        --unpack turns a table like the one given (if you use the recommended version) into a bunch of separate variables
	    image_names[kk] = img_name
        if kk ==3 then break end
    end
else
end
io.close(file)

--calculating the mean and the std (pixel-wise) amongst all the images

print('Estimating the mean (per-channel, shared for all pixels) over ' .. #image_names .. ' randomly sampled training images')
local meanEstimate = {0,0,0}
for i=1,#image_names do
	local img = loadImage(image_names[i])
	for j=1,3 do
        meanEstimate[j] = meanEstimate[j] + img[j]:mean()
    end
end
for j=1,3 do
    meanEstimate[j] = meanEstimate[j] / #image_names
end
mean = meanEstimate	

print('Estimating the std (per-channel, shared for all pixels) over ' .. #image_names .. ' randomly sampled training images')
local stdEstimate = {0,0,0}
for i=1,#image_names do
    local img = loadImage(image_names[i])
    for j=1,3 do
        stdEstimate[j] = stdEstimate[j] + img[j]:std()
    end
end
for j=1,3 do
    stdEstimate[j] = stdEstimate[j] / #image_names
end
std = stdEstimate

print(mean)
print(std)
--file = io.open('mean_std_tain.txt',"w+")
--l="mean " .. mean[1]..mean[2]..mean[3] .. "std" .. std[1]..std[2]..std[3]
--print(l)
--io.write(l)

