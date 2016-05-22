$ ->
  $('input.checkbox-filter').change () ->
    genres = []
    categories = []

    $('.genres:checked').each (index, genre) ->
      genres.push genre.value

    $('.categories:checked').each (index, category) ->
      categories.push category.value

    # console.log genres
    # console.log categories

    $.ajax({
      method: 'get'
      url: '/games'
      data:
        genres: genres
        categories: categories
    })

  #separate tags with commas in form
  gameGenreList = $('#game_genre_list')
  gameGenreListWithSpaces = gameGenreList.val()
  console.log gameGenreListWithSpaces
  replaced = gameGenreListWithSpaces.replace(/\s/g, ', ')
  gameGenreList.val(replaced)