$ ->
  $(".show-project-form").on 'click', (e) ->
    e.preventDefault
    $(".new-project-form").slideDown()

  $(".show-school-form").on 'click', (e) ->
    e.preventDefault
    $(".new-school-form").slideDown()

  $(".show-headshot-form").on 'click', (e) ->
    e.preventDefault
    $(".new-headshot-form").slideDown()

  $(".show-video-form").on 'click', (e) ->
    e.preventDefault
    $(".new-video-form").slideDown()
