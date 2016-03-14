var gulp = require('gulp'),
    sourcemaps = require('gulp-sourcemaps'),
    gutil = require('gulp-util'),
    uglify = require('gulp-uglify'),
    del = require('del'),
    plumber = require('gulp-plumber'),
    git = require('gulp-git'),
    shell = require('gulp-shell'),
    chug = require('gulp-chug'),
    hub = require('gulp-hub');

var type = gutil.env.type ? gutil.env.type : 'int';
var branch = gutil.env.branch ? gutil.env.branch : 'integration';

var onError = function (err) {
  gutil.beep();
  console.log(err);
};

gulp.task('nuke-it', function() {
  del('/var/www/decidz/websites/' + type + '/www/**/*').then(function (paths) {
    console.log('Deleted files/folders:\n', paths.join('\n'));
  });
});

gulp.task('pull-repo', function() {
  git.pull('origin', branch, {cwd: '/var/www/decidz/gitrepo/decidz-webapp/'}, function (err) {
    if (err) onError(err);
  });
});

gulp.task('build-source', ['pull-repo'], function () {
  var param = '--type ' + type;
  gulp.src('/var/www/decidz/gitrepo/decidz-webapp/gulpfile.js')
    .pipe(chug({
      tasks: ['setup'],
      args: [param]
    }));
});

gulp.task('arrange-webapp', function() {
  gulp.src('/var/www/decidz/gitrepo/decidz-webapp/static/**').pipe(plumber({errorHandler: onError})).pipe(gulp.dest('/var/www/decidz/websites/' + type + '/www'));
  gulp.src('/var/www/decidz/gitrepo/decidz-webapp/build/**').pipe(plumber({errorHandler: onError})).pipe(gulp.dest('/var/www/decidz/websites/' + type +'/www/app'));
  gulp.src('/var/www/decidz/scripts/config/' + type + '/figaro.json').pipe(plumber({errorHandler: onError})).pipe(gulp.dest('/var/www/decidz/websites/' + type + '/www/app'));
});

gulp.task('watch', function() {
  gulp.watch('/var/www/decidz/flagfiles/deploywstoint.flg', ['pull repo', 'prep-files', 'arrange-webapp']);
});

gulp.task('deploy', ['nuke-it', 'pull-repo', 'arrange-webapp']);

hub(['../../gitrepo/decidz-webapp/gulpfile.js', './gulpfile.js']);