// SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>
//
// SPDX-License-Identifier: CC0-1.0

/*
** TailwindCSS Configuration File
**
** Docs: https://tailwindcss.com/docs/configuration
** Default: https://github.com/tailwindcss/tailwindcss/blob/master/stubs/defaultConfig.stub.js

*/

const { colors } = require('tailwindcss/defaultTheme')

module.exports = {
  purge: {
    content: [
      '../../**/*.html',
      '../../**/*.ftl',
      '../../**/theme.properties',
      '../../../sankt-virtual/login/theme.properties'
    ]
  },
  theme: {
    colors: {
      transparent: 'transparent',
      white: '#FFF',
      black: '#000',
      gray: {
        '100': '#FCFCFC',
        '300': '#F4F4F4',
        '400': '#C8C8C8',
        '500': '#707070'
      },
      primary: {
        '500': '#000000',
        '700': '#000000',
      },
      focus: {
        '500':  '#F4D100',
        '700':  '#F4D100',
      },
      error: {
        '500': '#D20707',
      },
      red: colors.red,
      blue: colors.blue,
      yellow: colors.yellow,
      green: {
        DEFAULT: '#B2C117',
        '50': '#F4F8C5',
        '100': '#EFF5AF',
        '200': '#E6F081',
        '300': '#DDEB53',
        '400': '#D4E526',
        '500': '#B2C117',
        '600': '#889312',
        '700': '#5E660C',
        '800': '#343807',
        '900': '#0A0B01'
      }
    },
    fontFamily: {
      sans: [
        'Source Sans Pro',
        '-apple-system',
        'BlinkMacSystemFont',
        '"Segoe UI"',
        'Roboto',
        '"Helvetica Neue"',
        'Arial',
        '"Noto Sans"',
        'sans-serif',
        '"Apple Color Emoji"',
        '"Segoe UI Emoji"',
        '"Segoe UI Symbol"',
        '"Noto Color Emoji"',
      ]
    },
    minWidth: {
      '0': '0',
      'sm': '10rem',
      'md': '20rem',
      'full': '100%',
    },
    extend: {
      borderWidth: {
        '3': '3px'
      },
      fontSize: {
        '7xl': '5rem',
        '8xl': '6rem'
      }
    }
  },
  variants: {
    backgroundColor: ['responsive', 'hover', 'focus', 'disabled', 'group-hover'],
    borderColor: ['responsive', 'hover', 'focus', 'disabled'],
    textColor: ['responsive', 'hover', 'focus', 'disabled', 'group-hover'],
    display: ['responsive', 'group-hover'],
  },
  plugins: []
}
