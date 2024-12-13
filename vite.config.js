import { defineConfig } from "vite";

// Vite config for Tailwind CSS
export default defineConfig({
  css: {
    postcss: "./postcss.config.js", // Optional, ensure PostCSS config is used
    extract: true, // This ensures that the CSS is extracted in production builds
  },
  build: {
    cssCodeSplit: true, // This allows splitting the CSS file when needed
  },
});
