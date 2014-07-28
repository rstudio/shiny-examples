(function() {

function updateChooser(chooser) {
    chooser = $(chooser);
    var left = chooser.find("select.left");
    var right = chooser.find("select.right");
    var leftArrow = chooser.find(".left-arrow");
    var rightArrow = chooser.find(".right-arrow");
    
    var canMoveTo = (left.val() || []).length > 0;
    var canMoveFrom = (right.val() || []).length > 0;
    
    leftArrow.toggleClass("muted", !canMoveFrom);
    rightArrow.toggleClass("muted", !canMoveTo);
}

function move(chooser, source, dest) {
    chooser = $(chooser);
    var selected = chooser.find(source).children("option:selected");
    var dest = chooser.find(dest);
    dest.children("option:selected").each(function(i, e) {e.selected = false;});
    dest.append(selected);
    updateChooser(chooser);
    chooser.trigger("change");
}

$(document).on("change", ".chooser select", function() {
    updateChooser($(this).parents(".chooser"));
});

$(document).on("click", ".chooser .right-arrow", function() {
    move($(this).parents(".chooser"), ".left", ".right");
});

$(document).on("click", ".chooser .left-arrow", function() {
    move($(this).parents(".chooser"), ".right", ".left");
});

$(document).on("dblclick", ".chooser select.left", function() {
    move($(this).parents(".chooser"), ".left", ".right");
});

$(document).on("dblclick", ".chooser select.right", function() {
    move($(this).parents(".chooser"), ".right", ".left");
});

var binding = new Shiny.InputBinding();

binding.find = function(scope) {
  return $(scope).find(".chooser");
};

binding.initialize = function(el) {
  updateChooser(el);
};

binding.getValue = function(el) {
  return {
    left: $.makeArray($(el).find("select.left option").map(function(i, e) { return e.value; })),
    right: $.makeArray($(el).find("select.right option").map(function(i, e) { return e.value; }))
  }
};

binding.setValue = function(el, value) {
  // TODO: implement
};

binding.subscribe = function(el, callback) {
  $(el).on("change.chooserBinding", function(e) {
    callback();
  });
};

binding.unsubscribe = function(el) {
  $(el).off(".chooserBinding");
};

binding.getType = function() {
  return "shinyjsexamples.chooser";
};

Shiny.inputBindings.register(binding, "shinyjsexamples.chooser");

})();