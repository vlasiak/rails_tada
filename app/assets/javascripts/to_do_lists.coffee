# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @TodoList
  initialize: () ->
    bindAddEvent()

  detectAddButton = () ->
    $('#add-list-button')

  bindAddEvent = () ->
    expandOnClick()

  showPopUp = () ->
    $('#add-list-modal').modal()

  expandOnClick = () ->
    detectAddButton().click () ->
      showPopUp()

$ ->
  todoList = new TodoList
  todoList.initialize()