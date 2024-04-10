module.exports = {
  theme: {
    extend: {
      colors: {
        primary: '#0ad1c4',
        secondary: '#0EA99F',
        third: '#156963',
        error: '#CE6870',
        ambar: '#FBB92F',
        success: '#8FC477',
        dark: '#060D14',
        light: '#D5FFFC',
        shadowy: {
          100: '#D0E1E7',
          200: '#93B2C0',
          300: '#658798',
          700: '#12222A',
        }
      },
      boxShadow: {
        'white': '0 0 8px rgb(255 255 255 / 0.5)',
      },
      gridTemplateColumns: {
        'fill': 'repeat(auto-fill, minmax(200px, 1fr))',
      },
      maxWidth: {
        'custom': '200px',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
  ],
  content: [
    './app/views/**/*.html.haml',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './app/components/**/*.html.haml',
    './app/components/**/*.rb',
  ]
}