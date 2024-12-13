// vite.config.js
import { defineConfig } from "vite";
import { viteStaticCopy } from "vite-plugin-static-copy";

export default defineConfig({
  base: "/meme-search/",
  build: {
    outDir: "dist", // Ensure the build outputs to the "dist" directory
  },
  plugins: [
    viteStaticCopy({
      targets: [
        {
          src: "src/*", // Source path
          dest: "src", // Destination in dist folder
        },
      ],
    }),
  ],
});
