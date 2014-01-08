jQuery ->
  $('#micropost_content').keyup -> (
    count = 140 - $('#micropost_content').val().length
    $('#counter').text(count)
  )
