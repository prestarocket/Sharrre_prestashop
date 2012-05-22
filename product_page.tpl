{*
* 2007-2011 PrestaShop 
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2011 PrestaShop SA
*  @version  Release: $Revision: 6594 $
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

	<script type="text/javascript" src="{$this_path}jquery.sharrre-1.3.2.js"></script>


	<!--div class="printSend">
			<a href="{$this_path}sendtoafriend-form.php?id_product={$smarty.get.id_product|intval}"><img src="{$img_dir}icon/email.png" alt="{l s='Send to a friend' mod='sendtoafriend'}" title="{l s='Send to a friend' mod='sendtoafriend'}" /></a>
			<a href="javascript:print();"><img src="{$img_dir}icon/print.png" alt="{l s='Print'}" title="{l s='Print'}" /></a><br class="clear" />
	</div-->
	
	<div id="facebook"></div>
	<div id="twitter"></div>	
	<div id="googlePlus"></div>
	<div id="pinterest"></div>
	<script>

		$('#twitter').sharrre({
		  share: {
			twitter: true, 			
		  },
		  title: 'Twittear',
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
		  title: 'Compartir',
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
		  title: '+1',	
		  template: '<div class="box"><a class="count" href="#">[total]</a><a class="share" href="#">+1</a></div>',
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
		  title: 'Pin It',
		  template: '<div class="box"><a class="count" href="#">[total]</a><a class="share" href="#">Pin it</a></div>',
		  url: document.location.href,
		  enableHover: false,
		  enableTracking: true,
		  click: function(element, options){

		  	window.open("http://pinterest.com/pin/create/button/?url="+encodeURIComponent(options.url)+"&media={$link->getImageLink($product->link_rewrite, $cover.id_image, 'large')}&description={$product->name}", "", "toolbar=0, status=0, width=900, height=500");
			
		  }
		});
				
	</script>

