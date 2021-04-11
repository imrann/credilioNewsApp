# credilio_news

A new Flutter project.

## Getting Started
 
This App provide breaking/top-headlines news from India.
- News category based seperation
- Available categories : business/entertainment/general/health/science/sports/technology
- Grid & List view for categorized news
- Search feature
- Breaking News cards.
- All news will open in a web view
- Random/breaking news horizontal view available on top of web view for quick access
- dynamic rendering of news(pagination)


Steps to run the app:

- clone the source code to your local machine
- change the _apikey member variable inside AppConfig.dart file present inside lib/CommonScreens folder
- As the _apikey is required by the https://newsapi.org/ for access, the old key which is already present in the AppConfig.dart file may already exceeded the free quota.
- connect your device
- clean & run  the code using flutter clean & flutter run -d [device id] respectively
- to build .apk file , execute flutter build apk


CI/CD:
- Simply use the git url for this repo and integrate it in codemagic to build the .apk file
