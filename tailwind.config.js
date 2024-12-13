/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: "class",
  content: ["./src/**/*.{html,js}", "./index.html"],
  theme: {
    extend: {
      backgroundColor: {
        light: "#e9e6fa",
      },
      textColor: {
        light: "#e9e6fa",
      },
      fontSize: {
        "2xl": "2.25rem",
        "3xl": "2.75rem",
      },
    },
    plugins: [],
  },
};
