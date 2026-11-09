import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // تصدير ثابت (مجلد out) ليُنشر مباشرة على Netlify
  output: "export",
  images: { unoptimized: true },
  turbopack: {
    rules: {
      "*.css": {
        loaders: ["@tailwindcss/turbopack"],
        as: "*.css",
      },
    },
  },
};

export default nextConfig;
