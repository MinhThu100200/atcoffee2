
// const webpack = require('webpack');

module.exports = {
  devServer: {
    proxy: process.env.HOSTNAME
  },
  // configureWebpack: {
  //   plugins: [
  //     new webpack.DefinePlugin({
  //       'process.env': {
  //         'PORT': JSON.stringify(process.env.PORT)
  //       }
  //     })
  //   ]
  // }
}
