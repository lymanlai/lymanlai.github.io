
[source](http://www.smashingmagazine.com/2014/06/11/building-with-gulp/)

[api](https://github.com/gulpjs/gulp/blob/master/docs/API.md)

#What Is Gulp?
#Installing Gulp
npm install -g gulp
npm install --save-dev gulp
#Using Gulp
Put the following in your gulpfile.js file:
```
var gulp = require('gulp'),
   uglify = require('gulp-uglify');

gulp.task('minify', function () {
   gulp.src('js/app.js')
      .pipe(uglify())
      .pipe(gulp.dest('build'))
});
```
npm install --save-dev gulp-uglify
#STREAMS
#GULP.SRC()
js/app.js
Matches the exact file
js/*.js
Matches all files ending in .js in the js directory only
js/**/*.js
Matches all files ending in .js in the js directory and all child directories
!js/app.js
Excludes js/app.js from the match, which is useful if you want to match all files in a directory except for a particular file
*.+(js|css)
Matches all files in the root directory ending in .js or .css
Let’s say that we have a directory named js containing JavaScript files, some minified and some not, and we want to create a task to minify the files that aren’t already minified. To do this, we match all JavaScript files in the directory and then exclude all files ending in .min.js:
gulp.src(['js/**/*.js', '!js/**/*.min.js'])
#DEFINING TASKS
#DEFAULT TASKS
#PLUGINS
#GULP-LOAD-PLUGINS
#WATCHING FILES
#Reloading Changes In The Browser
1. LIVERELOAD
```
var gulp = require('gulp'),
    less = require('gulp-less'),
    livereload = require('gulp-livereload'),
    watch = require('gulp-watch');

gulp.task('less', function() {
   gulp.src('less/*.less')
      .pipe(watch())
      .pipe(less())
      .pipe(gulp.dest('css'))
      .pipe(livereload());
});
```
2. BROWSERSYNC
npm install --save-dev browser-sync
```
var gulp = require('gulp'),
    browserSync = require('browser-sync');

gulp.task('browser-sync', function () {
   var files = [
      'app/**/*.html',
      'app/assets/css/**/*.css',
      'app/assets/imgs/**/*.png',
      'app/assets/js/**/*.js'
   ];

   browserSync.init(files, {
      server: {
         baseDir: './app'
      }
   });
});
```
Running gulp browser-sync would then watch the matching files for changes and start a server that serves the files in the app directory.
The developer of BrowserSync has written about some other things you can do in his [BrowserSync](http://www.browsersync.io/) + Gulp repository.
#Why Gulp?


