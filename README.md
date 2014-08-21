dipnet_app
==========

This project is from the Spring 2014 hAKathon. It's live from the most recent year at http://codeforanchorage.shinyapps.io/dipnet_app/

The goal of this project is to create a mobile and web application for modeling and tracking the real time returns of sockeye to the Kenai river to find the best times to go dipnetting.

The fish count data is available in the repository and also available at the current time at https://www.adfg.alaska.gov/sf/FishCounts/index.cfm?ADFG=main.LocSelectYearSpecies. The years can be highlighted and the data is available in an excel format. The data is taken most recently from sonar counts 19 miles from the river entrance. The migration into the river from Cook Inlet is also dependent on tide data. The tide data for 2014 has also been included in this repository.  

	Installation

1. Download
2. redirect a base directory where the four data files exist for the project in server.R
3. Set up a web scrapper to get the test fish and sonar data daily and save to the base directory for the app.
5. Set up the processing scripts to run routinely 
6. Run in shiny-server or as a local instance. 
