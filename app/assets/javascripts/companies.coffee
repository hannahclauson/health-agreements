# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".toggle-options").on 'click', (ev) -> 
    $(this).toggleClass("glyphicon-plus").toggleClass("glyphicon-minus")
    $(".advanced-search").toggleClass("collapse-options")
  $(".submit-search").on 'click', (ev) ->
    console.log("clicked submit")
    $("form.search input[type='submit']").click()

  $(".sort_controls > span").on 'click', (ev) ->
    if $(this).hasClass("inactive")
      return

    action = $(this).attr("class")
    window.location = window.location + "&impact_factor_sort=" + action
