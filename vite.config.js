// vite.config.js
import { defineConfig } from "vite";
import { viteStaticCopy } from "vite-plugin-static-copy";

export default defineConfig({
  base: "/meme-search/",
  build: {
    outDir: "dist",
  },
  plugins: [
    viteStaticCopy({
      targets: [
        {
          src: "src/*",
          dest: "src",
        },
      ],
    }),
  ],
});
