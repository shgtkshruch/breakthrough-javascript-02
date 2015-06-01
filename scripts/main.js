(function() {
  var Modal, modal;

  Modal = function(el) {
    return this.initialize(el);
  };

  Modal.prototype.initialize = function(el) {
    this.$el = el;
    this.$container = $('#modal');
    this.$contents = $('#modal-contents');
    this.$overlay = $('#modal-overlay');
    this.$parents = this.$el.parents('ul');
    this.$window = $(window);
    return this.handleEvents();
  };

  Modal.prototype.handleEvents = function() {
    this.$parents.on('click', 'a', (function(_this) {
      return function(e) {
        _this.show(e);
        return false;
      };
    })(this));
    this.$overlay.on('click', (function(_this) {
      return function(e) {
        _this.hide(e);
        return false;
      };
    })(this));
    this.$container.on('click', '#modal-close', (function(_this) {
      return function(e) {
        _this.hide(e);
        return false;
      };
    })(this));
    this.$container.on('click', '#modal-next', (function(_this) {
      return function(e) {
        _this.next(e);
        return false;
      };
    })(this));
    this.$container.on('click', '#modal-prev', (function(_this) {
      return function(e) {
        _this.prev(e);
        return false;
      };
    })(this));
    return this.$window.on('load resize', (function(_this) {
      return function() {
        return _this.resize();
      };
    })(this));
  };

  Modal.prototype.show = function(e) {
    var $target, index, src;
    $target = $(e.currentTarget);
    src = $target.attr('href');
    this.$contents.html('<img src="' + src + '"/>');
    this.$container.fadeIn();
    this.$overlay.fadeIn();
    index = $target.data('index');
    this.countChange = this.createCounter(index, this.$el.length);
    return false;
  };

  Modal.prototype.hide = function(e) {
    this.$container.fadeOut();
    return this.$overlay.fadeOut();
  };

  Modal.prototype.slide = function(index) {
    return this.$contents.find('img').fadeOut({
      complete: function() {
        var src;
        src = $('[data-index="' + index + '"]').find('img').attr('src');
        return $(this).attr('src', src).fadeIn();
      }
    });
  };

  Modal.prototype.createCounter = function(index, len) {
    return function(num) {
      return index = (index + num + len) % len;
    };
  };

  Modal.prototype.next = function() {
    return this.slide(this.countChange(1));
  };

  Modal.prototype.prev = function() {
    return this.slide(this.countChange(-1));
  };

  Modal.prototype.resize = function() {
    var w;
    w = this.$window.width();
    if (w < 640) {
      return this.$container.css({
        "width": "320",
        "height": "213"
      });
    } else {
      return this.$container.css({
        "width": "750",
        "height": "500"
      });
    }
  };

  modal = new Modal($('#modal-thumb a'));

  $('#more-btn').on('click', function() {
    var html;
    html = '<li><a href="images/photo-04.jpg" data-index=3><img alt="" src="images/photo-04.jpg" width="160" class="img-thumbnail"></a></li>';
    $(html).appendTo($('#modal-thumb')).hide().fadeIn();
    $(this).fadeOut();
    return modal.$el = $('#modal-thumb a');
  });

}).call(this);
