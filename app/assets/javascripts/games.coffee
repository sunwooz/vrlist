$ ->
  $('input.genres').change () ->
    genres = []

    $('.genres:checked').each (index, genre) ->
      genres.push genre.value

    console.log genres

    $.ajax({
      method: 'get'
      url: '/games'
      data:
        genres: genres
    })

  #separate tags with commas in form
  gameGenreList = $('#game_genre_list')
  gameGenreListWithSpaces = gameGenreList.val()
  console.log gameGenreListWithSpaces
  replaced = gameGenreListWithSpaces.replace(/\s/g, ', ')
  gameGenreList.val(replaced)