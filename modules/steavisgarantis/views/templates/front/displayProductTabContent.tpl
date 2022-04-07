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

{if $structuredFormat == "json-ld"}
    <script type="application/ld+json">
   {
   "@context": "http://schema.org/",
   "@type": "Product",
   "@id": "{$productUrl|escape:'htmlall':'UTF-8'}",
   "name": "{$sagProduct->name|escape:'htmlall':'UTF-8'}",
      "aggregateRating": {
      "@type": "AggregateRating",
      "ratingValue": "{$reviewsAverage|escape:'htmlall':'UTF-8'}",
      "reviewCount": "{$nbOfReviews|escape:'htmlall':'UTF-8'}",
      "bestRating": "5"
      }
   }
   </script>
    {foreach from=$reviews item=singleReview}
        <script type="application/ld+json">
            {
            "@context": "http://schema.org/",
            "@type": "Product",
            "@id": "{$productUrl|escape:'htmlall':'UTF-8'}",
            "name": "{$sagProduct->name|escape:'htmlall':'UTF-8'}",
            "review" : {
               "@type": "Review",
               "reviewRating": {
                     "@type": "Rating",
                     "ratingValue": "{$singleReview['rate']|escape:'htmlall':'UTF-8'}"
                     },
               "author": {
                     "@type": "Person",
                     "name": "{$singleReview['ag_reviewer_name']|escape:'htmlall':'UTF-8'}"
                     },
               "datePublished": "{$singleReview['date_time']|escape:'htmlall':'UTF-8'}",
               "reviewBody": "{$singleReview['review']|escape:'htmlall':'UTF-8'}"
            }
            }
        </script>
    {/foreach}
{/if}

