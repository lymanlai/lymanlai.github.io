[source](https://github.com/yeoman/grunt-usemin)

#The useminPrepare task
#Transformation flow
#Use cases
|
+- app
|   +- index.html
|   +- assets
|       +- js
|          +- foo.js
|          +- bar.js
+- dist


index.html should contain the following block:
```
  <!-- build:js assets/js/optimized.js -->
  <script src="assets/js/foo.js"></script>
  <script src="assets/js/bar.js"></script>
  <!-- endbuild -->
```
useminPrepare config
```
  {
    useminPrepare: {
      html: 'app/index.html',
      options: {
        dest: 'dist'
      }
    }
  }
```