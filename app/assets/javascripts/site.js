// JavaScript Document

$(document).ready(function(){

  $(".btn[data-toggle='collapse']").click(function() {
    var _this = this;
    $(".btn[data-toggle='collapse']").each(function(i, el){
      if (_this !== el) {
	var a = $($(el).attr("data-target"));
	if (a.hasClass('in')) {
	  a.collapse('hide');
	  $(el).text('Select');
	}
      }
    });
    if ($(this).text() == 'Select') {
      $(this).text('Selected');
    } else {
      $(this).text('Select');
    }
  });

  $(window).scroll(function () {

    if($(window).scrollTop() > $(window).height()-105) {
      $('.content-secondary-nav').addClass("fix-secondary");
    } else {
      $(".content-secondary-nav").removeClass("fix-secondary");
    };

    if($(window).scrollTop() > 335) {
      $('.content-secondary-nav2').addClass("fix-secondary");
    } else {
      $(".content-secondary-nav2").removeClass("fix-secondary");
    };
  });

  //Stop youtube from playing on modal close
  $(function(){
    $('.closer').click(function(){
      $('iframe').attr('src', $('iframe').attr('src'));
    });
  });

  //Smooth scroll to anchors
  $(function() {
    $('a[href*=#]:not([href=#])').click(function() {
      if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
	var target = $(this.hash);
	target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
	$('html,body').animate({
	  scrollTop: target.offset().top-210
	}, 1000);
	return false;
      }
      }
    });
  });
});

