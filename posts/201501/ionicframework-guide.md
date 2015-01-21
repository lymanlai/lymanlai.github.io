#[source](http://ionicframework.com/docs/guide/)

#Chapter 1: All About Ionic
1. What is Ionic, and where does it fit?
2. Why did we build Ionic?
3. Building Hybrid Apps With Ionic
4. Get building!

#Chapter 2: Installation
1. Platform notes
    sudo npm install -g cordova
2. Install Ionic
    sudo npm install -g ionic
3. Create the project
    ionic start todo blank
    cd todo && ls
4. Configure Platforms
    ionic platform add ios
5. Test it out
    ionic build ios
    ionic emulate ios

#Chapter 3: Starting your app
1. Let's create www/index.html and initialize it
2. Edit the index.html file and change the <body> content
3. Initializing the app
    1. create a new file located at www/js/app.js
        angular.module('todo', ['ionic'])
    2.  go back to index.html and right before the <script src="cordova.js"></script>
        line,   add: <script src="js/app.js"></script>
    3. <body ng-app="todo">
    4. add a header for both the center content area and the left menu

#Chapter 4: Testing your app
1. Desktop browser testing
2. Simulator testing
    ionic build ios
     ionic emulate ios
3. Mobile browser testing
4. Testing as a native app

#Chapter 5: Building out your app
1. Creating tasks
2. Adding projects

#Chapter 6: Publishing your app
1. Android Publishing
2. Google Play Store
3. Updating your App