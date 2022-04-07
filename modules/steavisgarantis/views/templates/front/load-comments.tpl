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

{$j=0} 
{foreach from=$reviews item=singleReview} 
<li class="bgGrey{$j % 2|escape:'htmlall':'UTF-8'}">
    <div class="author" ><img class="authorAvatar" width="24px" height="24px" src="{$modules_dir|escape:'htmlall':'UTF-8'}steavisgarantis/views/img/ico_user.png" /><span>{$singleReview['ag_reviewer_name']|escape:'htmlall':'UTF-8'}</span>
        {if $singleReview['translated']}
            <img class="agFlag" src="{$modules_dir|escape:'htmlall':'UTF-8'}steavisgarantis/views/img/flag-{$singleReview['source_lang']|escape:'htmlall':'UTF-8'}.png" />
        {/if}
        <br><span class="time"><span class="published">{l s='Published' mod='steavisgarantis'} {$singleReview['date_time']|escape:'htmlall':'UTF-8'}</span>{if $singleReview['order_date']} ({l s='Order date: ' mod='steavisgarantis'}{$singleReview['order_date']|escape:'htmlall':'UTF-8'}){/if}</span></div>
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
    
    <div class="reviewTxt">
        <div class="steavisgarantisStar"><span></span><span class="note" style="width:{20 * $singleReview['rate']|escape:'htmlall':'UTF-8'}%"></span></div>
        <span class="metaHide">{$singleReview['rate']|escape:'htmlall':'UTF-8'}</span>
        <p class="">{$singleReview['review']|escape:'htmlall':'UTF-8'}{if $singleReview['translated']} <span style='font-style:italic;'>({l s='Translated review' mod='steavisgarantis'})</span>{/if}</p>
        {if $singleReview['answer_text']}
            <div class="reponse"><span><img src="{$modules_dir|escape:'htmlall':'UTF-8'}steavisgarantis/views/img/ico_pen.png" height="12">{l s='Merchant\'s answer' mod='steavisgarantis'}</span>
            <p>{$singleReview['answer_text']|escape:'htmlall':'UTF-8'}</p></div>
        {/if} 
    </div>
</li>
{$j = $j + 1} 
{/foreach} 
 


