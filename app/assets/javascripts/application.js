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

	calendar();
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