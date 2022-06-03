
// const webpack = require('webpack');

module.exports = {

  configureWebpack: {        
    devServer: {
     // proxy: process.env.HOSTNAME,},
      proxy: { '/v1': { 
                target: 'http://localhost:8086',
                pathRewrite: { '^/v1': '' }, 
              }, 
              
              '/v2': {
                target: 'https://fcm.googleapis.com', 
                pathRewrite: { '^/v2': '' }, 
              },
      }
    }
      
  }
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
