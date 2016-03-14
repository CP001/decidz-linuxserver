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
var deploymentfolder = 'TBC_DEPLOYMENTFOLDER'; 
var imagemin = require('gulp-imagemin');
var pngquant = require('imagemin-pngquant');

gulp.task('minifyimages', function () {
    return gulp.src(deploymentfolder + 'www/img/**/*')
        .pipe(imagemin({
            progressive: true,
            svgoPlugins: [{removeViewBox: false}],
            use: [pngquant()]
        }))
        .pipe(gulp.dest(deploymentfolder + 'www/img'));
});


// Concatenate & Minify JS
gulp.task('jsb1tasks', ['combinehtmltemplates'], function() {
    return gulp.src([deploymentfolder + 'www/app/app.js',
                     deploymentfolder + 'www/app/config.js',
                     deploymentfolder + 'www/app/controllers.js',
                     deploymentfolder + 'www/app/modules/*.js',
                     deploymentfolder + 'www/app/js/modules/rcMailgun.js',
                     deploymentfolder + 'www/app/factories/*.js',
                     deploymentfolder + 'www/app/js/templates.js'])
        .pipe(ngAnnotate())
        .pipe(concat('all1.js'))
        .pipe(gulp.dest(deploymentfolder + 'temp/jsb1'))
        .pipe(rename('js1.js'))
        .pipe(uglify())
        .pipe(stripDebug())
		.pipe(rev())
        .pipe(gulp.dest(deploymentfolder + 'www/app/js'))
		.pipe(rev.manifest())
        .pipe(gulp.dest(deploymentfolder + 'temp/jsb1')); // write manifest to build dir 
});

gulp.task('jsb2tasks', function() {
    return gulp.src([deploymentfolder + 'www/app/bower_components/angular-translate/angular-translate.js',
                     deploymentfolder + 'www/app/bower_components/angular-translate/angular-translate-loader-static-files.js',
                     deploymentfolder + 'www/app/bower_components/angular-bootstrap-datetimepicker/src/js/datetimepicker.js',
                     deploymentfolder + 'www/app/bower_components/angular-cookie/angular-cookie.min.js',
                     deploymentfolder + 'www/app/bower_components/zeroclipboard/dist/ZeroClipboard.js',
                     deploymentfolder + 'www/app/bower_components/ng-fi-text/dist/ng-fi-text.min.js',
                     deploymentfolder + 'www/app/bower_components/angular-scroll-glue/src/scrollglue.js',
                     deploymentfolder + 'www/app/bower_components/angulartics/dist/angulartics.min.js',
                     deploymentfolder + 'www/app/bower_components/angular-filter/dist/angular-filter.js',
                     deploymentfolder + 'www/app/bower_components/angulartics/dist/angulartics-ga.min.js',
                     deploymentfolder + 'www/app/bower_components/angulartics/dist/angulartics-segmentio.min.js',
					 deploymentfolder + 'www/app/bower_components/angular-notification/angular-notification.js',
                     deploymentfolder + 'www/app/bower_components/angular-md5/angular-md5.min.js',
					 deploymentfolder + 'www/app/js/mobiscroll.custom-2.15.1.min.js',
					 deploymentfolder + 'www/app/js/moment-timezone-with-data-2010-2020.js',
					 deploymentfolder + 'www/app/js/typed.min.js',
					 deploymentfolder + 'www/app/js/lib/mailgun_validator.js',
					 deploymentfolder + 'www/app/js/angular-toastr.tpls.js' ])
        .pipe(ngAnnotate())
        .pipe(concat('all2.js'))
        .pipe(gulp.dest(deploymentfolder + 'temp/jsb2'))
        .pipe(rename('js2.js'))
        .pipe(uglify())
        .pipe(stripDebug())
		.pipe(rev())
        .pipe(gulp.dest(deploymentfolder + 'www/app/js'))
		.pipe(rev.manifest())
        .pipe(gulp.dest(deploymentfolder + 'temp/jsb2')); // write manifest to build dir 
});

gulp.task('jsb3tasks', function() {
    return gulp.src([deploymentfolder + 'www/js/staticpages/*.js'])
        .pipe(ngAnnotate())
        .pipe(concat('all3.js'))
        .pipe(gulp.dest(deploymentfolder + 'temp/jsb3'))
        .pipe(rename('js3.js'))
        .pipe(uglify())
        .pipe(stripDebug())
		.pipe(rev())
        .pipe(gulp.dest(deploymentfolder + 'www/js'))
		.pipe(rev.manifest())
        .pipe(gulp.dest(deploymentfolder + 'temp/jsb3')); // write manifest to build dir 
});

