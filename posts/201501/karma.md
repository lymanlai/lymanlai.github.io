# Install Karma:
$ npm install karma --save-dev

# Install plugins that your project needs:
$ npm install karma-jasmine karma-chrome-launcher --save-dev

# Run Karma:
$ ./node_modules/karma/bin/karma start


[Karma](http://www.yearofmoo.com/2013/01/full-spectrum-testing-with-angularjs-and-karma.html#karma)

Karma is an amazing testing tool which is designed to take all the frustration out of setting up a working test runner when testing JavaScript code. Karma works by spawning up each browser that is specified within its configuration file and then running JavaScript code against those browsers to see if they pass certain tests. Communication between Karma and each of the browsers is handled with the karma service running in the terminal using socket.io. Each time a test is run, Karma records its status and then tallies up which browsers have failed for each test and which ones passed and timed out. This makes each test work 100% natively in each browser without the need to test individually. Also, since the Karma service runs on a port and keeps track of browsers by itself, you can easily hook up other browsers and devices to it just by visiting its broadcasting port. Oh and did I mention that Karma is fast? Yeah it's really fast... :)