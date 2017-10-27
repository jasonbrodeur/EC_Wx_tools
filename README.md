# EC_Wx_tools
Matlab/Octave tools to facilitate batch downloading of historical station data from Environment Canada

get_EC_Wx.m - Downloads daily data as monthly files for all station IDs and years listed (Matlab version)

get_EC_Wx_octave.m - Octave-friendly version of get_EC_Wx.m


Functions contain additional functionality controlled by parameter *compile_flag*

- if compile_flag == 0, script will download separate (monthly) files to disk; 
- If compile_flag == 1, script will compile data for all years and a single station, and save as one large csv file of selected columns.

# Requirements
- Octave (to run get_EC_Wx_octave) or Matlab (to run get_EC_Wx) 
- the other functions included in the top-level folder (csvwrite_with_headers.m and readtext.m)

#To run in Octave:
- Download the EC_Wx repository; unzip in a working directory (it should unzip as a folder named 'EC_Wx_tools-master')
- Open up Octave 
- in the command window, change to the EC_Wx_tools-master directory 
---- e.g. cd('D:\Mystuff\EC_Wx_tools-master') (Replace D:\Mystuff with your actual directory
- Open the get_EC_Wx_octave.m function in the Octave editor
- modify the value of save_dir to match your working directory
---- e.g. in the example provided above, you would change it to 'D:\Mystuff\EC_Wx_tools-master\Data\' (note that the trailing slash is important and necessary)
- edit the values for start_year and end_year to match your requirements 
- edit the list provided in station_ids, to match the IDs of the stations you want to download from (here is a link to the Station directory) 
---- be sure that each id number is separated by a semicolon (this will make an nx1 column vector)
- If you want to compile the data into a single (long) csv for all years at a given site, keep compile_flag=1; If you want to download individual monthly files, change its value to 0; 
- Once you've done this, you should be able to click 'Run'. It should then work its way through the sites, downloading monthly files to a file called 'tmp.csv', reopening that file and appending it to the master list, which will be saved at the end. 