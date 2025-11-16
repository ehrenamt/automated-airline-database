import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  // for the Vite development server only.
  server: {
    host: "0.0.0.0", // permit access from external addresses
    port: 5173,
  },
});
