if (window.Shiny) {
  var cameraInputBinding = new Shiny.InputBinding();
  $.extend(cameraInputBinding, {
    find: function(scope) {
      return $(scope).find(".shiny-camera-input");
    },
    initialize: function(el) {
      const $el = $(el);
      new ShinyCameraInput(
        el,
        $el.children("video")[0],
        $el.children("canvas")[0],
        $el.find(">output>img")[0],
        $el.children("button.take")[0],
        $el.children("button.retake")[0]
      );
    },
    getType: function() {
      return "camera-datauri";
    },
    getValue: function(el) {
      if (el.classList.contains("shot")) {
        const img = el.querySelector("output img");
        if (img) {
          return img.src;
        }
      }
      return null;
    },
    setValue: function(el, value) {

    },
    subscribe: function(el, callback) {
      $(el).on("change.cameraInputBinding", function(e) {
        callback();
      });
    },
    unsubscribe: function(el) {
      $(el).off(".cameraInputBinding");
    },
    
    // The following two methods, setInvalid and clearInvalid, will be called
    // whenever this input fails or passes (respectively) validation.
    setInvalid: function(el, data) {
      el.classList.add("invalid");
      el.querySelector(".feedback-message").innerText = data.message;
    },
    clearInvalid: function(el) {
      el.classList.remove("invalid");
      el.querySelector(".feedback-message").innerText = "";
    }
  });
  Shiny.inputBindings.register(cameraInputBinding);
}

class ShinyCameraInput {

  constructor(container, video, canvas, photo, startbutton, restartbutton) {
    this.stream = null;
    this.streaming = false;

    this.container = container;
    this.video = video;
    this.canvas = canvas;
    this.photo = photo;
    this.startbutton = startbutton;
    this.restartbutton = restartbutton;
    this.width = this.container.getBoundingClientRect().width;
    this.height = 0; // This will be computed based on the input stream

    this.video.addEventListener('canplay', ev => {
      this.height = this.video.videoHeight / (this.video.videoWidth/this.width);
    
      this.container.style.width = this.width + "px";
      this.container.style.height = this.height + "px";
      this.container.classList.add("ready");

      this.video.setAttribute('width', this.width);
      this.video.setAttribute('height', this.height);
      this.canvas.setAttribute('width', this.width);
      this.canvas.setAttribute('height', this.height);
    }, false);
    this.startbutton.addEventListener('click', ev => {
      this.takepicture();
      ev.preventDefault();
    }, false);
    this.restartbutton.addEventListener('click', ev => {
      this.clearphoto();
      ev.preventDefault();
    }, false);
    this.clearphoto();
  }

  start() {
    navigator.mediaDevices.getUserMedia({ video: true, audio: false })
    .then(stream => {
      this.stream = stream;
      this.video.srcObject = stream;
      this.video.play();
    })
    .catch(function(err) {
      console.log("An error occurred: " + err);
    });
  }

  clearphoto() {
    var context = this.canvas.getContext('2d');
    context.fillStyle = "#AAA";
    context.fillRect(0, 0, this.canvas.width, this.canvas.height);

    var data = this.canvas.toDataURL('image/png');
    this.photo.setAttribute('src', data);
    this.container.classList.remove("shot");
    this.container.classList.remove("ready");
    $(this.container).trigger("change");
    this.start();
  }

  takepicture() {
    var context = this.canvas.getContext('2d');
    if (this.width && this.height) {
      this.canvas.width = this.width;
      this.canvas.height = this.height;
      context.drawImage(this.video, 0, 0, this.width, this.height);
    
      var data = this.canvas.toDataURL('image/png');
      this.photo.setAttribute('src', data);
      this.container.classList.add("shot");
      $(this.container).trigger("change");
      
      this.stream.getTracks().forEach(track => {
        if (track.readyState === "live") {
          track.stop();
        }
      });
    } else {
      this.clearphoto();
    }
  }
}
