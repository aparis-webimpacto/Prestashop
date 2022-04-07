<?php
/**
 * File: /upgrade/upgrade-5.2.4.php
 */
 
if (!defined('_PS_VERSION_')) {
    exit;
}

//Adds translated reviews support
function upgrade_module_5_2_4($module) {
    //Add translated column (defaut 0 because DB not supposed to have translated reviews at this step
    return Db::getInstance()->execute("
        ALTER TABLE "._DB_PREFIX_."steavisgarantis_reviews ADD `translated` INT(1) NOT NULL DEFAULT '0' AFTER `id_lang`;
        ALTER TABLE "._DB_PREFIX_."steavisgarantis_reviews ADD `source_lang` VARCHAR(2) NOT NULL DEFAULT '' AFTER `translated`;
        ALTER TABLE "._DB_PREFIX_."steavisgarantis_reviews ADD INDEX( `translated`);
        ALTER TABLE "._DB_PREFIX_."steavisgarantis_reviews ADD INDEX( `source_lang`);
        ALTER TABLE "._DB_PREFIX_."steavisgarantis_reviews ADD INDEX( `product_id`);
        ALTER TABLE "._DB_PREFIX_."steavisgarantis_reviews ADD INDEX( `id_product_avisg`);
        ALTER TABLE "._DB_PREFIX_."steavisgarantis_reviews ADD INDEX( `rate`);
        ALTER TABLE "._DB_PREFIX_."steavisgarantis_reviews ADD INDEX( `date_time`);
        ALTER TABLE "._DB_PREFIX_."steavisgarantis_average_rating ADD INDEX( `id_product_avisg`);
        ALTER TABLE "._DB_PREFIX_."steavisgarantis_average_rating ADD INDEX( `product_id`);
        ALTER TABLE "._DB_PREFIX_."steavisgarantis_average_rating ADD INDEX( `rate`);
        ALTER TABLE "._DB_PREFIX_."steavisgarantis_average_rating ADD INDEX( `reviews_nb`);
        ALTER TABLE "._DB_PREFIX_."steavisgarantis_average_rating ADD INDEX( `id_lang`);
        ");
}