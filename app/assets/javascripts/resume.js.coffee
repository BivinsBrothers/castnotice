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

  $("#headshot_image").on "change", ->
    $("#upload-headshot-button").prop('disabled', false)

  $(".show-video-form").on 'click', (e) ->
    e.preventDefault
    $(".new-video-form").slideDown()

  $('#video_video_url').on 'change', ->
    if $(this).val().length
      $("#upload-video-button").prop('disabled', false)

  $(".agent-extra").on 'click', (e) ->
    e.preventDefault
    $(".show-agent-fields").slideDown()

  $('#user_birthday_1i, #user_birthday_2i, #user_birthday_3i').on 'change', (e) ->
    e.preventDefault
    $('.parent-questions').slideDown()