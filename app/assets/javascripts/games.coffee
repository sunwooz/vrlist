$ ->

  $('.checkbox-wrapper').click ->
    if $(this).find('input').prop('checked')
      $(this).find('input').prop('checked', false).change()
      $(this).removeClass('checked')
    else
      $(this).find('input').prop('checked', true).change()
      $(this).addClass('checked')
      
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
      url: '/gearvr'
      data:
        genres: genres
        categories: categories
    })

  #separate tags with commas in form
  if $('body').attr('class') && $('body').attr('class').match("games-edit")
    gameGenreList = $('#game_genre_list')
    gameGenreListWithSpaces = gameGenreList.val()
    console.log gameGenreListWithSpaces
    replaced = gameGenreListWithSpaces.replace(/\s/g, ', ')
    gameGenreList.val(replaced)

  gallery = $('#slick').slick({
    dots: true
    adaptiveHeight: true
  })
