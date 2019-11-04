jQuery(document).ready(function($){
	//final width --> this is the quick view image slider width
	//maxQuickWidth --> this is the max-width of the quick-view panel
	var sliderFinalWidth = 400,
		maxQuickWidth = 900;

	//open the quick view panel
	$('.cd-trigger').on('click', function(event){
		
		var selectedImage = $(this).parent('.cd-item').children('div.img-box'),
			slectedImageUrl = selectedImage.attr('src');
		$('body').addClass('overlay-layer');
		animateQuickView(selectedImage, sliderFinalWidth, maxQuickWidth, 'open');

		//update the visible slider image in the quick view panel
		//you don't need to implement/use the updateQuickView if retrieving the quick view data with ajax
		updateQuickView(slectedImageUrl);
	});

	//close the quick view panel
	$('body').on('click', function(event){
		if( $(event.target).is('.cd-close') || $(event.target).is('body.overlay-layer')) {
			closeQuickView( sliderFinalWidth, maxQuickWidth);
		}
	});
	$(document).keyup(function(event){
		//check if user has pressed 'Esc'
    	if(event.which=='27'){
			closeQuickView( sliderFinalWidth, maxQuickWidth);
		}
	});

	//quick view slider implementation
	/*
	$('.cd-quick-view').on('click', '.cd-slider-navigation a', function(){
		updateSlider($(this));
	});
	*/

	//center quick-view on window resize
	$(window).on('resize', function(){
		if($('.cd-quick-view').hasClass('is-visible')){
			window.requestAnimationFrame(resizeQuickView);
		}
	});

});
function updateSlider(navigation) {
	var sliderConatiner = navigation.parents('.cd-slider-wrapper').find('.cd-slider'),
		activeSlider = sliderConatiner.children('.selected').removeClass('selected');
	/*
	if ( navigation.hasClass('cd-next') ) {
		( !activeSlider.is(':last-child') ) ? activeSlider.next().addClass('selected') : sliderConatiner.children('li').eq(0).addClass('selected'); 
	} else {
		( !activeSlider.is(':first-child') ) ? activeSlider.prev().addClass('selected') : sliderConatiner.children('li').last().addClass('selected');
	} 
	*/
}

function updateQuickView(url) {
	$('.cd-quick-view .cd-slider li').removeClass('selected').find('div.img-box[src="'+ url +'"]').parent('li').addClass('selected');
}

function resizeQuickView() {
	
	var quickViewLeft = ($(window).width() - $('.cd-quick-view').width())/2,
		quickViewTop = ($(window).height() - $('.cd-quick-view').height())/2;
	$('.cd-quick-view').css({
	    "top": quickViewTop,
	    "left": quickViewLeft,
	});
} 

function closeQuickView(finalWidth, maxQuickWidth) {
	var close = $('.cd-close'),
		activeSliderUrl = close.siblings('.cd-slider-wrapper').find('.selected div.img-box').attr('src'),
		selectedImage = $('.empty-box').find('div.img-box');
	//update the image in the gallery
	if( !$('.cd-quick-view').hasClass('velocity-animating') && $('.cd-quick-view').hasClass('add-content')) {
		//selectedImage.attr('src', activeSliderUrl);
		animateQuickView(selectedImage, finalWidth, maxQuickWidth, 'close');
	} else {
		closeNoAnimation(selectedImage, finalWidth, maxQuickWidth);
	}
}

function animateQuickView(image, finalWidth, maxQuickWidth, animationType) {
	var parentListItem = image.parent('.cd-item'),
		topSelected = image.offset().top - $(window).scrollTop(),
		leftSelected = image.offset().left,
		widthSelected = $(".cd-quick-view ul.cd-slider li.selected div.img-box").width(),
		heightSelected = $(".cd-quick-view ul.cd-slider li.selected div.img-box").height()*1>700?$(".cd-quick-view ul.cd-slider li.selected div.img-box").height():700,
		windowWidth = $(window).width(),
		windowHeight = $(window).height(),
		finalLeft = (windowWidth - finalWidth)/2,
		finalHeight = finalWidth * heightSelected/widthSelected,
		finalTop = (windowHeight - finalHeight)/2,
		quickViewWidth = ( windowWidth * .8 < maxQuickWidth ) ? windowWidth * .8 : maxQuickWidth ,
		quickViewLeft = (windowWidth - quickViewWidth)/2;

	if( animationType == 'open') {
		//hide the image in the gallery
		parentListItem.addClass('empty-box');
		//place the quick view over the image gallery and give it the dimension of the gallery image
		$('.cd-quick-view').css({
		    "top": topSelected,
		    "left": leftSelected,
		    "width": widthSelected
		})/*.velocity({
		    'top': finalTop+ 'px',
		    'left': finalLeft+'px',
		    'width': finalWidth+'px',
		}, 1000, [ 400, 20 ], function(){
			$('.cd-quick-view').addClass('animate-width').velocity({
				'left': quickViewLeft+'px',
		    	'width': quickViewWidth+'px',
			}, 300, 'ease' ,function(){
				$('.cd-quick-view').addClass('add-content');
			});
		})*/.addClass('is-visible').css({
		    'top': finalTop+ 'px',
		    'left': finalLeft+'px',
		    'width': finalWidth+'px',
		});
		$('.cd-quick-view').addClass('animate-width').velocity({
			'left': quickViewLeft+'px',
	    	'width': quickViewWidth+'px',
		}, 300, 'ease' ,function(){
			$('.cd-quick-view').addClass('add-content');
		});
	} else {
		//close the quick view reverting the animation
		$('.cd-quick-view').removeClass('add-content').velocity({
		    'top': finalTop+ 'px',
		    'left': finalLeft+'px',
		    'width': finalWidth+'px',
		}, 300, 'ease', function(){
			$('body').removeClass('overlay-layer');
			$('.cd-quick-view').removeClass('animate-width').velocity({
				"top": topSelected,
			    "left": leftSelected,
			    "width": widthSelected,
			}, 500, 'ease', function(){
				$('.cd-quick-view').removeClass('is-visible');
				parentListItem.removeClass('empty-box');
			});
		});
	}
}
function closeNoAnimation(image, finalWidth, maxQuickWidth) {
	var parentListItem = image.parent('.cd-item'),
		topSelected = image.offset().top - $(window).scrollTop(),
		leftSelected = image.offset().left,
		widthSelected = image.width();

	$('body').removeClass('overlay-layer');
	parentListItem.removeClass('empty-box');
	$('.cd-quick-view').velocity("stop").removeClass('add-content animate-width is-visible').css({
		"top": topSelected,
	    "left": leftSelected,
	    "width": widthSelected,
	});
}