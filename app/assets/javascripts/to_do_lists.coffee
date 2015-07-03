# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @TodoList
  initialize: () ->
    bindAddEvent()

  onCreate: (html) ->
    $('div.container').append html

  detectAddButton = () ->
    $('#add-list-button')

  bindAddEvent = () ->
    expandOnClick detectAddButton()

  showPopUp = () ->
    $('#add-list-modal').modal()

  expandOnClick = (element) ->
    element.click () ->
      $.ajax
        url: this['href']
        method: 'GET'
        error: () ->
          console.log 'error'
        success: (response) ->
          $('div.container').append response
          showPopUp()
      return false

$ ->
  todoList = new TodoList
  todoList.initialize()