gulp.task('combinecss', function() {
    return gulp.src([deploymentfolder + 'www/app/css/noodle-bootstrap.css',
                     deploymentfolder + 'www/app/css/mobiscroll/mobiscroll.custom-2.15.1.min.css'])
        .pipe(concat('decidz.css'))
        .pipe(gulp.dest(deploymentfolder + 'www/app/css'));
});

gulp.task('combineaboutcss', function() {
    return gulp.src([deploymentfolder + 'www/css/bootstrap.css',
					 deploymentfolder + 'www/css/animate.css',
					 deploymentfolder + 'www/css/swiper.css',
					 deploymentfolder + 'www/css/owl.carousel.css',
					 deploymentfolder + 'www/css/owl.theme.css',
					 deploymentfolder + '/wwwcss/magnific-popup.css',
					 deploymentfolder + 'www/css/styles/style-green.css',
                     deploymentfolder + 'www/css/font-awesome.min.css'])
        .pipe(concat('css1a.css'))
        .pipe(rename('css1.css'))		
		.pipe(rev())
        .pipe(gulp.dest(deploymentfolder + 'www/css'))
		.pipe(rev.manifest())
        .pipe(gulp.dest(deploymentfolder + 'temp/css1')); // write manifest to build dir 
});

gulp.task('updateindexhtml', function() {
  var opts = {
	empty: false,
	comments: false,
	spare: false,
	quotes: true
  };
  return gulp.src(deploymentfolder + 'www/app/index.html')
    .pipe(htmlreplace({
        'jsb1': 'js/js1.js',
        'jsb2': 'js/js2.js'
    }))
	.pipe(minifyHTML(opts))
    .pipe(gulp.dest(deploymentfolder + 'www/app'));
});

gulp.task('updateabouthtml', function() {
  var opts = {
	empty: false,
	comments: false,
	spare: false,
	quotes: true
  };
  return gulp.src(deploymentfolder + 'www/index.html')
    .pipe(htmlreplace({
        'jsb3': 'js/js3.js',
        'css1': 'css/css1.css'
    }))
	.pipe(minifyHTML(opts))
    .pipe(gulp.dest(deploymentfolder + 'www/'));
});

gulp.task('minfiyhtmltemplates', function() {
  var opts = {
	empty: false,
	comments: false,
	spare: false,
	quotes: true
  };
  return gulp.src(deploymentfolder + 'www/app/templates/**/*.html')
	.pipe(minifyHTML(opts))
    .pipe(gulp.dest(deploymentfolder + 'www/app/templates/'));
});


gulp.task('combinehtmltemplates', ['minfiyhtmltemplates'], function() {
    return gulp.src(deploymentfolder + 'www/app/templates/**/*.html')
		.pipe(templateCache('templates.js', { module:'templates', standalone:true, root: './templates/' }))
        .pipe(gulp.dest(deploymentfolder + 'www/app/js'));
});

gulp.task('combinetranslation', function() {
//    gulp.src(deploymentfolder + 'www/js/trans/locale-*.json')
//        .pipe(angularTranslate())
//        .pipe(gulp.dest(deploymentfolder + 'www/js'));
});

gulp.task('hashcssfile', function() {
  return gulp.src(deploymentfolder + 'www/app/css/noodle-bootstrap.css')
		.pipe(rev())
        .pipe(gulp.dest(deploymentfolder + 'www/app/css'))
		.pipe(rev.manifest())
        .pipe(gulp.dest(deploymentfolder + 'temp/css')); // write manifest to build dir 
});

// Default Task
gulp.task('default', ['jsb1tasks', 'jsb2tasks', 'jsb3tasks', 'combinecss', 'combineaboutcss', 'updateindexhtml', 'updateabouthtml', 'combinetranslation', 'hashcssfile']);
// gulp.task('default', ['jsb1tasks', 'jsb2tasks', 'jsb3tasks', 'combinecss', 'combineaboutcss', 'updateindexhtml', 'updateabouthtml', 'combinetranslation', 'minifyimages', 'hashcssfile']);
// gulp.task('default', ['jsb1tasks', 'jsb2tasks', 'jsb3tasks', 'combinecss', 'combineaboutcss', 'updateindexhtml', 'updateabouthtml', 'combinetranslation', 'minifyimages', 'hashcssfile']);

