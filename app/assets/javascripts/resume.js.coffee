@accountFields =

  toggleParentFields: ->
    year = $('#user_birthday_1i').val()
    month = $('#user_birthday_2i').val()
    day = $('#user_birthday_3i').val()
    yearsDiff = moment().diff(new Date("#{year}-#{month}-#{day}"), "years")
    if yearsDiff < 18
      $('.parent-questions').slideDown()
    else
      $('.parent-questions').slideUp()

$ ->
  $(".show-project-form").on 'click', (e) ->
    $(".new-project-form").slideDown()

  $(".show-school-form").on 'click', (e) ->
    $(".new-school-form").slideDown()

  $(".show-headshot-form").on 'click', (e) ->
    $(".new-headshot-form").slideDown()
    $("#upload-headshot-button").prop('disabled', true)

  $("#headshot_image").on 'change', (e) ->
    $("#upload-headshot-button").prop('disabled', false)

  $(".new_headshot").submit ->
    $("#upload-headshot-button").prop('disabled', true)

  $(".show-video-form").on 'click', (e) ->
    $(".new-video-form").slideDown()

  $(".agent-extra").on 'click', (e) ->
    $(".show-agent-fields").slideDown()

  accountFields.toggleParentFields()

  $('#user_birthday_1i, #user_birthday_2i, #user_birthday_3i').on 'change', ->
    accountFields.toggleParentFields()