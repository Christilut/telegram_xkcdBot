


module.exports =

	uniqueCaseInsensitive: (value, index, self) ->
	  return self.indexOf(value) == index || self.indexOf(value.toLowerCase()) == index;

	shuffle: (a,b,c,d) ->
		c=a.length
		while(c)
			b = Math.random() * c-- | 0
			d = a[c]
			a[c] = a[b]
			a[b] = d
