/*
** TailwindCSS Configuration File
**
** Docs: https://tailwindcss.com/docs/configuration
** Default: https://github.com/tailwindcss/tailwindcss/blob/master/stubs/defaultConfig.stub.js

*/

const { colors } = require('tailwindcss/defaultTheme')

module.exports = {
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
        '500': '#C1CA01',
      },
      error: {
        '500': '#D20707',
      },
      red: colors.red,
      blue: colors.blue,
      yellow: colors.yellow,
      green: colors.green,
    },
    spacing: {
      '0': '0',
      '1': '0.25rem',
      '2': '0.5rem',
      '3': '1rem',
      '4': '2rem',
      '5': '4rem',
      '6': '6rem',
      'i': '1.5rem'
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
      ],
      serif: [
        'Georgia',
        'Cambria',
        '"Times New Roman"',
        'Times',
        'serif',
      ],
      mono: [
        'Menlo',
        'Monaco',
        'Consolas',
        '"Liberation Mono"',
        '"Courier New"',
        'monospace',
      ],
    },
    minWidth: {
      '0': '0',
      'sm': '10rem',
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
