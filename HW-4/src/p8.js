var results = db.links.find({
	'comments': {$exists: true}
})

var users = {};

function author_comment(comment, index, comments){
	if (users[comment.user]) {
		users[comment.user] += 1;
	} else {
		users[comment.user] = 1;
	}
	if ('replies' in comment) {
		comment.replies.every(author_comment);
	}
}


while (results.hasNext()) {
	result = results.next();
	comments = result.comments;
	comments.every(author_comment);
}

printjson(users);
for (var user in users) {
	if (users[user] > 1) {
		print(users[user]);
	}
}
