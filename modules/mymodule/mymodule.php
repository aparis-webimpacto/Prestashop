<?php
// El archivo principal debe comenzar con:
/*Esto verifica la presencia de una constante de PrestaShop siempre existente (su número de versión) y,si no existe, detiene la carga del módulo. 
 El único propósito de esto es evitar que los visitantes maliciosos carguen este archivo directamente.*/
if (!defined('_PS_VERSION_')) {
    exit;
}

class MyModule extends Module
{
    //Constructor
    public function __construct()
    {
        //Esta sección asigna un puñado de atributos 
        //a la instancia de clase ( $this):

        /* El nameatributo sirve como identificador interno (nombre técnico). El valor DEBE ser el mismo que la carpeta del módulo y el archivo
         de clase principal. Solo se aceptan letras minúsculas y números. */
        $this->name = 'mymodule';
        /*  contiene la sección que contendrá este módulo en la sección Administrador de Módulos en el Back office (verlista de secciones 
        disponibles). Elegimos front_office_featuresporque nuestro módulo tendrá un impacto mayormente en el front-end. */
        $this->tab = 'front_office_features';
        /* Version del modulo */
        $this->version = '1.1.0';
        /* Nombre del creador del modulo */
        $this->author = 'Alba Paris';
        /* Esta sección trata la relación con el módulo y su entorno (es decir, PrestaShop): */

        /*Indica si cargar la clase del módulo al mostrar la página “Módulos” en el back office.Si se establece en 0, el módulo no se cargará y,
          por lo tanto, gastará menos recursos. Si su módulo necesita mostrar un mensaje de advertencia en la página "Módulos", debe establecer este atributo en 1. */
        $this->need_instance = 0;
        /* El ps_versions_compliancyatributo indica con qué versión de PrestaShop es compatible este módulo.*/
        $this->ps_versions_compliancy = [
            'min' => '1.6',
            'max' => '1.7.99',
        ];
        /* indica que los archivos de plantilla del módulo se han creado teniendo en cuenta las herramientas de arranque de PrestaShop 1.6. */
        $this->bootstrap = true;


        /* llamamos al método constructor desde la clase principal de PHP */
        parent::__construct();
        /* La siguiente sección trata sobre las cadenas de texto, que están encapsuladas en el método de traducción de PrestaShop */
        //Estas lineas asignan:
        //Un nombre para el modulo
        $this->displayName = $this->l('My module');
        // $this->displayName = $this->trans('My module', [], 'Modules.Mymodule.Mymodule');
        //Una descripción del módulo
        $this->description = $this->l('Este es el primer modulo realizado por Alba Paris.');
        //Un mensaje preguntando al administrador si realmente quiere desinstalar el módulo. 
        $this->confirmUninstall = $this->l('Are you sure you want to uninstall?');
        //Una advertencia de que el módulo aún no tiene MYMODULE_NAME establecido su valor de base de datos
        //'MY_MODULE_NAME'=it's a variable stored in database
        //Los dos puntos (::) son para acceder a la funcion get de la clase Configuration.
        if (!Configuration::get('MYMODULE_NAME')) {
            $this->warning = $this->l('No name provided');
        }
    }
    //El install es un metodo de la clase modulo
    //devuelve truesi el módulo está correctamente instalado o false si no
    public function install()
    {
        /* En muchos casos, su código necesitará saber si el modo multitienda 
        está habilitado y, en caso afirmativo, cuál es el contexto actual de la tienda.
        El objeto Tienda le ayuda a trabajar con varias tiendas.
        Shop::isFeatureActive()=Esto simplemente verifica si la función multitienda está activa o no, y si al menos dos tiendas están actualmente activadas.
        Shop::setContext(Shop::CONTEXT_ALL): Esto cambia el contexto para aplicar los próximos cambios a todas las tiendas existentes en lugar de solo a la tienda actual.*/

        if (Shop::isFeatureActive()) {
            Shop::setContext(Shop::CONTEXT_ALL);
        }
    
           /* Como puede ver, lo hacemos para que el módulo quede enganchado a los ganchos "displayLeftColumn" y " ". actionFrontControllerSetMedia */
           return parent::install() &&
           $this->registerHook('displayLeftColumn') &&
           $this->registerHook('actionFrontControllerSetMedia') &&
           Configuration::updateValue('MYMODULE_NAME', 'my friend');
    }
    //sigue la misma lógica que install()
    public function uninstall()
    {
        //elimine los datos agregados a la base de datos durante la instalación(MYMODULE_NAMEajuste de configuración)
        return (
            parent::uninstall() 
            && Configuration::deleteByName('MYMODULE_NAME')
        );
    }
    //Agregar una página de configuración
    /*getContent()llama al método cuando se carga la página de configuración. Por lo tanto, lo usamos para mostrar 
    un formulario y manejar la acción detrás de ese formulario. */
    public function getContent()
    {
        //Variable para la salida de errores
        $output = '';
        /*método específico de PrestaShop que comprueba si se ha enviado un formulario determinado.
        En este caso, si aún no se ha enviado el formulario de configuración, if()se salta todo el 
        bloque y PrestaShop solo utilizará la última línea*/
        if (Tools::isSubmit('submit' . $this->name)) {
            //recuperamos el valor del MYMODULE_CONFIG campo de formulario y lo parseamos a string
            $configValue = (string) Tools::getValue('MYMODULE_CONFIG');
            //Si configvalue esta vacio o no esta validado(es decir, usa caracteres especiales) nos salta un error
            if (empty($configValue) || !Validate::isGenericName($configValue)) {
                $output = $this->displayError($this->l('Invalid Configuration value'));
                //Si está bien
            } else {
                //Se actualiza el valor de la base de datos
                Configuration::updateValue('MYMODULE_CONFIG', $configValue);
                //Y se imprime el mensaje de vonfirmacion
                $output = $this->displayConfirmation($this->l('Settings updated'));
            }
        }
        //Devuelve el mensaje y llama al metodo del formulario
        return $output . $this->displayForm();
    }

