<?php

if (!defined('_PS_VERSION_'))
	exit;

class sharrre_ps extends Module
{
	function __construct($dontTranslate = false)
	{
		$this->name = 'sharrre_ps';
		$this->version = '1.0';
		$this->author = 'Carlos RM';
		$this->tab = 'front_office_features';
		$this->need_instance = 0;

		parent::__construct();

		if(!$dontTranslate)
		{
			$this->displayName = $this->l('Sharrre for prestashop');
			$this->description = $this->l('Allows customers to share content at social networks.');
		}
	}

	function install()
	{
		return (parent::install() AND $this->registerHook('extraLeft') && $this->registerHook('header'));
	}
	
	public function hookHeader()
	{
		Tools::addCSS(($this->_path).'sharrre_ps.css', 'all');
	}

	function hookExtraLeft($params)
	{
		global $smarty;
		$smarty->assign('this_path', $this->_path);

			/*crm, poño esto para ter a imagen do producto,para o pinterest */
		$error = false;
		$confirm = false;

		
		global $cookie, $link;
		/* Product informations */
		$product = new Product((int)Tools::getValue('id_product'), false, (int)$cookie->id_lang);
		$productLink = $link->getProductLink($product);
		

		/* Image */
		$images = $product->getImages((int)$cookie->id_lang);

		foreach ($images AS $k => $image)
			if ($image['cover'])
			{
				$cover['id_image'] = (int)$product->id.'-'.(int)$image['id_image'];
				$cover['legend'] = $image['legend'];
			}

		if (!isset($cover))
			$cover = array('id_image' => Language::getIsoById((int)$cookie->id_lang).'-default', 'legend' => 'No picture');

		$smarty->assign(array(
			'cover' => $cover,			
		));

		/*fin crm*/

		return $this->display(__FILE__, 'product_page.tpl');
	}
	
	public function displayPageForm()
	{
		if (!$this->active)
			Tools::display404Error();

		include(dirname(__FILE__).'/../../header.php');
		echo $this->displayFrontForm();
		include(dirname(__FILE__).'/../../footer.php');
	}

	public function displayFrontForm()
	{
		global $smarty;
		$error = false;
		$confirm = false;

		if (isset($_POST['submitAddtoafriend']))
		{
			global $cookie, $link;
			/* Product informations */
			$product = new Product((int)Tools::getValue('id_product'), false, (int)$cookie->id_lang);
			$productLink = $link->getProductLink($product);

			/* Fields verifications */
			if (empty($_POST['email']) OR empty($_POST['name']))
				$error = $this->l('You must fill in all fields.');
			elseif (empty($_POST['email']) OR !Validate::isEmail($_POST['email']))
				$error = $this->l('The e-mail given is invalid.');
			elseif (!Validate::isName($_POST['name']))
				$error = $this->l('The name given is invalid.');
			elseif (!isset($_GET['id_product']) OR !is_numeric($_GET['id_product']))
				$error = $this->l('An error occurred during the process.');
			else
			{
				/* Email generation */
				$subject = ($cookie->customer_firstname ? $cookie->customer_firstname.' '.$cookie->customer_lastname : $this->l('A friend')).' '.$this->l('sent you a link to').' '.$product->name;
				$templateVars = array(
					'{product}' => $product->name,
					'{product_link}' => $productLink,
					'{customer}' => ($cookie->customer_firstname ? $cookie->customer_firstname.' '.$cookie->customer_lastname : $this->l('A friend')),
					'{name}' => Tools::safeOutput($_POST['name'])
				);

				/* Email sending */
				if (!Mail::Send((int)$cookie->id_lang, 'send_to_a_friend', Mail::l('A friend sent you a link to').' '.$product->name, $templateVars, $_POST['email'], NULL, ($cookie->email ? $cookie->email : NULL), ($cookie->customer_firstname ? $cookie->customer_firstname.' '.$cookie->customer_lastname : NULL), NULL, NULL, dirname(__FILE__).'/mails/'))
					$error = $this->l('An error occurred during the process.');
				else
					Tools::redirect(_MODULE_DIR_.'/'.$this->name.'/sendtoafriend-form.php?id_product='.(int)$product->id.'&submited');
			}
		}
		else
		{
			global $cookie, $link;
			/* Product informations */
			$product = new Product((int)Tools::getValue('id_product'), false, (int)$cookie->id_lang);
			$productLink = $link->getProductLink($product);
		}

		/* Image */
		$images = $product->getImages((int)$cookie->id_lang);
		foreach ($images AS $k => $image)
			if ($image['cover'])
			{
				$cover['id_image'] = (int)$product->id.'-'.(int)$image['id_image'];
				$cover['legend'] = $image['legend'];
			}

		if (!isset($cover))
			$cover = array('id_image' => Language::getIsoById((int)$cookie->id_lang).'-default', 'legend' => 'No picture');

		$smarty->assign(array(
			'cover' => $cover,
			'errors' => $error,
			'confirm' => $confirm,
			'product' => $product,
			'productLink' => $productLink
		));

		return $this->display(__FILE__, 'sendtoafriend.tpl');
	}
}

