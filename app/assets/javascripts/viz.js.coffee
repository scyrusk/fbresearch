# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @InfoHandler
  constructor: ->
    @targetEl = $("#header")
    @infoEl = $("#info")
    @clickSignal = $("#click-signal")
    @shown = false

    @targetEl.bind 'click', () =>
      if @shown
        @infoEl.slideUp()
        @shown = false
        @clickSignal.removeClass "glyphicon-chevron-up"
        @clickSignal.addClass "glyphicon-chevron-down"
      else
        @infoEl.slideDown()
        @shown = true
        @clickSignal.removeClass "glyphicon-chevron-down"
        @clickSignal.addClass "glyphicon-chevron-up"

class @SummaryShifter
  constructor: (nextButtonId, elementIDs) ->
    @nextButton = $("##{nextButtonId}")
    @elements = []
    for elementID in elementIDs
      @elements.push $("##{elementID}")
    @currIndex = 0
    @elements[@currIndex].fadeIn();

    @nextButton.bind 'click', () =>
      curr = @elements[@currIndex]
      @currIndex = (@currIndex + 1) % @elements.length
      curr.fadeOut 300, () =>
        @elements[@currIndex].fadeIn()

class _Viz
  CANVAS_WIDTH: 800
  CANVAS_CENTER_X: 400
  TRANSLATION_X: 50

  constructor: () ->

  backgroundColors: ->
    palette = ["#5757FF", "#62A9FF", "#62D0FF", "#06DCFB", "#01FCEF", "#03EBA6", "#01F33E"]
    d3.selectAll("div.year-pub").data(palette).style('background-color', (d, i) => return d)

  # test: =>
  #   root = d3.select("#vizRoot").append('svg').attr('class', 'svg-viz').attr('width', @WIDTH).attr('height', PublicationLedger.publications.length * 100)

  #   x_pos = (d, i) =>
  #     if i % 2 then 10 else @CENTER_X + @TRANSLATION_X - 10

  #   y_pos = (d, i) =>
  #     i * 100

  #   root.selectAll('rect')
  #       .data(PublicationLedger.publications)
  #       .enter()
  #       .append('rect')
  #       .attr('x', x_pos)
  #       .attr('y', y_pos)
  #       .attr('width', 400)
  #       .attr('height', 150)
  #       .attr('fill', '#eee')
  #       .attr('stroke', 'black')

    # d3.select("#vizRoot")
    #   .selectAll(".title")
    #   .data(PublicationLedger.publications)
    #   .enter()
    #   .append("div")
    #   .attr('class', 'title')
    #   .text (d) => d.title

window.Viz = new _Viz()