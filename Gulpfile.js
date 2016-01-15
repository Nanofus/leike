'use strict';

var gulp = require('gulp');
var sass = require('gulp-sass');
var coffee = require('gulp-coffee');
var gutil = require('gulp-util');
var del = require('del');
var packageJson = require('./package.json');

gulp.task('sass', function () {
  gulp.src('./scss/**/*.scss')
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest('./app/build/css'));
});

gulp.task('coffee', function() {
  gulp.src('./src/*.coffee')
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./app/build'));
  gulp.src('./main.coffee')
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./app'));
});

gulp.task('watch', function() {
  gulp.watch('./scss/**/*.scss', ['sass']);
  gulp.watch('./src/*.coffee', ['coffee']);
});

gulp.task('clean', function() {
    return del(['./app/build']);
});

gulp.task('cleandist', function() {
    return del(['./builds']);
});
gulp.task('cleandist:win', function() {
    return del(['./builds/win']);
});
gulp.task('cleandist:win64', function() {
    return del(['./builds/win64']);
});
gulp.task('cleandist:osx', function() {
    return del(['./builds/osx']);
});
gulp.task('cleandist:linux', function() {
    return del(['./builds/linux']);
});
gulp.task('cleandist:linux64', function() {
    return del(['./builds/linux64']);
});

gulp.task('default', ['clean'], function() {
  gulp.start('sass', 'coffee');
});
