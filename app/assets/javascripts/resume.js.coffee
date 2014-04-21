$ ->
  $(".show-project-form").on 'click', (e) ->
    e.preventDefault
    $(".new-project-form").slideDown()
    $("html, body").animate({ scrollTop: $(document).height() }, "slow");
