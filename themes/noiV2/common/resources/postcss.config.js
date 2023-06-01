// SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>
//
// SPDX-License-Identifier: CC0-1.0

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
