const tailwindcss = require('tailwindcss')
const autoprefixer = require('autoprefixer')

module.exports = () => {
  return {
    plugins: [
      tailwindcss('./tailwind.config.js'),
      autoprefixer
    ]
  }
}
