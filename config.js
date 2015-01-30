module.exports = function(config) {

  // Output directory
  config.dest = 'www';
  config.flask_dest = '../lox-meets-bagel-service/app/static';

  // Inject cordova script into html
  config.cordova = false;
  
  // Images minification
  config.minify_images = true;

  // Development web server

  config.server.host = '0.0.0.0';
  config.server.port = '8000';

  // Backend Proxy Server
  // **Me**
  config.proxy.route = '/api/v1.0';
  config.proxy.url = 'http://localhost:5000/api/v1.0';
  
  // Set to false to disable it:
  // config.server = false;

  // Weinre Remote debug server
  
  config.weinre.httpPort = 8001;
  config.weinre.boundHost = 'localhost';

  // Set to false to disable it:
  config.weinre = false;
    
  // 3rd party components
  // config.vendor.js.push('.bower_components/lib/dist/lib.js');
  // config.vendor.fonts.push('.bower_components/font/dist/*');

};