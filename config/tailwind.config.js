const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  mode:'jit',
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        'ndot': ['Ndot', 'sans-serif'],
        sans: ['Fira Code', 'monospace'],
        brand: ['Nothing', 'sans-serif'],
        material: ['"Material Symbols Outlined"', 'sans-serif'],
        
      },
    },
  },
  plugins: [
    // require('@tailwindcss/forms'),
    // require('@tailwindcss/typography'),
    // require('@tailwindcss/container-queries'),
  ]
}
