--[[This script loads the input pairs and creates a table with each row containing
image1,image2 and label.
trainset[i].image1 gives the first image on the ith row
trainset[i].image2 gives the second image on the ith row
trainset[i].label gives the 7 dimensional label vector on the ith row

As the the sgd requirements, an index and size functions are also 
added to the trainset table.

After creating the table, the table is shuffled. function 'shuffleTable()' does this operation.
--]]
local file = io.open("data_input_pairs_train.txt")
trainset={}
k = 0 
if file then
	for line in file:lines() do
		--print(line)
    	k= k+1
        img1_index, img1, img2_index, img2, tx, ty, tz, qx, qy, qz, qw, norm = unpack(line:split(" ")) 
         --unpack turns a table like the one given (if you use the recommended version) into a bunch of separate variables
       	labell = {tx, ty, tz, qx, qy, qz, qw}
       trainset[k] = {image1 = img1, image2 = img2, label = labell}
       --if k ==5 then break end --for debugging
    end
else
end

--creating the index and size functions as per the sgd requirements
setmetatable(trainset, 
    {__index = function(t, ii) 
                    return {t[ii].image1, t[ii].image2, t[ii].label} 
                end}
);

--creating the size function 
function trainset:size()
	--trainset.size={}
	--trainset.size=i
	return k--trainset.size
end


math.randomseed( os.time() )
local function shuffleTable( t )
    local rand = math.random 
    assert( t, "shuffleTable() expected a table, got nil" )
    local iterations = #t
    local j
    for i = iterations, 2, -1 do
        j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
    --return t
end
 
shuffleTable( trainset )--shuffles the table

