const { ModuleFederationPlugin } = require('webpack').container;

module.exports = {
  output: { uniqueName: "[nome-generico]", publicPath: "auto" },
  optimization: { runtimeChunk: false },
  plugins: [
    new ModuleFederationPlugin({
      name: "[nome-generico]",
      filename: "remoteEntry.js",
      exposes: {
        './App': './src/app/app.ts'
      },
      shared: ["@angular/core", "@angular/common", "@angular/router"]
    })
  ],
};

