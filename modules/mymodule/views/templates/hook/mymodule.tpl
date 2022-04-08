<!-- Block mymodule
Es codigo html excepto por algunas cosas:



{l s='xxx' mod='yyy'} es un metodo especifico de prestashop
que permite registrar la cadena en el panel de traduccion del modulo.
el parametro s es la cadena y mod debe contener el id del modulo('mymodule' en este caso)
-->
<div id="mymodule_block_home" class="block">
  <h4>{l s='Welcome!' mod='mymodule'}</h4>
  <div class="block_content">
    <p>Hello,
           {if isset($my_module_name) && $my_module_name}
               {$my_module_name}
           {else}
               World
           {/if}
           !
    </p>
    <ul>
      <li><a href="{$my_module_link}" title="Click this link"></a></li>
    </ul>
    {$my_module_message}
    <p>La url actual</p>
    {$urls.current_url}

  </div>
</div>
<!-- /Block mymodule -->
