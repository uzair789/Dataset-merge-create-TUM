--[[
This script is a lua implementation of create_pose_per_image.py
]]
print(" --- running create_pose_per_image.lua --> output saved in table pose_per_image...")

--s_app = "TUM/"..Datasets_to_merge[datasets_count].."/"
local file = io.open(s_app.."rgb.txt") -- s_app comes from data_preprocessing.lua

pose_per_image={}
local out = 1
local k = 0
if file then
	for line in file:lines() do
		--print(line)
		k=k+1
		if k>3 then --to avoid the # comments at the top three lines
			--print(k)
			ts_rgb, img  = unpack(line:split(" "))
			img = s_app..img
			line = ts_rgb.." "..img
			--print(ts)
			ts_rgb0, ts_rgb1 = unpack(ts_rgb:split("%."))
			--print(ts_0)
			--print(ts_1)
			flag = 0
			min_val = 1000000
			local file2 = io.open(s_app.."groundtruth.txt")
			local k2=0
			for line2 in file2:lines() do
				k2=k2+1
				if k2>3 then
					ts_gt,tx,ty,tz,qx,qy,qz,qw = unpack(line2:split(" "))
					ts_gt0, ts_gt1 = unpack(ts_gt:split("%."))
					--print(ts_rgb0.."-----"..ts_gt0)
					--print(ts_gt0)
					if ts_rgb0 == ts_gt0 then
						--print(ts_rgb1.."-->"..ts_gt1)
						diff = math.abs(tonumber(ts_rgb1) - tonumber(ts_gt1..'00'))
						if diff<min_val then
							op = line.." "..line2
							--print(op)
							flag = 1
							min_val=diff
						end

					end
				end
			end
			if (flag ==1 and min_val < 9000) then --found 8xxx to be the maximum min value. 
				--print(op)
				--print(min_val)
				pose_per_image[out] = op
				out=out+1
			end
			file2:close(s_app.."groundtruth.txt")
		end
	end
end

file:close(s_app.."rgb.txt")
