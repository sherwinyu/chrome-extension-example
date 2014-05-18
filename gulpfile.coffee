# Modules
gulp = require('gulp')
clean = require('gulp-rimraf')
coffee = require('gulp-coffee')
concat = require('gulp-concat')
jade = require('gulp-jade')
order = require('gulp-order')
plumber = require('gulp-plumber')
sass = require('gulp-ruby-sass')
uglify = require('gulp-uglify')

# Clean
gulp.task 'clean', ->
  gulp.src('./build', {read: false})
    .pipe(clean())

# Clean all
gulp.task 'wipe', ['clean'], ->
  gulp.src('./node_modules', {read: false})
    .pipe(clean())

# Vendor Files
gulp.task 'vendor', ->

# Coffee
gulp.task 'coffee', ->
  gulp.src('./_src/coffee/**/*.coffee')
    .pipe(plumber())
    .pipe(coffee({bare:true}))
    .pipe(concat('main.js'))
    .pipe(uglify())
    .pipe(gulp.dest('./build/js'))

# Sass
gulp.task 'sass', ->
  gulp.src('./_src/sass/*.sass')
    .pipe(plumber())
    .pipe(sass({compass: true}))
    .pipe(gulp.dest('./build/css'))

# Jade
gulp.task 'jade', ->
  gulp.src('./_src/jade/**/*.jade')
    .pipe(plumber())
    .pipe(jade())
    .pipe(gulp.dest('./build'))

# Chrome Files
gulp.task 'chrome', ->
  gulp.src('./_src/chrome/icon.png')
    .pipe(gulp.dest('./build'))
  gulp.src('./_src/chrome/manifest.json')
    .pipe(gulp.dest('./build'))

# Build
gulp.task 'build', ['vendor', 'coffee', 'sass', 'jade', 'chrome']

# Watch/LiveReload
gulp.task 'watch', ['build'], ->
  gulp.watch './_src/coffee/**/*.coffee', ['coffee']
  gulp.watch './_src/sass/**/*.sass', ['sass']
  gulp.watch './_src/jade/**/*.jade', ['jade']

# Default
gulp.task 'default', ['build']


