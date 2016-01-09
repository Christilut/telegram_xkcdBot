var Bot = require('./lib/Bot');

var bot = new Bot({
  token: '80227099:AAEFs5YAc10zzYKTVCnLyvKOk4f8VhHp-4A'
})
.on('/hey', function (message) {
  console.log('/hey', message);
})
.on('message', function (message) {
  console.log(message);
  // bot.sendMessage({
  //   chat_id: message.from.id,
  //   text: "Who to write ?",
  //   reply_markup: {
  //     keyboard: [ 
  //       ["hello", "world"], 
  //       ["he", "she"] 
  //     ],
  //   }
  // }, function(err, ret) {
  //   if(err) return console.error(err);
  // });
})
.start();

// var fs = require('fs');
// var mime = require('mime');

// console.log(mime.lookup('./examples/logo.png')); 
// bot.sendPhoto({
//   chat_id: 2229032,
//   caption: 'Tester',
//   files: {
//     photo: {
//       filename: 'logo.png',
//       stream: fs.createReadStream('./examples/logo.png')
//     }
//   }
// }, function (err, msg) {
//   console.log(err);
//   console.log(msg);
// });

// bot.sendSticker({
//   chat_id: 2229032,
//   files: {
//     sticker: './examples/logo.webp'
//   }
// }, function (err, msg) {
//   console.log(err);
//   console.log(msg);
// });

// bot.getMe(function (err, msg) {
//   console.log(msg);
// });

// bot.sendMessage({
//   chat_id: -35675870,
//   text: 'hello world'
// }, function (err, res) {
//   console.log(err);
//   console.log(res);
// });

// bot.sendLocation({
//   chat_id: 2229032,
//   latitude: 3.1333,
//   longitude: 101.7000
// }, function (err, res) {
//   console.log(err);
//   console.log(res);
// });