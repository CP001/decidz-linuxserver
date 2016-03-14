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
// var image = require('gulp-image');

//var imageminJpegtran = require('imagemin-jpegtran');
//var imageminOptipng = require('imagemin-optipng');
//var imageminSvgo = require('imagemin-svgo');


gulp.task('minifyallimages', function () {
    return gulp.src(deploymentfolder + 'www/**/*')
        .pipe(imagemin({
            progressive: true,
            svgoPlugins: [{removeViewBox: false}],
            use: [pngquant()]
//			use: [imageminJpegtran({progressive: true})],
//			use: [imageminOptipng({optimizationLevel: 3})],
//			use: [imageminSvgo()]
        }))
        .pipe(gulp.dest(deploymentfolder + 'temp/minified/www'));	
});

 
// gulp.task('imagemin', function () {
//   gulp.src(deploymentfolder + 'www/**/*')
//     .pipe(image())
//     .pipe(gulp.dest(deploymentfolder + 'temp/minified/www'));
// });

gulp.task('default', ['minifyallimages']);
// gulp.task('default', ['imagemin']);

