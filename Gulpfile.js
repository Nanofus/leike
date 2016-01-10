'use strict';

var gulp = require('gulp');
var sass = require('gulp-sass');
var coffee = require('gulp-coffee');
var gutil = require('gulp-util');
var del = require('del');
var electron = require('gulp-electron');
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
});

gulp.task('electron', function() {
    gulp.src("")
    .pipe(electron({
        src: './app',
        packageJson: packageJson,
        release: './build',
        cache: './cache',
        version: 'v0.36.3',
        packaging: true,
        platforms: ['win32-ia32'],
        platformResources: {
            win: {
                "version-string": packageJson.version,
                "file-version": packageJson.version,
                "product-version": packageJson.version,
                "icon": './app/img/icon.ico'
            }
        }
    }))
    .pipe(gulp.dest(""));
});

gulp.task('watch', function() {
  gulp.watch('./scss/**/*.scss', ['sass']);
  gulp.watch('./src/*.coffee', ['coffee']);
});

gulp.task('clean', function() {
    return del(['./app/build']);
});

gulp.task('cleandist', function() {
    return del(['./dist']);
});
gulp.task('cleandist:osx', function() {
    return del(['./dist/osx']);
});
gulp.task('cleandist:win', function() {
    return del(['./dist/win']);
});

gulp.task('default', ['clean'], function() {
  gulp.start('sass', 'coffee');
});
