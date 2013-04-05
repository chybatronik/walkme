var connect = require('connect'),
    http = require('http');

connect()
    .use(connect.static('/home/ch/ruby/walkme/extension'))
    .listen(4000);