        //Metodo del formulario
    public function displayForm(){
        //Creamos la variable form
        $form = [
            //Dentro creamos un form, con tres secciones(legend,input y submit)
            'form' => [
                'legend' => [
                    'title' => $this->l('Settings'),
                ],
                'input' => [
                    [
                        'type' => 'text',
                        'label' => $this->l('Configuration value'),
                        'name' => 'MYMODULE_CONFIG',
                        'size' => 20,
                        'required' => true,
                    ],
                ],
                'submit' => [
                    'title' => $this->l('Save'),
                    'class' => 'btn btn-default pull-right',
                ],
            ],
        ];
        // Para generar el HTML a partir de la definición de fields_form debemos realizar estos pasos
        //Instanciamos la clase formHelper
        $helper = new HelperForm();
        //toma la mesa del módulo/Define el atributo id del formulario
        $helper->table = $this->table;
        //requiere el nombre del módulo.
        $helper->name_controller = $this->name;
        //es el token CSRF de Back office que se agregará a la acción del formulario.
        //getAdminTokenLite()nos ayuda a generar uno.
        //El token de seguridad del formulario. debe estar a la atura con el controlador seleccionado en current_index.
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        //Define la URL de la acción del formulario/espera la URL a la que se enviará el formulario. Usamos la misma URL que el formulario.
        $helper->currentIndex = AdminController::$currentIndex . '&' . http_build_query(['configure' => $this->name]);
        //es el nombre de la entrada oculta enviada con el formulario, que luego usaremos para saber si el formulario se ha enviado.
        $helper->submit_action = 'submit' . $this->name;
        //requiere la identificación de idioma predeterminada de la tienda, en caso de que usemos funciones de varios idiomas.
        $helper->default_form_language = (int) Configuration::get('PS_LANG_DEFAULT');
        //se utiliza para rellenar los campos del formulario.
        $helper->fields_value['MYMODULE_CONFIG'] = Tools::getValue('MYMODULE_CONFIG', Configuration::get('MYMODULE_CONFIG'));
        //método se encarga de juntarlo todo y, como su nombre lo dice, genera el formulario que el usuario utilizará para configurar los ajustes del módulo.
        return $helper->generateForm([$form]);
    }
    /* hookDisplayLeftColumn(): enlazará el código en la columna izquierda; en nuestro caso, obtendrá la configuración 
    del módulo MYMODULE_NAME y mostrará el archivo de plantilla del módulo mymodule.tpl, que debe estar ubicado en la carpeta
     /views/templates/hook/ */
    public function hookDisplayLeftColumn($params)
    {
        /*Usamos el contexto para cambiar una variable Smarty
        El asign es un metodo de Smarty que se utiliza para asignar variables
        de plantilla durante la ejecucion de una plantilla.
        En este caso con el valor de MYMODULE_NAME
        */
        $this->context->smarty->assign([
            'my_module_name' => Configuration::get('MYMODULE_NAME'),
            'my_module_link' => $this->context->link->getModuleLink('mymodule', 'display'),
            'my_module_message' => $this->trans('You can change the message on line 174 of mymodule.php',[], 'Modules.Mymodule.Mymodule'),
        ]);
        //retorna la plantilla mymodule.tpl
        return $this->display(__FILE__, 'mymodule.tpl');
    }
    /*hookDisplayRightColumn(): simplemente hará lo mismo que hookDisplayLeftColumn(), pero para la columna de la derecha. */
    public function hookDisplayRightColumn($params)
    {
        return $this->hookDisplayLeftColumn($params);
    }
    /*hookActionFrontControllerSetMedia(): agregará un enlace al archivo CSS del /views/css/mymodule.cssmódulo y 
    al archivo JS del módulo, /views/js/mymodule.js
    El actionFrontControllerSetMediagancho no forma parte del encabezado visual, pero nos permite colocar activos 
    después del código en la <head>
    */
    public function hookActionFrontControllerSetMedia()
    {
        /*Para agregar un enlace a nuestro archivo CSS en la <head>etiqueta de la página, 
        usamos el registerStylesheet() y genera la etiqueta <link>*/
        $this->context->controller->registerStylesheet(
            'mymodule-style',
            $this->_path.'views/css/mymodule.css',
            [
                'media' => 'all',
                'priority' => 1000,
            ]
        );
        /*Para agregar nuestro script JS en la página, usamos el registerJavascript()método, que genera la <script>etiqueta correcta. */
        $this->context->controller->registerJavascript(
            'mymodule-javascript',
            $this->_path.'views/js/mymodule.js',
            [
                'position' => 'bottom',
                'priority' => 1000,
            ]
        );
    }

    public function isUsingNewTranslationSystem(){
        return true;
    }

}

?>