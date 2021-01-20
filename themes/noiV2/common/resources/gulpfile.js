const { src, dest, series, watch } = require('gulp');
const rename = require('gulp-rename');
const postcss = require('gulp-postcss');
const rev = require("gulp-rev");
const revRewrite = require('gulp-rev-rewrite');
const del = require('del');

function devCss() {
    return src('./tailwind.css')
      .pipe(postcss())
      .pipe(rename('style.css'))
      .pipe(dest('css'))
  }

function buildCss() {
  return src('./tailwind.css')
    .pipe(postcss())
    .pipe(rename('style.css'))
    .pipe(rev())
    .pipe(dest('css'))
    .pipe(rev.manifest())
    .pipe(dest('.'))
}

function buildClean() {
    return del([
        'css/style-*.css',
      ]);
}

function buildBust() {
    var manifest = src("./rev-manifest.json");
 
    return src('../../login/template.ftl')
        .pipe(revRewrite({manifest}))
        .pipe(dest('../../login/'));
}

const dev = devCss;
const build = series(buildClean, buildCss, buildBust);

exports.default = series(dev, function () {
    watch(['../../**/*.html', '../../**/*.ftl', '../../login/theme.properties', 'tailwind.css', 'tailwind.config.js'], dev);
});
exports.dev = dev;
exports.build = build;
