// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require moment
//=	require underscore
//=	require calendar
//= require wickedpicker
//= require foundation-datepicker
//=	require clndr-rails
//= require jquery_ujs
//= require turbolinks

// document.ready
$(document).ready(ready);
// for turbolink load
$(document).on('page:load', ready);

function ready() {
	passwordConfirm();
	filename();
	timePicker();
	navHamburger();
	removeButtonDataTarget();
	navHamburgerToggle();
	ajaxForms();
	flashMessage();
	if(window.location.pathname === "/calendar") {
		calendar();
	}
}

function passwordConfirm() {
	var $passConfirm = $(".password-confirm");
	var $passOne = $('.pass-first');
	var $passTwo = $('.pass-second');
	var noMatch = '<i class="fa fa-times-circle pass-nomatch" aria-hidden="true"></i>';
	var match = '<i class="fa fa-check-circle pass-match" aria-hidden="true"></i>'
	var $passContainer = $(".pass-match-container");
	var $registerButton = $(".submit.register");
	var $username = $("#signup-username");
	if($passConfirm.length > 0) {
		$(".input-container").on('input', '.password-confirm', function(e) {
			if ($passOne.val() === $passTwo.val() && ($passOne.length > 0)) {
				$passContainer.html(match);
				console.log($username.val());
				if($username.val().length > 0) {
					$registerButton.show("fast");
				}
			} else {
				$registerButton.hide("fast");
				$passContainer.html(noMatch);
			}
		})
	}
}

function filename() {
	$("#user_avi").on("change", function(e) {
		var filePath = $(this).val();
		var split = filePath.split("\\");
		var filename = split[split.length - 1];
		$("#filename").empty();
		$("#filename").append(filename);
	});
}

function timePicker() {
	if($('.timepicker')) {
		$('.timepicker').wickedpicker();
	}
}

function navHamburger() {
	$(window).resize(function() {
		removeButtonDataTarget();
	})
}

function navHamburgerToggle() {
	var el = $('#bs-example-navbar-collapse-1');
	$('body').on('click', 'button.navbar-toggle', function() {
		if(el.height() < 25) {
			el.css({
				height: "0px",
			    display: "block",
			    "overflow-y": "visible"
			});
			el.animate({
			    height: "26px"
			}, 200);
		} else {
			el.css({
				"overflow-y": 'hidden'
			});
			el.animate({
			    height: "0px"
			}, 200, null, function() {
				el.css({
					"display": 'none'
				});
			});
		}
	})
}

function removeButtonDataTarget() {
	// Fetch an array of all the data
	var el = $("button.navbar-toggle");
	var data = el.data(),
	    i;
	// Fetch all the key-names
	var keys = $.map(data , function(value, key) { return key; });
	// Loop through the keys, remove the attribute if the key contains "lorem".
	for(i = 0; i < keys.length; i++) {
	    if (keys[i].indexOf('target') != -1) {
	        el.removeAttr("data-" + keys[i]);
	    }
	}
}

function ajaxForms() {
	// use addEventComment for when you want to dynamically add comments. for now page reloads on success
	// addEventComment();
}

function addEventComment() {
	if($("form#add_comment")) {
		$("form#add_comment").on('submit', function(e) {
			e.preventDefault();
			var eventId = $("#event_id").val();
			var data = {
				comments: { 
					post: $("#comment_post").val(),
					id: eventId
				}
			};
			var url = "/events/" + eventId + "/comments/";
			$.ajax({
			  type: "POST",
			  url: url,
			  data: data,
			  success: success,
			  error: error
			});
		});

		function success(res) {
			// for now just reload page
			location.reload();
		}

		function error (res) {
			console.log(res, "ERROR");
		}
	}
}

function flashMessage() {
	var el = $("div#flash-message-container");
	if(el) {
		el.fadeIn(400, function() {
		    setTimeout(function() { 
		    	el.fadeOut(400, function() {});
		    }, 2000);
		});
	}
}