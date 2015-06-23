# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# permit functions for eval
permit_functions = ['expand_on_click', 'collapse_on_click']

# hide element
hide_element = (element) ->
  element.addClass('hidden')

# show element
show_element = (element) ->
  element.removeClass('hidden')

#make focus on element
make_focus_on = (element) ->
  element.focus()

# expand a form and hide a button
expand_on_click = (element) ->
  $(element).click (event) ->
    event.preventDefault()
    hide_element $(this)
    show_element $(this).parent().find('form')
    make_focus_on $(this).parent().find("input[type='text']")

# collapse a form and show button
collapse_on_click = (element) ->
  $(element).click (event) ->
    show_element $(this).closest('div').find('a')
    hide_element $(this).closest('form')

# call method from data attribute
call_data_method = (element) ->
  data_method = $(element).data('behavior')
  eval(data_method)(element) if $.inArray(data_method, permit_functions) != -1

# attach events to elements
attach_events = (elements) ->
  $.each $(elements), (_, value) ->
    call_data_method(value)

# find 'Add a to-do' links
find_add_links = ->
  $('div.list a')

# find 'Close' buttons
find_close_buttons = ->
  $('div.list form button')

# attach events to links and buttons
$('document').ready () ->
  attach_events(find_add_links())
  attach_events(find_close_buttons())

# attach esc key pressing on input
$('document').ready () ->
  $("form input[type='text']").keyup (event) ->
    that = this
    if event.keyCode == 27
      $(that).parents('form').find('button').click()