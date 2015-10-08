gulp = require 'gulp'
browserify = require 'gulp-browserify'
clean = require 'gulp-clean'
del = require 'del'
coffee = require 'gulp-coffee'
gutil = require 'gulp-util'
jade = require 'gulp-jade'
sass = require 'gulp-sass'
ngTemplates = require 'gulp-ng-templates'
gulpIgnore = require 'gulp-ignore'
connect = require 'gulp-connect'

gulp.task 'clean', ->
  del.sync [ 'dist' ]

gulp.task 'jade', ->
  gulp.src 'app/src/index.jade'
    .pipe jade
      pretty: true
    .pipe gulp.dest 'dist'
    .pipe connect.reload()

gulp.task 'sass', ->
  gulp.src('app/src/app.sass')
    .pipe(sass().on('error', gutil.log))
    .pipe(gulp.dest('dist'))
    .pipe connect.reload()

gulp.task 'coffee', ->
  gulp.src('app/src/**/*.coffee')
    .pipe(coffee({bare: true})
    .on('error', gutil.log))
    .pipe(gulp.dest('dist'))
    .pipe connect.reload()

gulp.task 'connect', ->
  connect.server
    root: 'dist'
    livereload: true

gulp.task 'watch', ->
  gulp.watch 'app/src/index.jade', [
    'jade'
  ]

  gulp.watch 'app/src/**/*.sass', [
    'sass'
  ]

  gulp.watch 'app/src/**/*.coffee', [
    'coffee'
  ]

gulp.task 'build', [
  'clean'
  'jade'
  'coffee'
  'sass'
]

gulp.task 'default', [
  'build'
  'connect'
  'watch'
]
