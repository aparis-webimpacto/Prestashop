<?php
include 'mymodule.php';
if (!defined('_PS_VERSION_')) {
    exit;
}
  
function upgrade_module_1_1_0($module) {
    // $textoNuevo="Actualizacion 1.1";
    // hookDisplayLeftColumn($params)->$this->context->smarty->assign([
    //     'my_module_message2' => $this->l($textoNuevo)
    //  ]);

    // echo "HOLA VERSION 1.1";
    return true; 
}