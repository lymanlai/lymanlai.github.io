

#[Getting started](http://gruntjs.com/getting-started)
Before setting up Grunt ensure that your npm is up-to-date by running npm update -g npm (this might require sudo on certain systems).

1. Installing the CLI
    npm install -g grunt-cli

2. How the CLI works
    [read the code](https://github.com/gruntjs/grunt-cli/blob/master/bin/grunt)
3. Working with an existing Grunt project
    1. Change to the project's root directory.
    2. Install project dependencies with npm install.
    3. Run Grunt with grunt.
4. Preparing a new Grunt project
    1. package.json: This file is used by npm to store metadata for projects published as npm modules. You will list grunt and the Grunt plugins your project needs as devDependencies in this file.
    2. Gruntfile: This file is named Gruntfile.js or Gruntfile.coffee and is used to configure or define tasks and load Grunt plugins. When this documentation mentions a Gruntfile it is talking about a file, which is either a Gruntfile.js or a Gruntfile.coffee.
5. package.json
    There are a few ways to create a package.json file for your project:
    1. Most [grunt-init](http://gruntjs.com/project-scaffolding) templates will automatically create a project-specific package.json file.
    2. The [npm init](https://npmjs.org/doc/init.html) command will create a basic package.json file.
    3. Start with the example below, and expand as needed, following this specification.
6. Installing Grunt and gruntplugins
    npm install <module> --save-dev
    npm install grunt-contrib-jshint --save-dev
7. The Gruntfile
    A Gruntfile is comprised of the following parts:
    1. The "wrapper" function
    2. Project and task configuration
    3. Loading Grunt plugins and tasks
    4. Custom tasks
8. An example Gruntfile
  ```
      module.exports = function(grunt) {

        // Project configuration.
        grunt.initConfig({
          pkg: grunt.file.readJSON('package.json'),
          uglify: {
            options: {
              banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
            },
            build: {
              src: 'src/<%= pkg.name %>.js',
              dest: 'build/<%= pkg.name %>.min.js'
            }
          }
        });

        // Load the plugin that provides the "uglify" task.
        grunt.loadNpmTasks('grunt-contrib-uglify');

        // Default task(s).
        grunt.registerTask('default', ['uglify']);

      };
    ```
9. The "wrapper" function
    Every Gruntfile (and gruntplugin) uses this basic format, and all of your Grunt code must be specified inside this function:
    ```
        module.exports = function(grunt) {
          // Do grunt-related things in here
        };
    ```
10. Project and task configuration
11. Loading Grunt plugins and tasks
12. Custom tasks

#[Configuring tasks](http://gruntjs.com/configuring-tasks)
1. Grunt Configuration
    ```
        grunt.initConfig({
          concat: {
            // concat task configuration goes here.
          },
          uglify: {
            // uglify task configuration goes here.
          },
          // Arbitrary non-task-specific properties.
          my_property: 'whatever',
          my_src_files: ['foo/*.js', 'bar/*.js'],
        });
    ```
2. Task Configuration and Targets
    ```
        grunt.initConfig({
          concat: {
            foo: {
              // concat task "foo" target options and files go here.
            },
            bar: {
              // concat task "bar" target options and files go here.
            },
          },
          uglify: {
            bar: {
              // uglify task "bar" target options and files go here.
            },
          },
        });
    ```
    Specifying both a task and target like grunt concat:foo or grunt concat:bar will process just the specified target's configuration, while running grunt concat will iterate over all targets, processing each in turn. Note that if a task has been renamed with [grunt.task.renameTask](http://gruntjs.com/grunt.task#grunt.task.renametask), Grunt will look for a property with the new task name in the config object.
3. Options
    nside a task configuration, an options property may be specified to override built-in defaults. In addition, each target may have an options property which is specific to that target. Target-level options will override task-level options.
    The options object is optional and may be omitted if not needed.
    ```
        grunt.initConfig({
          concat: {
            options: {
              // Task-level options may go here, overriding task defaults.
            },
            foo: {
              options: {
                // "foo" target options may go here, overriding task-level options.
              },
            },
            bar: {
              // No options specified; this target will use task-level options.
            },
          },
        });
    ```
4. Files
    All files formats support src and dest but the "Compact" and "Files Array" formats support a few additional properties:
    1. filter [Either a valid fs.Stats method name](http://nodejs.org/docs/latest/api/fs.html#fs_class_fs_stats) or a function that is passed the matched src filepath and returns true or false.
    2. nonull If set to true then the operation will include non-matching patterns. Combined with grunt's --verbose flag, this option can help debug file path issues.
    3. dot Allow patterns to match filenames starting with a period, even if the pattern does not explicitly have a period in that spot.
    4. matchBase If set, patterns without slashes will be matched against the basename of the path if it contains slashes. For example, a?b would match the path /xyz/123/acb, but not /xyz/acb/123.
    5. expand Process a dynamic src-dest file mapping, see ["Building the files object dynamically"](http://gruntjs.com/configuring-tasks#building-the-files-object-dynamically) for more information.
    6. Other properties will be passed into the underlying libs as matching options. See the [node-glob](https://github.com/isaacs/node-glob) and [minimatch](https://github.com/isaacs/minimatch) documentation for more options
5. Compact Format
    This form allows a single src-dest (source-destination) file mapping per-target. It is most commonly used for read-only tasks, like grunt-contrib-jshint, where a single src property is needed, and no dest key is relevant. This format also supports additional properties per src-dest file mapping.
    ```
        grunt.initConfig({
          jshint: {
            foo: {
              src: ['src/aa.js', 'src/aaa.js']
            },
          },
          concat: {
            bar: {
              src: ['src/bb.js', 'src/bbb.js'],
              dest: 'dest/b.js',
            },
          },
        });
    ```
6. Files Object Format
    ```
        grunt.initConfig({
          concat: {
            foo: {
              files: {
                'dest/a.js': ['src/aa.js', 'src/aaa.js'],
                'dest/a1.js': ['src/aa1.js', 'src/aaa1.js'],
              },
            },
            bar: {
              files: {
                'dest/b.js': ['src/bb.js', 'src/bbb.js'],
                'dest/b1.js': ['src/bb1.js', 'src/bbb1.js'],
              },
            },
          },
        });
    ```
7. Files Array Format
    ```
        grunt.initConfig({
          concat: {
            foo: {
              files: [
                {src: ['src/aa.js', 'src/aaa.js'], dest: 'dest/a.js'},
                {src: ['src/aa1.js', 'src/aaa1.js'], dest: 'dest/a1.js'},
              ],
            },
            bar: {
              files: [
                {src: ['src/bb.js', 'src/bbb.js'], dest: 'dest/b/', nonull: true},
                {src: ['src/bb1.js', 'src/bbb1.js'], dest: 'dest/b1/', filter: 'isFile'},
              ],
            },
          },
        });
    ```
8. Older Formats
9. Custom Filter Function
10. Globbing patterns
    1. * matches any number of characters, but not /
    2. ? matches a single character, but not /
    3. ** matches any number of characters, including /, as long as it's the only thing in a path part
    4. {} allows for a comma-separated list of "or" expressions
    5. ! at the beginning of a pattern will negate the match
    ```
        // You can specify single files:
        {src: 'foo/this.js', dest: ...}
        // Or arrays of files:
        {src: ['foo/this.js', 'foo/that.js', 'foo/the-other.js'], dest: ...}
        // Or you can generalize with a glob pattern:
        {src: 'foo/th*.js', dest: ...}

        // This single node-glob pattern:
        {src: 'foo/{a,b}*.js', dest: ...}
        // Could also be written like this:
        {src: ['foo/a*.js', 'foo/b*.js'], dest: ...}

        // All .js files, in foo/, in alpha order:
        {src: ['foo/*.js'], dest: ...}
        // Here, bar.js is first, followed by the remaining files, in alpha order:
        {src: ['foo/bar.js', 'foo/*.js'], dest: ...}

        // All files except for bar.js, in alpha order:
        {src: ['foo/*.js', '!foo/bar.js'], dest: ...}
        // All files in alpha order, but with bar.js at the end.
        {src: ['foo/*.js', '!foo/bar.js', 'foo/bar.js'], dest: ...}

        // Templates may be used in filepaths or glob patterns:
        {src: ['src/<%= basename %>.js'], dest: 'build/<%= basename %>.min.js'}
        // But they may also reference file lists defined elsewhere in the config:
        {src: ['foo/*.js', '<%= jshint.all.src %>'], dest: ...}
    ```
11. Building the files object dynamically
12. Templates
    ```
        grunt.initConfig({
          concat: {
            sample: {
              options: {
                banner: '/* <%= baz %> */\n',   // '/* abcde */\n'
              },
              src: ['<%= qux %>', 'baz/*.js'],  // [['foo/*.js', 'bar/*.js'], 'baz/*.js']
              dest: 'build/<%= baz %>.js',      // 'build/abcde.js'
            },
          },
          // Arbitrary properties used in task configuration templates.
          foo: 'c',
          bar: 'b<%= foo %>d', // 'bcd'
          baz: 'a<%= bar %>e', // 'abcde'
          qux: ['foo/*.js', 'bar/*.js'],
        });
    ```
13. Importing External Data
    ```
        grunt.initConfig({
          pkg: grunt.file.readJSON('package.json'),
          uglify: {
            options: {
              banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
            },
            dist: {
              src: 'src/<%= pkg.name %>.js',
              dest: 'dist/<%= pkg.name %>.min.js'
            }
          }
        });
    ```

#[Sample Gruntfile](http://gruntjs.com/sample-gruntfile)
Below is my configuration object for the "concat" task.
```
  concat: {
    options: {
      // define a string to put between each file in the concatenated output
      separator: ';'
    },
    dist: {
      // the files to concatenate
      src: ['src/**/*.js'],
      // the location of the resulting JS file
      dest: 'dist/<%= pkg.name %>.js'
    }
  }
```
Now lets configure the uglify plugin, which minifies our JavaScript:
```
  uglify: {
    options: {
      // the banner is inserted at the top of the output
      banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
    },
    dist: {
      files: {
        'dist/<%= pkg.name %>.min.js': ['<%= concat.dist.dest %>']
      }
    }
  }
```
This tells uglify to create a file within dist/ that contains the result of minifying the JavaScript files. Here I use <%= concat.dist.dest %> so uglify will minify the file that the concat task produces.

The QUnit plugin is really simple to set up. You just need to give it the location of the test runner files, which are the HTML files QUnit runs on.
Finally we have the watch plugin:
```
  watch: {
    files: ['<%= jshint.files %>'],
    tasks: ['jshint', 'qunit']
  }
```
This can be run on the command line with grunt watch. When it detects any of the files specified have changed (here, I just use the same files I told JSHint to check), it will run the tasks you specify, in the order they appear.
