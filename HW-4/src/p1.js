var results = db.links.find(
	{
	'author.twitter': { $exists : true }
}, {
	'url': true,
	'starred': true,
	'title': true
}
);

while (results.hasNext()) {
	printjson(results.next());	
}
