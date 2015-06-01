Modal = (el) ->
  @initialize el

Modal::initialize = (el) ->
  @$el = el
  @$container = $ '#modal'
  @$contents = $ '#modal-contents'
  @$close = $ '#modal-close'
  @$next = $ '#modal-next'
  @$prev = $ '#modal-prev'
  @$overlay = $ '#modal-overlay'
  @$window = $ window
  @handleEvents()

Modal::handleEvents = ->
  @$el.on 'click', (e) =>
    @show e
    return false

  @$close.on 'click', (e) =>
    @hide e
    return false

  @$overlay.on 'click', (e) =>
    @hide e
    return false

  @$next.on 'click', (e) =>
    @next e
    return false

  @$prev.on 'click', (e) =>
    @prev e
    return false

  @$window.on 'load resize', =>
    @resize()

Modal::show = (e) ->
  $target = $ e.currentTarget
  src = $target.attr 'href'

  @$contents.html '<img src="' + src + '"/>'
  @$container.fadeIn()
  @$overlay.fadeIn()

  index = $target.data 'index'
  @countChange = @createCounter index, @$el.length
  return false

Modal::hide = (e) ->
  @$container.fadeOut()
  @$overlay.fadeOut()

Modal::slide = (index) ->
  @$contents
    .find 'img'
    .fadeOut
      complete: ->
        src = $ '[data-index="' + index + '"]'
          .find 'img'
          .attr 'src'
        $ @
          .attr 'src', src
          .fadeIn()

Modal::createCounter = (index, len) ->
  (num) ->
    index = (index + num + len) % len

Modal::next = ->
  @slide @countChange 1

Modal::prev = ->
  @slide @countChange -1

Modal::resize = ->
  w = @$window.width()
  if w < 640
    @$container.css
      "width": "320"
      "height": "213"
  else
    @$container.css
      "width": "750"
      "height": "500"


modal = new Modal $ '#modal-thumb a'
