% Using instructions found here: ftp://client_climate@ftp.tor.ec.gc.ca/Pub/Get_More_Data_Plus_de_donnees/Suggestions_on_installing_Cygwin_and_running_the_command_line_to_download_data.docx
% and here: ftp://ftp.tor.ec.gc.ca/Pub/Get_More_Data_Plus_de_donnees/Readme.txt
% For example, a url that will work (for testing purposes) is: 'http://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=1705&Year=2010&Month=1&Day=14&timeframe=2&submit= Download+Data'
url_base = 'http://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv'; % Don't change
save_dir = 'D:\Local\EC_Wx\Data\'; % Location to save data files.
timeframe = 2; % 1 = hourly; 2 = daily; 3 = monthly
station_ids = [1705; 1706; 1834; 1900]; % The station ID numbers
start_year = 2010;
end_year = 2017;
compile_flag = 1; % If set to 0, script will download separate files to disk; If set to 1, will compile data for all years for a single station.
headers = {'Year','Month','Day','Max Temp (°C)','Min Temp (°C)','Mean Temp (°C)','Total Precip (mm)'};


for i = 1:1:size(station_ids,1)
  out = [];
    for year = start_year:1:end_year
        for month = 1:1:12
          switch compile_flag
            case 0
              filename = [save_dir 'station' num2str(station_ids(i,1)) '-' num2str(year) '-' num2str(month) '-daily.csv'];
            case 1
              filename = [save_dir 'tmp.csv'];
          end
            url = [url_base '&stationID=' num2str(station_ids(i,1)) '&Year=' num2str(year) '&Month=' num2str(month) '&Day=14&timeframe=' num2str(timeframe) '&submit= Download+Data'];
            filename = [save_dir num2str(station_ids(i,1)) '-' num2str(year) '-' num2str(month) '-daily.csv'];
            websave(filename,url);
            
            if compile_flag==1
              [data, result]= readtext(filename, ',', '', '', 'textual');
              data = strrep(data,'"','');
              data = strrep(data,':','.');
              hdr_row = find(strcmp(data(:,1),'Date/Time')==1);
              yr_col = find(strcmp(data(hdr_row,:),'Year')==1);
              mon_col = find(strcmp(data(hdr_row,:),'Month')==1);
              day_col = find(strcmp(data(hdr_row,:),'Day')==1);
              Tmax_col = find(strcmp(data(hdr_row,:),'Max Temp (°C)')==1);
              Tmin_col = find(strcmp(data(hdr_row,:),'Min Temp (°C)')==1);
              Tmean_col = find(strcmp(data(hdr_row,:),'Mean Temp (°C)')==1);
              PPT_col = find(strcmp(data(hdr_row,:),'Total Precip (mm)')==1);
              out_tmp = NaN.*ones(length(data)-hdr_row,7);
              ctr = 1;
              for j = hdr_row+1:length(data)
                  out_tmp(ctr,1:7) = [str2double(data{j,yr_col}) str2double(data{j,mon_col}) str2double(data{j,day_col}) ...
                      str2double(data{j,Tmax_col}) str2double(data{j,Tmin_col}) str2double(data{j,Tmean_col}) str2double(data{j,PPT_col}) ];
                  ctr = ctr + 1;
              end
              out = [out; out_tmp];
              clear out_tmp;
            end
            
            
            
        end
    end
    % Write entire series (if compile_flag = 1)
    if compile_flag==1
    csvwrite_with_headers([save_dir 'station' num2str(station_ids(i,1)) '-' num2str(start_year) '-' num2str(end_year) '-daily.csv'],out,headers)
    end
end