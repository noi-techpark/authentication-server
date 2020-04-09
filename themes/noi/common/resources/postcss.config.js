const tailwindcss = require('tailwindcss')
const purgecss = require('@fullhuman/postcss-purgecss')
const cssnano = require('cssnano')
const autoprefixer = require('autoprefixer')

const purgeConfig = {
    content: [
        '../../**/*.html',
        '../../**/*.ftl',
    ],
    defaultExtractor: content => content.match(/[\w-/:]+(?<!:)/g) || []
}

module.exports = () => {
  return {
    plugins: [
      tailwindcss('./tailwind.config.js'),
      purgecss(purgeConfig),
      autoprefixer,
      cssnano({ preset: 'default' }),
    ]
  }
}
