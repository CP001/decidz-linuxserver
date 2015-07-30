// Include gulp
var gulp = require('gulp'); 

// Include Our Plugins
var jshint = require('gulp-jshint');
var sass = require('gulp-sass');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');
var ngAnnotate = require('gulp-ng-annotate');
var htmlreplace = require('gulp-html-replace');
var rev = require('gulp-rev');
var stripDebug = require('gulp-strip-debug');
var templateCache = require('gulp-angular-templatecache');
var minifyHTML = require('gulp-minify-html');

gulp.task('htmltemplatesandjsb1tasks', function() {
    runSequence('combinehtmltemplates', 'jsb1tasks', function() {
    });
});
 
// Concatenate & Minify JS
// gulp.task('jsb1tasks', ['combinehtmltemplates'], function() {
gulp.task('jsb1tasks', function() {
    return gulp.src(['/var/www/decidz/websites/preprod/www/app.js',
                     '/var/www/decidz/websites/preprod/www/config.js',
                     '/var/www/decidz/websites/preprod/www/controllers.js',
                     '/var/www/decidz/websites/preprod/www/noodle/noodle.js',
                     '/var/www/decidz/websites/preprod/www/noodleedit/noodleedit.js',
                     '/var/www/decidz/websites/preprod/www/home/home.js',
                     '/var/www/decidz/websites/preprod/www/menu/menu.js',
                     '/var/www/decidz/websites/preprod/www/chat/chat.js',
                     '/var/www/decidz/websites/preprod/www/who/who.js',
                     '/var/www/decidz/websites/preprod/www/sync/sync.js',
                     '/var/www/decidz/websites/preprod/www/leave/leave.js',
                     '/var/www/decidz/websites/preprod/www/create/create.js',
                     '/var/www/decidz/websites/preprod/www/factories/firebaseUser.js',])
//                     '/var/www/decidz/websites/preprod/www/js/templates.js'])
//        .pipe(ngAnnotate())
        .pipe(concat('all1.js'))
        .pipe(gulp.dest('/var/www/decidz/websites/preprod/temp/jsb1'))
        .pipe(rename('js1.js'))
//        .pipe(uglify())
        .pipe(stripDebug())
		.pipe(rev())
        .pipe(gulp.dest('/var/www/decidz/websites/preprod/www/js'))
		.pipe(rev.manifest())
        .pipe(gulp.dest('/var/www/decidz/websites/preprod/temp/jsb1')); // write manifest to build dir 
});

gulp.task('jsb2tasks', function() {
    return gulp.src(['/var/www/decidz/websites/preprod/www/bower_components/angular-translate/angular-translate.js',
                     '/var/www/decidz/websites/preprod/www/bower_components/angular-translate/angular-translate-loader-static-files.js',
                     '/var/www/decidz/websites/preprod/www/bower_components/angular-bootstrap-datetimepicker/src/js/datetimepicker.js',
                     '/var/www/decidz/websites/preprod/www/bower_components/angular-cookie/angular-cookie.min.js',
                     '/var/www/decidz/websites/preprod/www/bower_components/zeroclipboard/dist/ZeroClipboard.js',
                     '/var/www/decidz/websites/preprod/www/bower_components/ng-fi-text/dist/ng-fi-text.min.js',
                     '/var/www/decidz/websites/preprod/www/bower_components/angular-scroll-glue/src/scrollglue.js',
                     '/var/www/decidz/websites/preprod/www/bower_components/angulartics/dist/angulartics.min.js',
                     '/var/www/decidz/websites/preprod/www/bower_components/angular-filter/dist/angular-filter.js',
                     '/var/www/decidz/websites/preprod/www/bower_components/angulartics/dist/angulartics-ga.min.js'])
//        .pipe(ngAnnotate())
        .pipe(concat('all2.js'))
        .pipe(gulp.dest('/var/www/decidz/websites/preprod/temp/jsb2'))
        .pipe(rename('js2.js'))
//        .pipe(uglify())
        .pipe(stripDebug())
		.pipe(rev())
        .pipe(gulp.dest('/var/www/decidz/websites/preprod/www/js'))
		.pipe(rev.manifest())
        .pipe(gulp.dest('/var/www/decidz/websites/preprod/temp/jsb2')); // write manifest to build dir 
});

gulp.task('updateindexhtml', function() {
  var opts = {
	empty: false,
	comments: false,
	spare: false,
	quotes: true
  };
  return gulp.src('/var/www/decidz/websites/preprod/www/index.html')
    .pipe(htmlreplace({
        'jsb1': 'js/js1.js',
        'jsb2': 'js/js2.js'
    }))
	.pipe(minifyHTML(opts))
    .pipe(gulp.dest('/var/www/decidz/websites/preprod/www/'));
});

gulp.task('minfiyhtmltemplates', function() {
  var opts = {
	empty: false,
	comments: false,
	spare: false,
	quotes: true
  };
  return gulp.src('/var/www/decidz/websites/preprod/www/templates/**/*.html')
	.pipe(minifyHTML(opts))
    .pipe(gulp.dest('/var/www/decidz/websites/preprod/www/templates/'));
});


gulp.task('combinehtmltemplates', ['minfiyhtmltemplates'], function() {
    return gulp.src('/var/www/decidz/websites/preprod/www/templates/**/*.html')
		.pipe(templateCache('templates.js', { module:'templates', standalone:true, root: './templates/' }))
        .pipe(gulp.dest('/var/www/decidz/websites/preprod/www/js'));
});

gulp.task('combinetranslation', function() {
//    gulp.src('/var/www/decidz/websites/preprod/www/js/trans/locale-*.json')
//        .pipe(angularTranslate())
//        .pipe(gulp.dest('/var/www/decidz/websites/preprod/www/js'));
});

gulp.task('hashcssfile', function() {
  return gulp.src('/var/www/decidz/websites/preprod/www/css/noodle-bootstrap.css')
		.pipe(rev())
        .pipe(gulp.dest('/var/www/decidz/websites/preprod/www/css'))
		.pipe(rev.manifest())
        .pipe(gulp.dest('/var/www/decidz/websites/preprod/temp/css')); // write manifest to build dir 
});

// Default Task
gulp.task('default', ['jsb1tasks', 'jsb2tasks', 'updateindexhtml', 'combinetranslation', 'hashcssfile']);

