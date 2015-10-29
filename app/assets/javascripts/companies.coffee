# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".toggle-options").on 'click', (ev) -> 
    $(this).toggleClass("glyphicon-plus").toggleClass("glyphicon-minus")
    $(".advanced-search").toggleClass("collapse-options")
  $(".submit-search").on 'click', (ev) ->
    $("form.search input[type='submit']").click()

  $(".sort_controls > span").on 'click', (ev) ->
    if $(this).hasClass("inactive")
      return
    name = $(this).parent().attr("name")
    action = $(this).attr("class")
    p = {}
    p[name] =  action
    window.location.search = jQuery.param(p)
