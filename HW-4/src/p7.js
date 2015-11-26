var results = db.links.find({
	'comments': {$exists: true}
})

function negative_comment(comment, index, comments){
		if (min != null && min.upVotes - min.downVotes > comment.upVotes - comment.downVotes) {
			min = comment;
		} else if (min == null) {
			min = comment;
		} else if (max != null && max.upVotes - max.downVotes < comment.upVotes - comment.downVotes) {
			max = comment;
		} else if (max == null) {
			max = comment;
		}
		if ('replies' in comment) {
			comment.replies.every(best_worst_comment);
		}
}


while (results.hasNext()) {
	result = results.next();
	comments = result.comments;
	comments.every(negative_comment);
}
