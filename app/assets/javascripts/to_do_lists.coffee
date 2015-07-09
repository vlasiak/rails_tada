# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @TodoList
  initialize: () ->
    bindAddEvent()

  onCreate: (options) ->
    return renderList options unless options.error
    message = detectCreateListAlertMessage()
    showCheckAlert message

  detectAddButton = () ->
    $('#add-list-button')

  detectContainer = () ->
    $('div.container')

  detectPopUp = () ->
    $('#add-list-modal')

  detectList = (id) ->
    $("#list-#{id}")

  detectNewListSubmitButton = () ->
    $('#new-list-submit-button')

  detectNewListTitle = () ->
    $('#list_title')

  detectNewListDescription = () ->
    $('#list_description')

  detectNewListCloseButton = () ->
    $('#close-new-list-form')

  detectNewListAlertMessage = () ->
    $('#alert-box-new-list')

  detectCreateListAlertMessage = () ->
    $('#alert-box-create-list')

  appendNewOne = (html) ->
    detectContainer().append html

  showCheckAlert = (alertBox) ->
    return unless alertBox.css('display') == 'none'
    alertBox.fadeIn('slow').delay(3000).fadeOut('slow')

  scrollToNewOne = (id) ->
    $('html').animate({
      scrollTop: detectList(id).offset().top
    }, 1000);

  removeInvitation = () ->
    invitation = $('div.empty')
    invitation.remove()

  renderList = (options) ->
    removeInvitation()
    closePopUp()
    appendNewOne options.html
    scrollToNewOne options.id
    bindAddItemEvent options.id

  initializeFields = () ->
    detectNewListSubmitButton().addClass('disabled')
    detectNewListDescription().val('')
    detectNewListTitle().val('')

  bindAddEvent = () ->
    expandOnClick detectAddButton()

  bindinputValidationEvent = () ->
    validateOnInput detectNewListTitle()

  bindAddItemEvent = (id) ->
    TodoItem.startAdding id

  bindModalShownEvent = () ->
    $('.modal').on 'shown.bs.modal', () ->
      detectNewListTitle().focus()

  validateOnInput = (element) ->
    element.keyup () ->
      $submitButton = detectNewListSubmitButton()
      if detectNewListTitle().val().trim()
        $submitButton.removeClass('disabled')
      else
        $submitButton.addClass('disabled')

  closePopUp = () ->
    detectNewListCloseButton().click()

  showPopUp = () ->
    detectPopUp().modal()
    bindinputValidationEvent()
    initializeFields()

  renderPopUp = (list) ->
    detectContainer().append list
    bindModalShownEvent()
    showPopUp()

  expandOnClick = (element) ->
    element.click () ->
      $popUp = detectPopUp()
      if $popUp.length
        showPopUp()
      else
        doPopUpRequest $(element).attr('href')
      return false

  doPopUpRequest = (url) ->
    $.ajax
      url: url
      method: 'GET'
      error: () ->
        message = detectNewListAlertMessage()
        showCheckAlert message
      success: (response) ->
        renderPopUp response

$ ->
  todoList = new TodoList
  todoList.initialize()