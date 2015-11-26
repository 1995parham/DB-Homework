var results = db.links.find({
	'author.email': {$not : /(@gmail\.com)$/}
}, {
	'title': true,
	'url': true,
	'ratings': true
}
)

while (results.hasNext()) {
	result = results.next();
	var sum = 0;
	for (var rate in result.ratings) {
		sum += result.ratings[rate];
	}
	result.scores = (sum / result.ratings.length);
	delete result.ratings;
	printjson(result);	
}
