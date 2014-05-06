@accountFields =

  toggleParentFields: ->
    year = $('#user_birthday_1i').val()
    month = $('#user_birthday_2i').val()
    day = $('#user_birthday_3i').val()
    bday = new Date(year, month, day)
    today = Date.now()
    age_ms = today - bday
    eighteen_years_ms = 568025136000.0
    if age_ms < eighteen_years_ms
      $('.parent-questions').slideDown()
    else
      $('.parent-questions').slideUp()


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

  accountFields.toggleParentFields()

  $('#user_birthday_1i, #user_birthday_2i, #user_birthday_3i').on 'change', ->
    accountFields.toggleParentFields()
