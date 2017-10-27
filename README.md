# EC_Wx_tools
Tools to facilitate batch downloading of historical station data from Environment Canada

get_EC_Wx.m - Downloads daily data as monthly files for all station IDs and years listed.

get_EC_Wx_octave.m - Octave-friendly version of get_EC_Wx.m
- Contains additional functionality controlled by parameter *compile_flag*

if compile_flag == 0, script will download separate (monthly) files to disk; 
If compile_flag == 1, script will compile data for all years and a single station, and save as one large csv file of selected columns.

