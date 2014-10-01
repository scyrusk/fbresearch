# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class _Publication
  constructor: (@title, @venue, @link, @summary, @abstract, @year, @pdf_link, @index) ->

class _PublicationLedger
  constructor: () ->
    @publications = []
    @indexCounter = 0

  addPublication: (title, venue, link, summary, abstract, year, pdf_link) =>
    @publications.push new _Publication(title, venue, link, summary, abstract, year, pdf_link, @indexCounter++)

window.PublicationLedger = new _PublicationLedger()