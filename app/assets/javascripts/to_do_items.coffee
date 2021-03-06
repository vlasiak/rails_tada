class @TodoItem

  @initialize: () ->
    bindAddEvents()
    bindCheckEvents()
    bindDraggingEvents()

  onCreate: (options) ->
    renderItem options

  @startAdding: (listId) ->
    @expandOnClick listId
    @renderForm listId

  @expandOnClick = (id) ->
    $addItemLink = detectAddLink id
    $addItemLink.click () =>
      @renderForm id
      return false

  @renderForm = (id) ->
    $addItemLink = detectAddLink id
    $addItemLink.toggle()
    $form = detectForm id
    return drawForm $addItemLink.attr('href'), id unless $form.length
    $form.toggle()
    focusOn id

  @makeDraggable = (element) ->
    element.sortable
      handle: '.glyphicon-sort'
      update: (event, ui) ->
        updatePosition ui.item

  appendNewOne = (listId, html) ->
    detectList(listId).find('ul.incomplete').append html

  focusOn = (listId) ->
    detectFormInput(listId).val('').focus()

  highlightNewOne = (id) ->
    detectItem(id).css({'background-color':'#ffffe0'}).
      animate({'background-color':'#fff'}, 2000)

  revertMoving = (listId) ->
    detectList(listId).find('ul.incomplete').sortable('cancel')

  renameLink = (id, name) ->
    detectAddLink(id).text(name)

  renderItem = (options) ->
    removeCallout options.listId
    appendNewOne options.listId, options.html
    renameLink options.listId, options.newLinkName
    focusOn options.listId
    highlightNewOne options.id if options.id
    checkOnClick detectCheckbox(options.id)[0]

  detectList = (id) ->
    $("#list-#{id}")

  detectItem = (id) ->
    $("#item-#{id}")

  detectCheckbox = (id) ->
    $("#item-cb-#{id}")

  detectAddLink = (id) ->
    $("#add-item-link-#{id}")

  detectForm = (id) ->
    $("#form-#{id}")

  detectFormInput = (id) ->
    $("#item-input-#{id}")

  detectCancelFormButton = (id) ->
    $("#cancel-item-button-#{id}")

  extractId = (itemId) ->
    itemId.split('-').pop()

  removeCallout = (listId) ->
    detectList(listId).find('div.bs-callout').remove()

  checkOnClick = (item) ->
    $(item).click () ->
      makeCheckRequest $(item)

  toggle = (options) ->
    list = detectList options.list_id
    destinationList =
      if options.done
        list.find('ul.complete')
      else
        list.find('ul.incomplete')
    detectItem(options.id).appendTo destinationList

  revertChecking = (id) ->
    currentCheckbox = $("##{id}")
    currentCheckbox.prop 'checked', !currentCheckbox.prop 'checked'

  showAlert = (listId, typeError) ->
    alertBox = detectList(listId).find("div.#{typeError}")
    return unless alertBox.css('display') == 'none'
    alertBox.fadeIn('slow').delay(3000).fadeOut('slow')

  onCheckError = (item) ->
    revertChecking item.attr('id')
    showAlert item.attr('value'), 'mark-error'

  onMoveError = (listId) ->
    revertMoving listId
    showAlert listId, 'move-error'

  makeCheckRequest = (item) ->
    $.ajax
      url: item.attr('url')
      method: 'PUT'
      error: () ->
        onCheckError item
      success: (response) ->
        toggle response

  makeMoveRequest = (options) ->
    $.ajax
      url: options.moveUrl
      data: {id: options.id, position: options.position}
      method: 'PATCH'
      error: () ->
        onMoveError options.listId
      success: () ->
        highlightNewOne options.id

  updatePosition = (item) ->
    options = {}
    options.id = extractId item.attr('id')
    options.listId = item.find("input[type='checkbox']").attr('value')
    options.moveUrl = item.attr('move-url')
    options.position = item.index() + 1
    makeMoveRequest options

  bindAddEvents = () =>
    $.each $('div.list a'), (_, value) =>
      id = extractId value['id']
      @expandOnClick id

  bindCheckEvents = () ->
    $.each $("div.list input[type='checkbox']"), (_, value) =>
      checkOnClick value

  bindDraggingEvents = () =>
    $.each $('ul.incomplete'), (_, value) =>
      @makeDraggable $(value)

  bindCancelEvent = (id) ->
    collapseOnClick id

  bindEscKeyEvent = (id) ->
    detectFormInput(id).keydown (event) ->
      detectCancelFormButton(id).click() if event.keyCode == 27

  initializeForm = (id, html) ->
    detectList(id).find('div.complete').before html
    focusOn id
    bindCancelEvent id
    bindEscKeyEvent id

  drawForm = (url, id) ->
    $.ajax
      url: url
      method: 'GET'
      success: (response) ->
        initializeForm id, response

  collapseForm = (id) ->
    removeCallout id
    detectAddLink(id).toggle()
    detectForm(id).toggle()

  collapseOnClick = (id) ->
    detectCancelFormButton(id).click (event) =>
      collapseForm id

$ ->
  TodoItem.initialize()