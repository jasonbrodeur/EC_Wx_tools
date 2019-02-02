# EC_Wx_tools
Matlab/Octave tools to facilitate batch downloading of historical station data from Environment Canada

## Main scripts:
- get_EC_Wx.m - Downloads hourly or daily data as monthly (or all-years-compiled) files for all station IDs and years listed (Matlab version)
- get_EC_Wx_octave.m - Octave-friendly version of get_EC_Wx.m

## Requirements
- Octave (to run get_EC_Wx_octave) or Matlab (to run get_EC_Wx) 
- the other functions included in the top-level folder (csvwrite_with_headers.m and readtext.m)

# How these scripts work: 

These scripts automate URL-based retrieval of daily historical Environment Canada station data, by iterating over a list of stations (identified by station ID numbers in the *station_ids* variable of the script), and years (set through *start_year* and *end_year* variables). The output is either a collection of separate files (annual csv files for daily data; monthly csv files for hourly data), or a single all-years file. 

The time increment of the data (i.e. hourly or daily) is controlled by the value of the variable *timeframe*
- if timeframe == 1, script collects hourly data;
- if timeframe == 2, script collects daily data;

The nature of the output is controlled by the value of the variable *compile_flag*
- if compile_flag == 0, script will download separate (monthly) files to disk; 
- If compile_flag == 1, script will compile data for all years and a single station, and save as one large csv file of selected columns.

As of 10-Nov, 2017 update, all numeric variables included in the original files are now found in the compiled file.

## Configuring and running in Octave:
- *video introduction available [here](https://youtu.be/m82-pJdtrHk)
- Download the [EC_Wx repository](https://github.com/jasonbrodeur/EC_Wx_tools/archive/master.zip); unzip in a working directory (it should unzip as a folder named 'EC_Wx_tools-master')
- Open up Octave 
- in the command window, change to the EC_Wx_tools-master directory 
---- e.g. cd('D:\Mystuff\EC_Wx_tools-master') (Replace D:\Mystuff with your actual directory
- Open the get_EC_Wx_octave.m function in the Octave editor
- modify the value of save_dir to match your working directory
---- e.g. in the example provided above, you would change it to 'D:\Mystuff\EC_Wx_tools-master\Data\' (note that the trailing slash is important and necessary)
- edit the values for start_year and end_year to match your requirements 
- edit the list provided in station_ids, to match the IDs of the stations you want to download from - [here is a link](https://github.com/jasonbrodeur/EC_Wx_tools/tree/master/EC%20Documentation) to the Station directory. Use values found in the "Station ID" field.
---- be sure that each id number is separated by a semicolon (this will make an nx1 column vector)
- If you want to compile the data into a single (long) csv for all years at a given site, keep compile_flag=1; If you want to download individual monthly files, change its value to 0; 
- Once you've done this, you should be able to click 'Run'. It should then work its way through the sites, downloading monthly files to a file called 'tmp.csv', reopening that file and appending it to the master list, which will be saved at the end. 


# More information on extracting historical environment canada climate and weather
Updated documentation from EC can be found in [this ftp directory](ftp://ftp.tor.ec.gc.ca/Pub/Get_More_Data_Plus_de_donnees/) on the EC server. A copy of each of these materials (as of 10-Nov,2017) is also available in the [EC Documentation](https://github.com/jasonbrodeur/EC_Wx_tools/tree/master/EC%20Documentation) directory.
- The readme.txt provides a short reference for accessing this data via URLs
- The station inventory (Station Inventory EN.csv) may be foundin the [EC Documentation](https://github.com/jasonbrodeur/EC_Wx_tools/tree/master/EC%20Documentation) directory
- More detailed instructions on constructing the URL string are found [here](https://github.com/jasonbrodeur/EC_Wx_tools/tree/master/EC%20Documentation). 
**Note that this document suggests a wget-based approach, which includes installing cygwin. This is NOT required if you use the scripts and functions included in this repository.**
