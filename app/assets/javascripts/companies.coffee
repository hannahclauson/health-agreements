# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = () ->
  $(".toggle-options").on 'click', (ev) -> 
    $(this).toggleClass("glyphicon-plus").toggleClass("glyphicon-minus")
    $(".advanced-search").toggleClass("collapse-options")
  $(".submit-search").on 'click', (ev) ->
    $("form.search input[type='submit']").click()

  # on #index : UI Handlers for Sorting by Impact Factor / Name

  $(".sort_controls > span").on 'click', (ev) ->
    if $(this).hasClass("inactive")
      return
    name = $(this).parent().attr("name")
    action = $(this).attr("class")
    p = {}
    p[name] =  action
    window.location.search = jQuery.param(p)

  # on #show : UI Handlers for finding another company to compare

  $("button.compare_view").on "click", (ev) ->
    $(".compare_helper").toggleClass("hidden")

  navigate_to_compare_page = () ->
    a = $("#this_company")[0].value
    b = $("#company_name")[0].value
    q = {"a" : a, "b" : b}
    window.location = "/companies/compare?" + jQuery.param(q)

  $("button.compare").on "click", (ev) ->
    navigate_to_compare_page("acme")

  $("form.compare").on "submit", (ev) ->
    navigate_to_compare_page()
    ev.preventDefault()
    ev.stopPropagation()
    false

$(document).ready ready
$(document).on 'page:load', ready