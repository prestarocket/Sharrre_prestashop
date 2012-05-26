	<script type="text/javascript" src="{$this_path}jquery.sharrre-1.3.2.js"></script>

	
	<div id="facebook"></div>
	<div id="twitter"></div>	
	<div id="googlePlus"></div>
	<div id="pinterest"></div>
	<script>

		$('#twitter').sharrre({
		  share: {
			twitter: true, 			
		  },
		  title: ' ',
		  url: document.location.href,
		  enableHover: false,
		  enableTracking: true,
		  click: function(element, options){
			window.open("https://twitter.com/intent/tweet?text={$product->name}&url="+encodeURIComponent(options.url), "", "toolbar=0, status=0, width=650, height=360");
		  },
		  render: function(element, options){
			$(element).find('.count').append('<div class="tooltip-pointer"><div class="inner"></div></div>');
		  }
		});

		$('#facebook').sharrre({
		  share: {
			facebook: true
		  },
		  title: ' ',
		  url: document.location.href,
		  enableHover: false,
		  enableTracking: true,
		  click: function(element, options){
			window.open("http://www.facebook.com/sharer.php?u="+encodeURIComponent(options.url)+"&t={$product->name}", "", "toolbar=0, status=0, width=900, height=500");
		  }
		});

		$('#googlePlus').sharrre({
		  share: {
			googlePlus: true
		  },
		  title: ' ',	
		  template: '<div class="box"><a class="count" href="#">[total]</a><a class="share" href="#"></a></div>',
		  url: document.location.href,
		  enableHover: false,
		  enableTracking: true,
		  click: function(element, options){		  	
			window.open("https://plusone.google.com/_/+1/confirm?hl=es&url="+encodeURIComponent(options.url), "", "toolbar=0, status=0, width=900, height=500");
		  }
		});

		$('#pinterest').sharrre({
		  share: {
			pinterest: true
		  },		 
		  title: ' ',
		  template: '<div class="box"><a class="count" href="#">[total]</a><a class="share" href="#"></a></div>',
		  url: document.location.href,
		  enableHover: false,
		  enableTracking: true,
		  click: function(element, options){

		  	window.open("http://pinterest.com/pin/create/button/?url="+encodeURIComponent(options.url)+"&media={$link->getImageLink($product->link_rewrite, $cover.id_image, 'large')}&description={$product->name}", "", "toolbar=0, status=0, width=900, height=500");
			
		  }
		});
				
	</script>