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
  @$window = $ 'window'
  @index = 0
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

Modal::countChange = (num, index, len) ->
  (index + num + len) % len

Modal::next = ->
  @index = @countChange 1, @index, @$el.length
  @slide @index

Modal::prev = ->
  @index = @countChange -1, @index, @$el.length
  @slide @index

Modal::show = (e) ->
  $target = $ e.currentTarget
  src = $target.attr 'href'

  @$contents.html '<img src="' + src + '"/>'
  @$container.fadeIn()
  @$overlay.fadeIn()
  @index = $target.data 'index'
  return false

Modal::hide = (e) ->
  @$container.fadeOut()
  @$overlay.fadeOut()

modal = new Modal $ '#modal-thumb a'
