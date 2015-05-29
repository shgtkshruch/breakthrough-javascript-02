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
