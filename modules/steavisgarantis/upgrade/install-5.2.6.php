<?php
/**
 * File: /upgrade/upgrade-5.2.6.php
 */
 
if (!defined('_PS_VERSION_')) {
    exit;
}

//Adds translated reviews support
function upgrade_module_5_2_6($module) {
    //Add translated column (defaut 0 because DB not supposed to have translated reviews at this step
    return Db::getInstance()->execute("
    
        CREATE TABLE IF NOT EXISTS `" . _DB_PREFIX_ . "steavisgarantis_custom_answers` (
                      `id` bigint(20) AUTO_INCREMENT,
                      `id_product_avisg` varchar(38) NOT NULL,
                      `id_question` bigint(20) NOT NULL,
                      `question_label` varchar(64) NOT NULL,
                      `answer` varchar(500) NOT NULL,
                      `unit` varchar(32) DEFAULT NULL,
                      `date_add` datetime DEFAULT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
        
        ALTER TABLE "._DB_PREFIX_."steavisgarantis_custom_answers ADD INDEX( `id_product_avisg`);
        ALTER TABLE "._DB_PREFIX_."steavisgarantis_custom_answers ADD INDEX( `id_question`);
        ALTER TABLE "._DB_PREFIX_."steavisgarantis_custom_answers ADD INDEX( `question_label`);
        ");
}