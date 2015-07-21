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
      logoutEverywhere()
      return false

  logoutEverywhere = () ->
    window.localStorage.setItem 'logout', true

  storageChange = (event) ->
    if event.key == 'logout'
      window.location = detectLogoutLink().attr('href')

$ ->
  User.initialize()