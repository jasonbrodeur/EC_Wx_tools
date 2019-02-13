%%% run_get_EC_Wx.m 
% Sample run script for get_EC_Wx function. 
% Created by JJB.

% Step 1: change the current directory to the location of your unzipped
% Ec_Wx folder
cd('C:\Users\brodeujj\Downloads\Ec_Wx');
% cd('D:\Local\EC_Wx\Data\'); % used by Jay on his work PC

save_dir = [pwd '\Data\']; % Set to the data directory
timeframe = 2; % 1 = hourly; 2 = daily; [3 = monthly (not currently programmed)]
start_year = 1950;
end_year = 2010;
compile_flag = 1; % If set to 0, script will download separate files to disk; If set to 1, will compile data for all years for a single station.
station_ids = [889; 2205; 3698; 5097; 6720; 5415]; % ID numbers of stations to be downloaded
% Winnipeg Intl airport (1938 to 2013): 3698
% Calgary Intl airport (1953 to 2012): 2205
% Toronto (Pearson) Intl airport (1937 to 2013):5097
% St. John's NL Airport (1942 to 2012): 6720
% Vancouver Intl Airport (1937 to 2013): 889
% Montreal (Pierre Elliot Trudeau) Airport (1941 to 2017): 5415

% run the function: 
get_EC_Wx(save_dir, timeframe, station_ids, start_year, end_year, compile_flag)