<div id="ag-s" class="{$sagLang|escape:'htmlall':'UTF-8'}">
{if $showStructured && $structuredFormat == "microdata"}
<div itemscope itemtype="http://schema.org/Product">
    <span style="display:none;" itemprop="name">{$sagProduct->name|escape:'htmlall':'UTF-8'}</span>
{/if}
    <div>
        <div id="agWidgetMain" class="agWidget rad" >
            <div class="topBar">{l s='Reviews about this product' mod='steavisgarantis'}</div>
            <div class="inner bgGrey1" {if $structuredFormat == "microdata"}itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating"{/if}>
            <div class="logoCont"><img src="{$modules_dir|escape:'htmlall':'UTF-8'}steavisgarantis/views/img/{$sagLogo|escape:'htmlall':'UTF-8'}" width="150px" height="35px" class="logoAg">
            <a href="{$certificateUrl|escape:'htmlall':'UTF-8'}" class="agBt certificateBtn" target="_blank">{l s='Show attestation' mod='steavisgarantis'}</a>
            </div><div class="statCont">
                <div class="steavisgarantisStats">
                <div class="item"><span class="stat"><div class="note bar1" style="height:{$ratingValues['percent1']|escape:'htmlall':'UTF-8'}%"><span class="value">{$ratingValues['nb1']|escape:'htmlall':'UTF-8'}</span></div></span><span class="name">1&starf;</span></div>
                <div class="item"><span class="stat"><div class="note bar2" style="height:{$ratingValues['percent2']|escape:'htmlall':'UTF-8'}%"><span class="value">{$ratingValues['nb2']|escape:'htmlall':'UTF-8'}</span></div></span><span class="name">2&starf;</span></div>
                <div class="item"><span class="stat"><div class="note bar3" style="height:{$ratingValues['percent3']|escape:'htmlall':'UTF-8'}%"><span class="value">{$ratingValues['nb3']|escape:'htmlall':'UTF-8'}</span></div></span><span class="name">3&starf;</span></div>
                <div class="item"><span class="stat"><div class="note bar4" style="height:{$ratingValues['percent4']|escape:'htmlall':'UTF-8'}%"><span class="value">{$ratingValues['nb4']|escape:'htmlall':'UTF-8'}</span></div></span><span class="name">4&starf;</span></div>
                <div class="item"><span class="stat"><div class="note bar5" style="height:{$ratingValues['percent5']|escape:'htmlall':'UTF-8'}%"><span class="value">{$ratingValues['nb5']|escape:'htmlall':'UTF-8'}</span></div></span><span class="name">5&starf;</span></div>
                </div>
            </div><div class="reviewCont"> <div class="reviewGlobal">
                <div class="largeNote"><big>{2 * $reviewsAverage|escape:'htmlall':'UTF-8'}</big>/10<p><br>{l s='Based on' mod='steavisgarantis'} {$nbOfReviews|escape:'htmlall':'UTF-8'} {if $nbOfReviews==1}{l s='review' mod='steavisgarantis'}{else}{l s='reviews' mod='steavisgarantis'}{/if}</p></div>
                </div></div>
                {if $structuredFormat == "microdata"}
                    <meta itemprop="ratingValue" content="{$reviewsAverage|escape:'htmlall':'UTF-8'}" />
                    <meta itemprop="reviewCount" content="{$nbOfReviews|escape:'htmlall':'UTF-8'}" />
                    <meta itemprop="bestRating" content="5" />
                {/if}
            </div>
            <ul class="reviewList">
            {$i=0}
            {foreach from=$reviews item=singleReview}    

                <li class="bgGrey{$i % 2|escape:'htmlall':'UTF-8'}" {if $structuredFormat == "microdata"}itemprop="review" itemscope itemtype="https://schema.org/Review"{/if}>
                <div class="author" {if $structuredFormat == "microdata"}itemprop="author" itemscope itemtype="https://schema.org/Person"{/if}>
                <img class="authorAvatar" width="24px" height="24px" src="{$modules_dir|escape:'htmlall':'UTF-8'}steavisgarantis/views/img/ico_user.png" />
                <span {if $structuredFormat == "microdata"}itemprop="name"{/if}>{$singleReview['ag_reviewer_name']|escape:'htmlall':'UTF-8'}</span>
                {if $singleReview['translated']}
                    <img class="agFlag" src="{$modules_dir|escape:'htmlall':'UTF-8'}steavisgarantis/views/img/flag-{$singleReview['source_lang']|escape:'htmlall':'UTF-8'}.png" />
                {/if}
                <br><span class="time"><span class="published">{l s='Published' mod='steavisgarantis'} {$singleReview['date_time']|escape:'htmlall':'UTF-8'}</span>{if $singleReview['order_date']} ({l s='Order date: ' mod='steavisgarantis'}{$singleReview['order_date']|escape:'htmlall':'UTF-8'}){/if}</span>
            </div>
            {if $singleReview['customAnswers']}
                <div class="customAnswers">
                {foreach from=$singleReview['customAnswers'] item=customAnswer}    
                    <span class="customAnswerLabel">
                        {if $customAnswer['question_label'] == "humanHeight"}
                        {l s='Height :' mod='steavisgarantis'}
                        {elseif $customAnswer['question_label'] == "humanWeight"}
                        {l s='Weight :' mod='steavisgarantis'}
                        {else}
                            {$customAnswer['question_label']|escape:'htmlall':'UTF-8'}
                        {/if}
                    
                    </span>
                    <span class="customAnswerContent">{$customAnswer['answer']|escape:'htmlall':'UTF-8'}</span>
                    {if $customAnswer['unit']}
                        <span class="customAnswerUnit">{$customAnswer['unit']|escape:'htmlall':'UTF-8'}</span>
                    {/if}
                {/foreach}
                </div>
            {/if}
            {if $structuredFormat == "microdata"}
                <meta itemprop="datePublished" content="{$singleReview['date_time']|escape:'htmlall':'UTF-8'}">
            {/if}
            <div class="reviewTxt">
             <div class="steavisgarantisStar"><span></span><span class="note" style="width:{20 * $singleReview['rate']|escape:'htmlall':'UTF-8'}%"></span></div>
                <div {if $structuredFormat == "microdata"}itemprop="reviewRating" itemscope itemtype="https://schema.org/Rating"{/if}>
                    <span class="metaHide" {if $structuredFormat == "microdata"}itemprop="ratingValue"{/if}>{$singleReview['rate']|escape:'htmlall':'UTF-8'}</span>
                </div>
            <p class="" {if $structuredFormat == "microdata"}itemprop="reviewBody"{/if}>{$singleReview['review']|escape:'htmlall':'UTF-8'}{if $singleReview['translated']} <span style='font-style:italic;'>({l s='Translated review' mod='steavisgarantis'})</span>{/if}</p>
            {if $singleReview['answer_text']}
            <div class="reponse"><span><img src="{$modules_dir|escape:'htmlall':'UTF-8'}steavisgarantis/views/img/ico_pen.png" height="12">
            {l s='Merchant\'s answer' mod='steavisgarantis'}</span>
            <p>{$singleReview['answer_text']|escape:'htmlall':'UTF-8'}</p></div>
            {/if}
            </div>
            </li>
            {$i = $i + 1}
            {/foreach}
            </ul>

            <img id="chargement" src="{$modules_dir|escape:'htmlall':'UTF-8'}steavisgarantis/views/img/page.gif" style="display:none">
            {if $nbOfReviews > Configuration::get('steavisgarantis_maxReviewPerPage')}
                <div class="inner2">
                <a class="agBt rad4 agBtBig" href="#more-reviews" id="more-reviews"  onclick="return showMoreReviews({$nbOfReviews|escape:'html':'UTF-8'}, 2, {$maxReviewsPage|escape:'htmlall':'UTF-8'}, '{$modules_dir|escape:'html':'UTF-8'}','{$id_lang|escape:'html':'UTF-8'}');" rel="2">{l s='Show more reviews' mod='steavisgarantis'}</a>
                </div>
            {/if}
        </div>
    </div>
{if $showStructured && $structuredFormat == "microdata"}
</div>
{/if}
</div>
<style>{literal}
.bar1 {animation-duration: 1s;  animation-name: newHeight1;  animation-iteration-count: 1;} @keyframes newHeight1 { from {height: 0%} to {height: {/literal}{$ratingValues['percent1']|escape:'htmlall':'UTF-8'}{literal}%} }
.bar2 {animation-duration: 1s;  animation-name: newHeight2;  animation-iteration-count: 1;} @keyframes newHeight2 { from {height: 0%} to {height: {/literal}{$ratingValues['percent2']|escape:'htmlall':'UTF-8'}{literal}%} }
.bar3 {animation-duration: 1s;  animation-name: newHeight3;  animation-iteration-count: 1;} @keyframes newHeight3 { from {height: 0%} to {height: {/literal}{$ratingValues['percent3']|escape:'htmlall':'UTF-8'}{literal}%} }
.bar4 {animation-duration: 1s;  animation-name: newHeight4;  animation-iteration-count: 1;} @keyframes newHeight4 { from {height: 0%} to {height: {/literal}{$ratingValues['percent4']|escape:'htmlall':'UTF-8'}{literal}%} }
.bar5 {animation-duration: 1s;  animation-name: newHeight5;  animation-iteration-count: 1;} @keyframes newHeight5 { from {height: 0%} to {height: {/literal}{$ratingValues['percent5']|escape:'htmlall':'UTF-8'}{literal}%} }
{/literal}
</style>
<script type="text/javascript">
    var reviewTabStr="{$reviewTabStr|escape:'htmlall':'UTF-8'}";
    var maxReviewsPage="{$maxReviewsPage|escape:'htmlall':'UTF-8'}";
</script>
<br><br>