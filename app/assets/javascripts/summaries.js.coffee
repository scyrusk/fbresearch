# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @SummaryWatcher
  constructor: (@textBox, @submit, @count) ->
    @validated = false
    @validationCallbacks = [@enableSubmit]
    @invalidationCallbacks = [@disableSubmit]

    @textBox.bind 'keyup', (event) =>
      @count.text @textBox.val().length
      @check()

  valid: =>
    return @textBox.val().length >= 50 && @textBox.val().length <= 140

  check: =>
    if @valid() && not @validated
      for callback in @validationCallbacks
        callback()
      @validated = true
    else if not @valid() && @validated
      for callback in @invalidationCallbacks
        callback()
      @validated = false

  enableSubmit: =>
    @submit.removeAttr "disabled"

  disableSubmit: =>
    @submit.attr "disabled", true