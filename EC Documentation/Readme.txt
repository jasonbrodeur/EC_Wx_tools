Readme.txt

URL based procedure to automatically download data in bulk from Climate Website
(http://www.climate.weather.gc.ca)
Version: 2016-05-10

----------------------------------------
ENVIRONMENT AND CLIMATE CHANGE CANADA


To read this file online, please visit:
ftp://client_climate@ftp.tor.ec.gc.ca/Pub/Get_More_Data_Plus_de_donnees/ 

Folder: Get_More_Data_Plus_de_donnees > Readme.txt

Instructions on how to download all weather data for one station from Environment and Climate Change Canada's Climate website: 

A daily updated list of Climate stations in the National Archive, including their Climate ID, Station ID, WMO ID, TC ID, and co-ordinates can be found in the following folder:  
Get_More_Data_Plus_de_donnees > Station Inventory EN.csv

Use the following utility to download data: 
• wget (GNU / Linux Operating systems)
• Cygwin (Windows Operating systems) https://www.cygwin.com
• Homebrew (OS X - Apple)  http://brew.sh/
Example to download all available hourly data for Yellowknife A, from 1998 to 2008, in .csv format


Command line:  

for year in `seq 1998 2008`;do for month in `seq 1 12`;do wget --content-disposition "http://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=1706&Year=${year}&Month=${month}&Day=14&timeframe=1&submit= Download+Data" ;done;done


WHERE; 
• year = change values in command line (`seq 1998 2008)
• month = change values in command line (`seq 1 12)
• format= [csv|xml]: the format output
• timeframe = 1: for hourly data 
• timeframe = 2: for daily data 
• timeframe = 3 for monthly data 
• Day: the value of the "day" variable is not used and can be an arbitrary value 
• For another station, change the value of the variable stationID
• For the data in XML format, change the value of the variable format to xml in the URL. 

For information in French, change Download+Data with ++T%C3%A9l%C3%A9charger+%0D%0Ades+donn%C3%A9es, also change _e with _f in the url.


For questions or concerns please contact our National Climate Services office at: 
ec.services.climatiques-climate.services.ec@canada.ca  

