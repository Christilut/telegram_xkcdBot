db = null
Stats = null

module.exports =

  initDb: (database, names...) ->

    db = database
    Stats = db.model('Statistics', { stat: String, count: { type: Number, default: 0 } });

    for n in names
      do (n) ->
        Stats.find { stat: n}, (err, result) ->
          if err then throw err

          if result.length == 0
            s = new Stats {
              stat: n
            }

            s.save (err) ->
              if err then throw err

  addOne: (stat) ->
    Stats.findOneAndUpdate { stat: stat }, { $inc: { count: 1 } }, (err) ->
      if err then throw err

  add: (stat, amount) ->
    Stats.findOneAndUpdate { stat: stat }, { $inc: { count: amount } }, (err) ->
      if err then throw err
