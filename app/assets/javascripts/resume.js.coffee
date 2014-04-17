$ ->
  $(".show-project-form").on 'click', (e) ->
    e.preventDefault
    $(".new-project-form").slideDown()

  $(".project-save").on 'click', ->
#    $.ajax({
#
#      }
    $(".new-project-form").slideUp()

