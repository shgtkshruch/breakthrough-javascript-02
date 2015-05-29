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
    console.log e
    @show e
    return false

Modal::show = (e) ->
  $target = $ e.currentTarget
  src = $target.attr 'href'
  console.log src
  @$contents.html '<img src="' + src + '"/>'
  @$container.fadeIn()
  @$overlay.fadeIn()
  @index = $target.data 'index'
  return false

modal = new Modal $ '#modal-thumb a'
