% Using instructions found here: ftp://client_climate@ftp.tor.ec.gc.ca/Pub/Get_More_Data_Plus_de_donnees/Suggestions_on_installing_Cygwin_and_running_the_command_line_to_download_data.docx
% and here: ftp://ftp.tor.ec.gc.ca/Pub/Get_More_Data_Plus_de_donnees/Readme.txt
% For example, a url that will work (for testing purposes) is: 'http://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=1705&Year=2010&Month=1&Day=14&timeframe=2&submit= Download+Data'
url_base = 'http://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv'; % Don't change
save_dir = 'D:\Local\EC_Wx\Data\'; % Location to save data files.
timeframe = 2; % 1 = hourly; 2 = daily; 3 = monthly
station_ids = [1705; 1706; 1834; 1900]; % The station ID numbers
start_year = 2010;
end_year = 2017;
for i = 1:1:size(station_ids,1)
    for year = start_year:1:end_year
        for month = 1:1:12
            url = [url_base '&stationID=' num2str(station_ids(i,1)) '&Year=' num2str(year) '&Month=' num2str(month) '&Day=14&timeframe=' num2str(timeframe) '&submit= Download+Data'];
            filename = [save_dir num2str(station_ids(i,1)) '-' num2str(year) '-' num2str(month) '-daily.csv'];
            websave(filename,url);
        end
    end
end