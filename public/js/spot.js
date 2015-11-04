$(document).ready(function(){
  //alert('here i am');
  $('.search_spotify').keyup(function(){
     console.log("boo");
  });



  $('.search_spotify').on('keyup', function(){
   console.log('hello');

    var form_val=$(this).val();
    console.log(form_val);
    $.ajax({
      url: "https://api.spotify.com/v1/search?q=" + form_val + "&type=track",
      type: 'GET',
      contentType: 'application/json',
      dataType: 'json'
      }).done(function(r){
        console.log(r);
        var str="";
        $.each(r.tracks.items, function(idx, row){
          str+="<div class='result-row' data-spotify-id='" + row.id +  "'>";
          str+="<div>" + row.artists[0].name + "</div><div>" + row.name + "</div>";
          str+="</div>";
        });
        console.log(str);
        $('.search_results').html(str);
    });

  });
  $('body').on('click','.result-row', function(){
    var spotify_id=$(this).attr('data-spotify-id');
    //alert('here i am' + spotify_id); 
    var str='<div><div class="upvote" data-spotify-id="' + spotify_id + '">upvote</div><iframe src="https://embed.spotify.com/?uri=spotify:track:' + spotify_id + '" width="300" height="80" frameborder="0" allowtransparency="true"></iframe>';
    //var str="<div>" + spotify_id + "</div>";
    $('.list-sidebar').prepend(str);
  });


  $('body').on('click','.upvote', function(){
    var spotify_id_val=$(this).attr('data-spotify-id');
    alert('you clicked ' + spotify_id_val);
  });

});

