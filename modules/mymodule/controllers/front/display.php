<?php
class mymoduledisplayModuleFrontController extends ModuleFrontController
{
    //funcion initContent
    public function initContent()
    {
        //Lamamos al metodo initContent de la clase principal
        parent::initContent();
        //Y ahora llama al setTemplate que es el metodo que se encarga
        //de incrustar la plantilla de una linea en una pagina completa
        //tiene que compartir el msmo nombre que la plantilla(en este caso el nombre es display)
        $this->setTemplate('module:mymodule/views/templates/front/display.tpl');
    }
}
