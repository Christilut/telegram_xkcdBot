DEBUG = false

module.exports =

  # Switch command to correct function
  junction: (incoming, botname, botcmds, subJunction) ->

    console.log incoming.from.username + ': ' + incoming.text

    cmd = incoming.text.toLowerCase()

    if cmd.length > 1000 then return # cancel abnormally long cmds

    incoming.botname = '@' + botname

    isGroup = false
    isGroup = true if incoming.chat.title
    incoming.isGroup = isGroup

    if DEBUG then console.log 'raw cmd: ' + cmd
    if DEBUG then console.log 'isGroup: ' + isGroup

    if cmd.indexOf('\n') != -1 then cmd = cmd.split('\n')[0]

    if incoming.reply_to_message
      reply_botname = incoming.reply_to_message.from.username

      if incoming.reply_to_message.text and (botcmds.some (x) -> cmd.indexOf(x) == 0)
        prevMsg = incoming.reply_to_message.text

        cmd = prevMsg.substring(0, prevMsg.indexOf(' ')).toLowerCase() + ' ' + cmd

      if cmd.indexOf('/') == 0 then cmd = cmd.substring(1)

      if reply_botname == botname
        subJunction.junction incoming, cmd
        return

    if DEBUG then console.log 'stage 0: ' + cmd

    if not isGroup
      if (botcmds[1..].some (x) -> cmd.indexOf(x) == 0 or cmd.indexOf('/' + x) == 0) or cmd.match /\/?\d+/
        if cmd.indexOf('/') == 0 then cmd = cmd.substring(1)
        if not (botcmds.some (x) -> cmd.indexOf(x) == 0)
          cmd = botcmds[0] + ' ' + cmd

    if DEBUG then console.log 'stage 1: ' + cmd

    # if cmd contains @botname (case insensitive)
    if cmd.indexOf('@' + botname.toLowerCase()) != -1
      re = new RegExp '@' + botname, 'ig'
      cmd = cmd.replace(re, '').trim() # remove @botname and trim

      if cmd.indexOf('/') == 0 then cmd = cmd.substring(1)

      if not (botcmds.some (x) -> cmd.indexOf(x) == 0) or ((botcmds.every (x) -> cmd.indexOf(x) != 0) and isGroup)
        cmd = botcmds[0] + ' ' + cmd

    if DEBUG then console.log 'stage 2: ' + cmd

    # if basic command called in 1on1 chat but without a bot, add the first botcmds
    if cmd.match /(^\/?help$|^\/?start$|^\/?settings$)/i
      if not isGroup
        if cmd.indexOf('/') == 0 then cmd = cmd.substring(1)
        cmd = '/' + botcmds[0] + ' ' + cmd

    if DEBUG then console.log 'stage 3: ' + cmd

    # if 1on1 chat and cmd is not found in botcmds then prefix the first botcmds
    if not isGroup and (botcmds.every (x) -> cmd.indexOf(x) != 0 and cmd.indexOf('/' + x) != 0) and not cmd.indexOf('/') == 0 then cmd = '/' + botcmds[0] + ' ' + cmd

    # if DEBUG then console.log 'stage 4: ' + cmd

    # if cmd is found in botcmds (without /) then prefix /
    # if (botcmds.some (x) -> cmd.indexOf(x) == 0) then cmd = '/' + cmd

    if DEBUG then console.log 'stage 5: ' + cmd

    # if cmd startswith any / + botcmds
    if (botcmds.some (x) -> cmd.indexOf(x) == 0 or cmd.indexOf('/' + x) == 0)

      if cmd.indexOf('/') == 0 then cmd = cmd.substring 1
      mainCmd = cmd.split(' ')[0]

      subJunction.junction incoming, cmd
