const { environment } = require('@rails/webpacker')
const customConfig = require('./custom')

environment.config.merge(customConfig)

const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)

module.exports = environment
