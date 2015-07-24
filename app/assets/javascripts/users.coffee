# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @User

  @initialize: () ->
    clearLogoutStorage()
    bindLogoutListener()
    bindLogoutEvent()

  detectLogoutLink = () ->
    $('a#logout')

  clearLogoutStorage = () ->
    window.localStorage.removeItem 'logout'

  bindLogoutListener = () ->
    window.addEventListener 'storage', storageChange

  bindLogoutEvent = () ->
    logoutLink = detectLogoutLink()
    logoutLink.click () ->
      makeLogoutRequest logoutLink.attr('href')
      return false

  makeLogoutRequest = (url) ->
    $.ajax
      url: url
      method: 'GET'
      success: () ->
        window.localStorage.setItem 'logout', true
        window.location.reload()

  storageChange = (event) ->
    location.reload() if event.key == 'logout'

$ ->
  User.initialize()