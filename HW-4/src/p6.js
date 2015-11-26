var results = db.links.find({
}, {
	'ratings': true,
	'starred': true,
	'title': true
});

while (results.hasNext()) {
	result = results.next();
	var scores = 0;
	for (var rate in result.ratings) {
		scores += result.ratings[rate];
	}
	if (result.starred < scores) {
		delete result.ratings;
		delete result.starred;
		printjson(result);
	}
}
