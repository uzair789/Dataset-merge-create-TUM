Some scripts I wrote in Lua and python while working with the TUM datasets.

- THese scripts merge diffrent sequences together and also compute transforamtions between them.

- Drop the datasets that need to be merged in the TUM folder. THese scripts will only use the .txt file with the image locations to access the orientation of the image and compute the transformation with the second image that is loaded. The transformations are coputed between all the possible pairs and not just successive pairs.

- After dropping the datasets in the TUM folder, specify the folder names in the 'data_processing.lua' script. 

- I also wrote some description at the beginning of each script for easy reference.

- Some of the scripts are also available in python. 


