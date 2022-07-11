function doLike(pid, uid) {
   

	const d = {
		uid: uid,
		pid: pid,
		operation: 'like'
	}

	$.ajax({
		url: "LikeServlet",
		data: {uid: uid,
		pid: pid,
		operation: 'like' },
		success: function(data, textStatus, jqXHR) {
			console.log(data)
			if(data.trim() == 'true'){
			let c= $(".like-counter").html();
			c++;
			$('.like-counter').html(c);
			
			}
		},
		error: function(jqXHR, textStatus, errorThrownS) {
			console.log(data)
		}
	})

}