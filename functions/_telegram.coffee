module.exports =

  textMessage: (incoming, msg) ->
    # msg = randomlyAddRateAd incoming, msg

    console.log 'sending: ' + msg.substring(0, Math.min(20, msg.length)) + '...'
    incoming.bot.sendMessage
      chat_id: incoming.chat.id
      text: msg
      reply_markup: { hide_keyboard: true, selective: true }
      disable_web_page_preview: true
      (e) ->
        if e?
          if e.code == 'ECONNRESET'
            console.log 'bot send error: ' + JSON.stringify e
          else if e.error_code == 403 then console.log 'bot send error: ' + JSON.stringify e
          else if e.error_code == 400 then console.log 'bot send error: ' + JSON.stringify e
          else throw 'unhandled bot send error: ' + JSON.stringify e

  textMessageWithPreview: (incoming, msg) ->
    # msg = randomlyAddRateAd incoming, msg

    console.log 'sending: ' + msg.substring(0, Math.min(20, msg.length)) + '...'
    incoming.bot.sendMessage
      chat_id: incoming.chat.id
      text: msg
      reply_markup: { hide_keyboard: true, selective: true }
      (e) ->
        if e?
          if e.code == 'ECONNRESET'
            console.log 'bot send error: ' + JSON.stringify e
          else if e.error_code == 403 then console.log 'bot send error: ' + JSON.stringify e
          else if e.error_code == 400 then console.log 'bot send error: ' + JSON.stringify e
          else throw 'unhandled bot send error: ' + JSON.stringify e

  textMessageWithMarkup: (incoming, msg, markup, reply_to_message_id) ->
    # if not markup.hide_bot_store_ad
      # msg = randomlyAddRateAd incoming, msg

    console.log 'sending: ' + msg.substring(0, Math.min(20, msg.length)) + '...'
    incoming.bot.sendMessage
      chat_id: incoming.chat.id
      text: msg
      reply_markup: markup
      reply_to_message_id: reply_to_message_id
      (e) ->
        if e?
          if e.code == 'ECONNRESET'
            console.log 'bot send error: ' + JSON.stringify e
          else if e.error_code == 403 then console.log 'bot send error: ' + JSON.stringify e
          else if e.error_code == 400 then console.log 'bot send error: ' + JSON.stringify e
          else throw 'unhandled bot send error: ' + JSON.stringify e


  sendDocument: (incoming, files, markup, callback) ->
    console.log 'sending document'
    incoming.bot.sendDocument
      chat_id: incoming.chat.id
      reply_markup: markup
      # file_id: files.document_id
      files: {
        document: files.document
      }
      (json) ->
        callback json

  sendDocumentAgain: (incoming, files, markup, callback) ->
    console.log 'sending document'
    incoming.bot.sendDocumentAgain
      chat_id: incoming.chat.id
      reply_markup: markup
      document_id: files.document_id
      # files: {
      #   document: files.document
      # }
      (json) ->
        callback json
