Modal = (el) ->
  @initialize el

Modal::initialize = (el) ->
  @$el = el
  @$container = $ '#modal'
  @$contents = $ '#modal-contents'
  @$overlay = $ '#modal-overlay'

  @$parents = @$el.parents 'ul'

  @$window = $ window
  @handleEvents()

Modal::handleEvents = ->
  @$parents.on 'click', 'a', (e) =>
    @show e
    return false

  @$overlay.on 'click', (e) =>
    @hide e
    return false

  @$container.on 'click', '#modal-close', (e) =>
    @hide e
    return false

  @$container.on 'click', '#modal-next', (e) =>
    @next e
    return false

  @$container.on 'click', '#modal-prev', (e) =>
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

$ '#more-btn'
  .on 'click', ->
    html = '<li><a href="images/photo-04.jpg" data-index=3>\
    <img alt="" src="images/photo-04.jpg" width="160" class="img-thumbnail">\
    </a></li>'
    $ html
      .appendTo $ '#modal-thumb'
      .hide()
      .fadeIn()
    $ @
      .fadeOut()
    modal.$el = $ '#modal-thumb a'
