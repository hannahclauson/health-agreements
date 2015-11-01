ready = () ->
  $("header .menu.button").on "click", (ev) ->
    $(this).toggleClass("glyphicon-plus")
    $(this).toggleClass("glyphicon-minus")
    $(".nav").toggleClass("hidden")

$(document).ready ready
$(document).on 'page:load', ready