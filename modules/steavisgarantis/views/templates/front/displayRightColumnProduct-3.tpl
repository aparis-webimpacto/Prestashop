{*
* NOTICE OF LICENSE
*
* This file is licenced under the Software License Agreement.
* With the purchase or the installation of the software in your application
* you accept the licence agreement.
*
* You must not modify, adapt or create derivative works of this source code
*
*  @author    Société des Avis Garantis <contact@societe-des-avis-garantis.fr>
*  @copyright 2013-2022 Société des Avis Garantis
*  @license   LICENSE.txt
*
*}

<link rel="stylesheet" href="{$modules_dir|escape:'htmlall':'UTF-8'}steavisgarantis/views/css/style.css" type="text/css" />
<style>
    {literal}
    #agWidgetH .animate {animation-duration: 1s;  animation-name: newWidth;  animation-iteration-count: 1;}
    @keyframes newWidth {from {width: 0%} to {width: {/literal}{20 * $reviewRate|escape:'htmlall':'UTF-8'}{literal}%}}
    {/literal}
</style>
<script type="text/javascript">
    {literal}
    window.addEventListener('load', function() {
      if (document.getElementsByTagName('h1').length) {
        let widgetSummary = document.getElementById('agWidgetH');
        let firstH1 = document.getElementsByTagName('h1')[0];
        firstH1.parentNode.insertBefore(widgetSummary, firstH1.nextSibling);
        widgetSummary.style.display = "block";
      }else{
        document.getElementById('agWidgetH').style.display = "block";
      }
    });
    {/literal}
</script>

<div id="agWidgetH" class="inline agWidget rad {$sagLang|escape:'htmlall':'UTF-8'}" style="display:none;">
  <div class="inner rad">
    <a class="agBt rad4" onclick="showReviews(); return false;" href="#ag-s">
      <div class="reviewGlobal">
        <div class="steavisgarantisStar"><span></span><span class="note animate" style="width:{20 * $reviewRate|escape:'htmlall':'UTF-8'}%"></span></div>
        <p>({$nbReviews|escape:'htmlall':'UTF-8'} {if $nbReviews==1}{l s='review' mod='steavisgarantis'}{else}{l s='reviews' mod='steavisgarantis'}{/if})</p>
      </div>
    </a>
  </div>
</div>
