const path = require("path");
const glob = require("glob");

module.exports = {
  css: {
    loaderOptions: {
      sass: {
        sassOptions: {
          includePaths: glob.sync('node_modules').map((d) => path.join(__dirname, d))
        }
      }
    }
  }
};
