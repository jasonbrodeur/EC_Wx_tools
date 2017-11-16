% Using instructions found here: ftp://client_climate@ftp.tor.ec.gc.ca/Pub/Get_More_Data_Plus_de_donnees/Suggestions_on_installing_Cygwin_and_running_the_command_line_to_download_data.docx
% and here: ftp://ftp.tor.ec.gc.ca/Pub/Get_More_Data_Plus_de_donnees/
% For example, a url that will work (for testing purposes) is: 'http://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=1705&Year=2010&Month=1&Day=14&timeframe=2&submit= Download+Data'
url_base = 'http://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv'; % Don't change
%% Editable parameters
save_dir = 'D:\Local\EC_Wx\Data\'; % Location to save data files.
if isdir(save_dir)==0
    mkdir(save_dir);
end

timeframe = 2; % 1 = hourly; 2 = daily; [3 = monthly (not currently programmed)]
station_ids = [27600; 31688]; % The station ID numbers
start_year = 2016;
end_year = 2017;
compile_flag = 1; % If set to 0, script will download separate files to disk; If set to 1, will compile data for all years for a single station.

%%% Try to automatically cd into the proper directory (assuming the
%%% original structure is being used.
try
   cd(save_dir);
   cd('..');
catch
end
%% Prepare output headers for hourly and daily datasets. Only output
% numeric fields (i.e. flags are not outputted).
switch timeframe
    case 1 % if hourly
        month_list = 12;
        fname_label = 'hourly';
        %         headers = {'Year','Month','Day','Max Temp (째C)','Min Temp (째C)','Mean Temp (째C)','Total Precip (mm)'};
        headers = {'Year',1;'Month',1;'Day',1;'Time',1;'Data Quality',0;'Temp (째C)',1;'Temp Flag',0;'Dew Point Temp (째C)',1;...
            'Dew Point Temp Flag',0;'Rel Hum (%)',1;'Rel Hum Flag',0;'Wind Dir (10s deg)',1;'Wind Dir Flag',0;'Wind Spd (km/h)',1;...
            'Wind Spd Flag',0;'Visibility (km)',1;'Visibility Flag',0;'Stn Press (kPa)',1;'Stn Press Flag',0;'Hmdx',1;'Hmdx Flag',0;...
            'Wind Chill',1;'Wind Chill Flag',0;'Weather',0};
        
    case 2 % if daily
        month_list = 1; % When daily values are being collected, as the entire year of data is returned
        fname_label = 'daily';
        %         headers = {'Year','Month','Day','Max Temp (캜)','Min Temp (캜)','Mean Temp (캜)','Heat Deg Days (캜)','Cool Deg Days (캜)','Total Rain (mm)','Total Snow (cm)','Total Precip (mm)',...
        %             'Snow on Grnd (cm)','Dir of Max Gust (10s deg)','Spd of Max Gust (km/h)'};
        headers = {'Year',1;'Month',1;'Day',1;'Data Quality',0;'Max Temp (째C)',1;'Max Temp Flag', 0;'Min Temp (째C)',1;'Min Temp Flag', 0;...
            'Mean Temp (째C)',1;'Mean Temp Flag', 0;'Heat Deg Days (째C)',1;'Heat Deg Days Flag', 0;'Cool Deg Days (째C)',1;'Cool Deg Days Flag', 0;...
            'Total Rain (mm)',1;'Total Rain Flag', 0;'Total Snow (cm)',1;'Total Snow Flag', 0;'Total Precip (mm)',1;'Total Precip Flag', 0;...
            'Snow on Grnd (cm)',1;'Snow on Grnd Flag', 0;'Dir of Max Gust (10s deg)',1;'Dir of Max Gust Flag', 0;'Spd of Max Gust (km/h)',1;...
            'Spd of Max Gust Flag', 0};
end
%%% Keep only headers that are numeric
ind = find(cell2mat(headers(:,2))==1); % pull out numeric fields only:
headers = headers(ind,1);

% Header that's used for printing final compiled file:
headers_out = strrep(headers,'�',''); % remove the escape character.
if timeframe ==1; headers_out{strcmp(headers_out(:,1),'Time')==1,1} = 'Hour';end % Swap out 'Time' for 'Hour' in header for hourly data.

%% Run the main loop
for i = 1:1:size(station_ids,1)
    out = [];
    for year = start_year:1:end_year
        for month = 1:1:month_list(end)
            switch compile_flag
                case 0
                    switch timeframe
                        case 1 % if hourly
                            filename = [save_dir 'station' num2str(station_ids(i,1)) '-' num2str(year) '-' num2str(month) '-' fname_label '.csv'];
                        case 2 % if monthly
                            filename = [save_dir 'station' num2str(station_ids(i,1)) '-' num2str(year) '-' fname_label '.csv'];
                    end
                case 1
                    filename = [save_dir 'tmp.csv'];
            end
            url = [url_base '&stationID=' num2str(station_ids(i,1)) '&Year=' num2str(year) '&Month=' num2str(month) '&Day=14&timeframe=' num2str(timeframe) '&submit= Download+Data'];
            websave(filename,url);
            
            %%%%%%%%%%If compiling is turned on, create the compiled data
            if compile_flag==1
                [data, result]= readtext(filename, ',', '', '', 'textual');
                data = strrep(data,'"','');
                data = strrep(data,':','.');
                hdr_row = find(strcmp(data(:,1),'Date/Time')==1);
                
                % if hourly data, we need to reformat hour column to a numeric value
                if timeframe == 1
                    time_col = find(strcmp(data(hdr_row,:),'Time')==1);
                    for mm = hdr_row+1:1:length(data)
                        data{mm,time_col} = data{mm,time_col}(1:2);
                    end
                end

                out_tmp = NaN.*ones(length(data)-hdr_row,size(headers,1));
                ctr = 1;
                for j = hdr_row+1:length(data)
                    for k = 1:1:size(headers,1)
                        right_col = find(strcmp(data(hdr_row,:),headers{k,1})==1);
                        %%%%%%%% Debugging purposes only %%%%%%%%%%%%%%%%%%
                        if isempty(right_col)==1
                            disp(['Can''t find correct column for: ' headers{k,1}]);
                        end
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        out_tmp(ctr,k) = str2double(data{j,right_col});
                    end
                    ctr = ctr + 1;
                end
                out = [out; out_tmp];
                clear out_tmp;
            end
        end
    end
    
    % Write entire series (if compile_flag = 1)
    if compile_flag==1
        csvwrite_with_headers([save_dir 'station' num2str(station_ids(i,1)) '-' num2str(start_year) '-' num2str(end_year) '-' fname_label '.csv'],out,headers_out')
    end
end