var results = db.links.find({
	'comments': {$exists: true}
})

function negative_comment(comment, index, comments){
	if (comment.upVotes == 0 && comment.downVotes >= 3) {
		printjson(comment);
	} else if (comment.upVotes <= 20 && (comment.downVotes / comment.upVotes) > 4) {
		printjson(comment);
	} else if (comment.upVotes > 20 && (comment.downVotes / comment.upVotes) > 6) {
		printjson(comment);
	}
	if ('replies' in comment) {
		comment.replies.every(negative_comment);
	}
}


while (results.hasNext()) {
	result = results.next();
	comments = result.comments;
	comments.every(negative_comment);
}
