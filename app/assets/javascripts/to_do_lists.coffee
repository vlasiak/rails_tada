# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @TodoList
  initialize: () ->
    bindAddEvent()
    bindFilterSaving()
    applyFilter()

  onCreate: (options) ->
    return renderList options unless options.error
    message = detectCreateListAlertMessage()
    showCheckAlert message

  onSearch: (html) ->
    detectListsContainer().html(html)
    TodoItem.initialize()

  detectAddButton = () ->
    $('#add-list-button')

  detectSearchInput = () ->
    $('#search')

  detectContainer = () ->
    $('div.container')

  detectListsContainer = () ->
    $('div#lists-container')

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

  applyFilter = () ->
    url = $('#search-form').attr('action')
    pattern = $.cookie 'filter'
    detectSearchInput().val(pattern)
    doSearchRequest url, pattern if pattern

  appendNewOne = (html) ->
    detectListsContainer().append html

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
    bindSortEvent detectList options.id

  initializeFields = () ->
    detectNewListSubmitButton().addClass('disabled')
    detectNewListDescription().val('')
    detectNewListTitle().val('')

  bindFilterSaving = () ->
    $(window).unload () ->
      $.cookie 'filter', detectSearchInput().val().trim()

  bindAddEvent = () ->
    expandOnClick detectAddButton()

  bindinputValidationEvent = () ->
    validateOnInput detectNewListTitle()

  bindAddItemEvent = (id) ->
    TodoItem.startAdding id

  bindSortEvent = (list) ->
    TodoItem.makeDraggable list.find('ul.incomplete')

  bindModalShownEvent = () ->
    $('.modal').on 'shown.bs.modal', () ->
      detectNewListTitle().focus()

  toggleSubmitActivity = () ->
    $submitButton = detectNewListSubmitButton()
    if detectNewListTitle().val().trim()
      $submitButton.removeClass('disabled')
    else
      $submitButton.addClass('disabled')

  validateOnInput = (element) ->
    element.on('keyup', () -> toggleSubmitActivity())
      .on('select', () -> toggleSubmitActivity())

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

  doSearchRequest = (url, pattern) ->
    $.ajax
      url: url
      method: 'GET'
      data: {search: pattern}
      success: () ->
        $.removeCookie 'filter'

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