$(document).ready(function() {

	load_comments($('.washer_id').val(), offset)

	$('.load_more_comments').click(function(){
		offset += 2;
		load_comments($('.washer_id').val(), offset)
	});

  $(".my-rating").starRating({
      initialRating: 0,
      disableAfterRate: false,
      starSize: 20,
      useFullStars: true,
      hoverColor: '#ee6c4d',
      activeColor: '#ee6c4d',
      ratedColor: '#ee6c4d',
      onHover: function(currentIndex, currentRating, $el){
        $('.live-rating').text(currentIndex);
      },
      onLeave: function(currentIndex, currentRating, $el){
        $('.live-rating').text(currentRating);
      }
  }); 

  $(".total-rating").starRating({
      initialRating: 4,
      starSize: 20,
      readOnly: true,
      ratedColor: '#ee6c4d',
      activeColor: '#ee6c4d',
      hoverColor: '#ee6c4d'
  });   

	$('.submit_comments').click(function(){
		var rating = $('.my-rating').starRating('getRating');
		var name =  $('.reviewer_name').val();
		var email =  $('.reviewer_email').val();
		var comment =  $('.reviewer_comment').val();
		var title = $('.review_title').val();
		if(comment_validation(rating, name, email, comment, title)){
			var washer_id = $('.washer_id').val();
			var authenticity_token = $('.authenticity_token').val();
			var formData = new FormData();

			formData.append('rating', rating);
			formData.append('name', name);
			formData.append('email', email);
			formData.append('comment', comment);
			formData.append('washer_id', washer_id);
			formData.append('title', title);

			var files = $('.images')[0].files;
			for(var i = 0; i < files.length; i++) {
	    	formData.append('images[]', files[i]);
			}

		  $.ajax({
		  	url: "/post_comments", 
		  	type: 'post',
		  	data: formData,
		  	processData: false,
		  	contentType: false,
		  	beforeSend: function (xhr) {
	        xhr.setRequestHeader('X-CSRF-Token', authenticity_token)
	    	},
	    	success: function(result){
	    		alert(result.message);
	    		window.location.reload()
	    	}	
			});
		}
		else{
			alert("Fill all fields. Image is optional");
		}

	});
});

var offset = 0

function load_comments(washer_id, offset){
	var authenticity_token = $('.authenticity_token').val();
  $.ajax({
  	url: "/fetch_comments", 
  	type: 'post',
  	data: {
  		"washer_id": washer_id,
  		"offset": offset
  	},
  	beforeSend: function (xhr) {
      xhr.setRequestHeader('X-CSRF-Token', authenticity_token)
  	},
  	success: function(result){
  		form_comment(result)
  	}	
	});
}

function form_comment(data){
	data = data.results
	var content = ""
	if(data.length > 0){
		for(var i=0; i< data.length; i++){
			content += form_comment_html(data[i]['name'], data[i]['email'], data[i]['rating'], data[i]['comment'], data[i]['title'], data[i]['images'])
		}
	}
	else{
		$('.load_more_comments').hide();
	}
	$('.comments_section').append(content)
}

function form_comment_html(name, email, rating, comment, title, images){
	image_html = form_image_html(images)
	html = '<div class="col-md-12 py-5"> <div class="row"> <div class="col-3 col-md-2 col-sm-2"> <img src="/assets/anime.jpg" alt="profile images" class=" rounded-circle human-circle" class="img-fluid"> </div> <div class="col-9 col-md-6 col-sm-6"> <p class="comment-title">'+title+'</p> <p class="small-text author-comment">by <span class="text-orange">'+name+'</span></p> </div> <div class="col-12 col-md-4 col-sm-4 "> <p class="text-right text-left">'+stars_html[rating]+'<span class="rating-number small-text">'+rating+'</span></p> <p class="text-right text-left small-text comment-very-good">'+rating_opinion(rating)+'</p> </div> </div> <div class="row"> <div class="col-md-9 offset-md-2"> <p class="small-text review-message">'+comment+'</p> </div> </div>'+image_html+'</div>'
	return html;
}

function rating_opinion(rating){
	if(rating > 0 && rating <= 1){
		return 'I hated it'
	}
	else if(rating > 1 && rating <= 2){
		return 'I didn\'t like it'
	}
	else if(rating > 2 && rating <= 3){
		return 'It was ok'
	}
	else if(rating > 3 && rating <= 4){
		return 'I liked it'
	}
	else{
		return 'I loved it'
	}		
}

var stars_html = ['',form_stars(1),form_stars(2),form_stars(3),form_stars(4),form_stars(5)]

function form_stars(rating){
	var rating_data = ""
	for(var i=0;i< rating; i++){
		rating_data += '<i class="fas fa-star"></i>'
	}
	for(var i=0;i< 5-rating; i++){
		rating_data += '<i class="far fa-star"></i>'
	}
	return rating_data;
}

function form_image_html(images){
	console.log("enter")
	var html = '<div class="row"><div class="col-md-10 offset-md-2">';
	for(var i=0;i< images.length; i++){
		html += '<img src="'+images[i]+'" alt="Image" class="img-thumbnail img-fluid col-md-3" />'
	}
	html += '</div></div>'
	return html
}

function comment_validation(rating, name, email, comment, title){
	valid = true
	if(rating == 0){
		valid = false
	}
	if(name == "" || email == "" || comment == "" || title == ""){
		valid = false
	}
	return valid
}