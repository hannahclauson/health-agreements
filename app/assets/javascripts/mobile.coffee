$ ->

  $("header .menu.button").on "click", (ev) ->
    $(this).toggleClass("glyphicon-plus")
    $(this).toggleClass("glyphicon-minus")
    $(".nav").toggleClass("hidden")