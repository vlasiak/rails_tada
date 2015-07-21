# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @User

  @initialize: () ->
    clearLogoutStorage()
    bindLogoutListener()
    bindLogoutEvent()
    bindErrorDisplaying()

  detectLogoutLink = () ->
    $('a#logout')

  clearLogoutStorage = () ->
    window.localStorage.removeItem 'logout'

  bindErrorDisplaying = () ->
    callout = $('.bs-callout')
    callout.toggle() if callout.find('h4').html()

  bindLogoutListener = () ->
    window.addEventListener 'storage', storageChange

  bindLogoutEvent = () ->
    logoutLink = detectLogoutLink()
    logoutLink.click () ->
      logoutEverywhere()
      return false

  logoutEverywhere = () ->
    window.localStorage.setItem 'logout', true

  storageChange = (event) ->
    if event.key == 'logout'
      window.location = detectLogoutLink().attr('href')

$ ->
  User.initialize()