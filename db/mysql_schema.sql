-- MySQL dump 10.13  Distrib 5.6.23, for osx10.10 (x86_64)
--
-- Host: localhost    Database: bbt_development
-- ------------------------------------------------------
-- Server version	5.6.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ec_address`
--

DROP TABLE IF EXISTS `ec_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_address` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique idenifier for the ec_address table.',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Ensures that only the user who creates the entry can access the address information.',
  `first_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'First name for this address.',
  `last_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'Last name for this address.',
  `address_line_1` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'First line address value for this address.',
  `address_line_2` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '' COMMENT 'Second line address value for this address.',
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'City for this address.',
  `state` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'State for this address.',
  `zip` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'Zip code for this address.',
  `country` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'Country for this address.',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'Phone number relating to this address',
  `company_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Company name relating to this address.',
  PRIMARY KEY (`address_id`),
  UNIQUE KEY `address_id` (`address_id`)
) ENGINE=MyISAM AUTO_INCREMENT=877 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=88;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_category`
--

DROP TABLE IF EXISTS `ec_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for the ec_category table.',
  `category_name` varchar(512) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'Name/Description of the category of products. Used on the administrative side of the store.',
  `post_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Post ID to connect the product to the WordPress custom post type structure.',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `CategoryID` (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=32;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_categoryitem`
--

DROP TABLE IF EXISTS `ec_categoryitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_categoryitem` (
  `categoryitem_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for the ec_categoryitem table.',
  `category_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the ec_categoryitem table to the ec_category table.',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the ec_categoryitem table to the ec_product table.',
  PRIMARY KEY (`categoryitem_id`),
  UNIQUE KEY `CategoryItemID` (`categoryitem_id`)
) ENGINE=MyISAM AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=13 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_country`
--

DROP TABLE IF EXISTS `ec_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_country` (
  `id_cnt` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for the ec_country table.',
  `name_cnt` varchar(100) NOT NULL DEFAULT '' COMMENT 'Name of the country.',
  `iso2_cnt` char(2) NOT NULL DEFAULT '' COMMENT '2 digit country code.',
  `iso3_cnt` char(3) NOT NULL DEFAULT '' COMMENT '3 digit country code.',
  `sort_order` int(11) NOT NULL COMMENT 'User assigned order of countries for drop down menus.',
  `vat_rate_cnt` float(9,3) NOT NULL DEFAULT '0.000' COMMENT 'User assigned value for VAT based on purchaser shipping country.',
  PRIMARY KEY (`id_cnt`)
) ENGINE=MyISAM AUTO_INCREMENT=244 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=30;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_customfield`
--

DROP TABLE IF EXISTS `ec_customfield`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_customfield` (
  `customfield_id` int(11) NOT NULL AUTO_INCREMENT,
  `table_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `field_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `field_label` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`customfield_id`),
  UNIQUE KEY `customfield_id` (`customfield_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_customfielddata`
--

DROP TABLE IF EXISTS `ec_customfielddata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_customfielddata` (
  `customfielddata_id` int(11) NOT NULL AUTO_INCREMENT,
  `customfield_id` int(11) DEFAULT NULL,
  `table_id` int(11) NOT NULL,
  `data` blob NOT NULL,
  PRIMARY KEY (`customfielddata_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_dblog`
--

DROP TABLE IF EXISTS `ec_dblog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_dblog` (
  `dblog_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_dblog.',
  `entry_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'The date of the entry.',
  `entry_type` varchar(25) NOT NULL DEFAULT '' COMMENT 'The type of event that is being logged.',
  PRIMARY KEY (`dblog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=4096;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_download`
--

DROP TABLE IF EXISTS `ec_download`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_download` (
  `download_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'The unique identifier for ec_download.',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date this downloadable good was purchased and then created as a ec_download item.',
  `download_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of downloads to date.',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT 'The ec_order item this downloadable good relates to.',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT 'The product this downloadable good relates to.',
  `download_file_name` varchar(512) NOT NULL DEFAULT '' COMMENT 'The name of the file to download.',
  `is_amazon_download` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Turns the download location to Amazon S3 servers.',
  `amazon_key` varchar(1024) NOT NULL DEFAULT '' COMMENT 'The file name used on the Amazon S3 Server.',
  PRIMARY KEY (`download_id`),
  UNIQUE KEY `download_id` (`download_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=124;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_giftcard`
--

DROP TABLE IF EXISTS `ec_giftcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_giftcard` (
  `giftcard_id` varchar(20) NOT NULL DEFAULT '' COMMENT 'The unique identifier for the ec_giftcard table.',
  `amount` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Amount left on the gift card.',
  `message` text COMMENT 'Message displayed when a gift card is used.',
  PRIMARY KEY (`giftcard_id`),
  UNIQUE KEY `giftcard_id` (`giftcard_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=47;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_manufacturer`
--

DROP TABLE IF EXISTS `ec_manufacturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_manufacturer` (
  `manufacturer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_manufacturer.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name for a manufacturer.',
  `clicks` int(11) NOT NULL DEFAULT '0' COMMENT 'Count of the number of times this manufacturer has a product viewed.',
  `post_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Post ID to connect the product to the WordPress custom post type structure.',
  PRIMARY KEY (`manufacturer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=24;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_menulevel1`
--

DROP TABLE IF EXISTS `ec_menulevel1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_menulevel1` (
  `menulevel1_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_menulevel1.',
  `name` varchar(1024) NOT NULL,
  `order` int(11) NOT NULL DEFAULT '0' COMMENT 'User defined order of the ec_menulevel1 items.',
  `clicks` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of times this menu item has been clicked.',
  `seo_keywords` varchar(512) NOT NULL DEFAULT '',
  `seo_description` blob,
  `banner_image` varchar(512) NOT NULL DEFAULT '',
  `post_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Post ID to connect the product to the WordPress custom post type structure.',
  PRIMARY KEY (`menulevel1_id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=30;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_menulevel2`
--

DROP TABLE IF EXISTS `ec_menulevel2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_menulevel2` (
  `menulevel2_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_menulevel2.',
  `menulevel1_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the ec_menulevel2 table to the ec_menulevel1 table.',
  `name` varchar(1024) NOT NULL,
  `order` int(11) NOT NULL DEFAULT '0' COMMENT 'User defined order of the ec_menulevel2 items.',
  `clicks` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of times this menu item has been clicked.',
  `seo_keywords` varchar(512) NOT NULL DEFAULT '',
  `seo_description` blob,
  `banner_image` varchar(512) NOT NULL DEFAULT '',
  `post_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Post ID to connect the product to the WordPress custom post type structure.',
  PRIMARY KEY (`menulevel2_id`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=30;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_menulevel3`
--

DROP TABLE IF EXISTS `ec_menulevel3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_menulevel3` (
  `menulevel3_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_menulevel3.',
  `menulevel2_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates ec_menulevel3 to ec_menulevel2.',
  `name` varchar(1024) NOT NULL,
  `order` int(11) NOT NULL DEFAULT '0' COMMENT 'User defined order of the ec_menulevel3 items.',
  `clicks` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of times this menu item has been clicked.',
  `seo_keywords` varchar(512) NOT NULL DEFAULT '',
  `seo_description` blob,
  `banner_image` varchar(512) NOT NULL DEFAULT '',
  `post_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Post ID to connect the product to the WordPress custom post type structure.',
  PRIMARY KEY (`menulevel3_id`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=38;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_option`
--

DROP TABLE IF EXISTS `ec_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_option` (
  `option_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique ID for the ec_option table.',
  `option_name` varchar(128) NOT NULL DEFAULT '' COMMENT 'Name of the option set.',
  `option_label` varchar(128) NOT NULL DEFAULT '' COMMENT 'Label for option set, used in the display of the option set in a combo box.',
  `option_type` varchar(20) NOT NULL DEFAULT 'combo' COMMENT 'The type of input for the option.',
  `option_required` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Is this option required.',
  `option_error_text` varchar(128) NOT NULL DEFAULT '' COMMENT 'Text displayed when option required and no value selected.',
  PRIMARY KEY (`option_id`)
) ENGINE=MyISAM AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=40;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_option_to_product`
--

DROP TABLE IF EXISTS `ec_option_to_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_option_to_product` (
  `option_to_product_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this table.',
  `option_id` int(11) NOT NULL DEFAULT '0' COMMENT 'The option_id to connect to the ec_option table',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT 'The product_id to connect the ec_product table',
  `role_label` varchar(20) NOT NULL DEFAULT 'all' COMMENT 'The role label for this option',
  `option_order` int(11) NOT NULL DEFAULT '0' COMMENT 'The order value to order these options',
  PRIMARY KEY (`option_to_product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=206 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_optionitem`
--

DROP TABLE IF EXISTS `ec_optionitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_optionitem` (
  `optionitem_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Gives the ec_optionitem table a unique ID.',
  `option_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates ec_optionitem to ec_option using the option_id field.',
  `optionitem_name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Name of this optionitem.',
  `optionitem_price` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Price change value for an optionitem.',
  `optionitem_price_onetime` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Price change one-time addition to total price.',
  `optionitem_price_override` float(15,3) NOT NULL DEFAULT '-1.000' COMMENT 'Price change to override product price.',
  `optionitem_weight` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Weight change value for an optionitem.',
  `optionitem_weight_onetime` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Weight change one-time addition to total weight.',
  `optionitem_weight_override` float(15,3) NOT NULL DEFAULT '-1.000' COMMENT 'Weight change to override product weight.',
  `optionitem_order` int(11) NOT NULL DEFAULT '1' COMMENT 'Gives a user selected order of display for the optionitems.',
  `optionitem_icon` varchar(512) NOT NULL DEFAULT '' COMMENT 'Gives the optionitem an icon for displaying optionitem swatch sets.',
  `optionitem_initial_value` varchar(64) NOT NULL DEFAULT '' COMMENT 'For some options an initial value is useful.',
  `optionitem_model_number` varchar(128) NOT NULL DEFAULT '' COMMENT 'Model number extension that gets added to product model number if selected.',
  `optionitem_price_multiplier` int(11) NOT NULL DEFAULT '0' COMMENT 'This multiplies your unit price by the value here.',
  `optionitem_weight_multiplier` int(11) NOT NULL DEFAULT '0' COMMENT 'This multiplies your weight by the value here.',
  PRIMARY KEY (`optionitem_id`),
  UNIQUE KEY `unique_name_ova` (`option_id`,`optionitem_name`),
  KEY `idopt_ova` (`option_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3108 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=43;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_optionitemimage`
--

DROP TABLE IF EXISTS `ec_optionitemimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_optionitemimage` (
  `optionitemimage_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_optionitemimage.',
  `optionitem_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the ec_optionitemimage to a ec_optionitem.',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the ec_optionitemimage to a ec_product.',
  `image1` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'Filename referencing the first image.',
  `image2` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'Filename referencing the second image.',
  `image3` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'Filename referencing the third image.',
  `image4` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'Filename referencing the fourth image.',
  `image5` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'Filename referencing the fifth image.',
  PRIMARY KEY (`optionitemimage_id`)
) ENGINE=MyISAM AUTO_INCREMENT=184 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=85;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_optionitemquantity`
--

DROP TABLE IF EXISTS `ec_optionitemquantity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_optionitemquantity` (
  `optionitemquantity_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_optionitemquantity.',
  `product_id` int(17) NOT NULL DEFAULT '0' COMMENT 'Relates this ec_optionitemquantity to a ec_product.',
  `optionitem_id_1` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected optionitem in ec_optionitemquantity to the cooresponding ec_optionitem.',
  `optionitem_id_2` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected optionitem in ec_optionitemquantity to the cooresponding ec_optionitem.',
  `optionitem_id_3` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected optionitem in ec_optionitemquantity to the cooresponding ec_optionitem.',
  `optionitem_id_4` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected optionitem in ec_optionitemquantity to the cooresponding ec_optionitem.',
  `optionitem_id_5` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected optionitem in ec_optionitemquantity to the cooresponding ec_optionitem.',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT 'The amount left in stock for this group of ids.',
  PRIMARY KEY (`optionitemquantity_id`),
  UNIQUE KEY `OptionItemQuantityID` (`optionitemquantity_id`)
) ENGINE=MyISAM AUTO_INCREMENT=30922 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=23;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_order`
--

DROP TABLE IF EXISTS `ec_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_order.',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the ec_order to a ec_user.',
  `user_email` varchar(255) NOT NULL DEFAULT '' COMMENT 'The contact email for this order.',
  `user_level` varchar(255) NOT NULL DEFAULT 'shopper',
  `last_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'The last time this order was updated.',
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The timestamp for when the order was placed.',
  `orderstatus_id` int(11) NOT NULL DEFAULT '5' COMMENT 'The orderstatus.status_id reference to the status of the order.',
  `order_weight` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'The total weight of the order.',
  `sub_total` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'The order sub total.',
  `tax_total` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'The order tax total.',
  `shipping_total` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'The order shipping total.',
  `discount_total` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'The order discount total.',
  `vat_total` float(15,3) NOT NULL DEFAULT '0.000',
  `duty_total` float(15,3) NOT NULL DEFAULT '0.000',
  `grand_total` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'The order grand total.',
  `promo_code` varchar(255) NOT NULL DEFAULT '' COMMENT 'If a promo code was used, enter it here.',
  `giftcard_id` varchar(20) NOT NULL DEFAULT '' COMMENT 'If a gift card was used, put the giftcard_id in this field.',
  `use_expedited_shipping` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, the customer paid for expedited shipping.',
  `shipping_method` varchar(255) NOT NULL DEFAULT '' COMMENT 'The shipping method used for this order.',
  `shipping_carrier` varchar(64) NOT NULL DEFAULT '' COMMENT 'The name of the shipping carrier.',
  `tracking_number` varchar(100) NOT NULL DEFAULT '' COMMENT 'Tracking number for this order if it has been shipped.',
  `billing_first_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The first name for the billing address.',
  `billing_last_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The last name for the billing address.',
  `billing_address_line_1` varchar(255) NOT NULL DEFAULT '' COMMENT 'The first address line for the billing address.',
  `billing_address_line_2` varchar(255) NOT NULL DEFAULT '' COMMENT 'The second address line for the billing address.',
  `billing_city` varchar(255) NOT NULL DEFAULT '' COMMENT 'The city for the billing address.',
  `billing_state` varchar(255) NOT NULL DEFAULT '' COMMENT 'The state for the billing address.',
  `billing_country` varchar(255) NOT NULL DEFAULT '' COMMENT 'The country for the billing address.',
  `billing_zip` varchar(32) NOT NULL DEFAULT '' COMMENT 'The zip code for the billing address.',
  `billing_phone` varchar(32) NOT NULL DEFAULT '' COMMENT 'The phone number for the billing address.',
  `shipping_first_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The first name for the shipping address.',
  `shipping_last_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The last name for the shipping address.',
  `shipping_address_line_1` varchar(255) NOT NULL DEFAULT '' COMMENT 'The first address line for the shipping address.',
  `shipping_address_line_2` varchar(255) NOT NULL DEFAULT '' COMMENT 'The second address line for the shipping address.',
  `shipping_city` varchar(255) NOT NULL DEFAULT '' COMMENT 'The city for the shipping address.',
  `shipping_state` varchar(255) NOT NULL DEFAULT '' COMMENT 'The state for the shipping address.',
  `shipping_country` varchar(255) NOT NULL DEFAULT '' COMMENT 'The country for the shipping address.',
  `shipping_zip` varchar(32) NOT NULL DEFAULT '' COMMENT 'The zip code for the shipping address.',
  `shipping_phone` varchar(32) NOT NULL DEFAULT '' COMMENT 'The phone number for the shipping address.',
  `payment_method` varchar(64) NOT NULL DEFAULT '' COMMENT 'The method of payment for this order.',
  `paypal_email_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'The paypal email id.',
  `paypal_transaction_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'The paypal transaction id.',
  `paypal_payer_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'The paypal payer id.',
  `order_viewed` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, the order has been viewed by the administration console.',
  `order_notes` text COMMENT 'Notes only available on the backend.',
  `order_customer_notes` blob,
  `txn_id` varchar(50) NOT NULL DEFAULT '' COMMENT 'Quickbooks Specific TXN ID.',
  `edit_sequence` varchar(50) NOT NULL DEFAULT '' COMMENT 'Quickbooks Specific Edit Sequence.',
  `creditcard_digits` varchar(4) NOT NULL DEFAULT '' COMMENT 'If credit card checkout is used, saves the last four digits here.',
  `fraktjakt_order_id` varchar(20) NOT NULL DEFAULT '' COMMENT 'Order ID for the Fraktjakt shipment.',
  `fraktjakt_shipment_id` varchar(20) DEFAULT '' COMMENT 'Shipment ID for the Fraktjakt shipment.',
  `stripe_charge_id` varchar(128) NOT NULL DEFAULT '' COMMENT 'Stripe Charge ID if Stripe used.',
  `subscription_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Subscription ID from the ec_subscription table if order was a subscription order.',
  `refund_total` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Amount of the order that has been refunded.',
  `nets_transaction_id` varchar(128) NOT NULL DEFAULT '' COMMENT 'Nets Transaction ID if Nets used.',
  `order_gateway` varchar(64) NOT NULL DEFAULT '' COMMENT 'The gateway used during checkout ONLY IF a refund functionality is available.',
  `affirm_charge_id` varchar(100) NOT NULL DEFAULT '' COMMENT 'The Affirm Charge ID added during checkout',
  `billing_company_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Billing company name for this order if used.',
  `shipping_company_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Shipping company name for this order if used.',
  `guest_key` varchar(124) NOT NULL DEFAULT '' COMMENT 'Used for guest checkouts to allow a guest to view an order.',
  `agreed_to_terms` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'This value is used to verify the user agreed to your terms and conditions during checkout.',
  `order_ip_address` varchar(125) NOT NULL DEFAULT '' COMMENT 'The IP Address of the user during checkout, for evidence later if necessary.',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_id` (`order_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2327 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=225;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_order_option`
--

DROP TABLE IF EXISTS `ec_order_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_order_option` (
  `order_option_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this table.',
  `orderdetail_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Referece to the ec_orderdetail table.',
  `option_name` varchar(128) NOT NULL DEFAULT '' COMMENT 'Name of the option, e.g. Shirt Color.',
  `optionitem_name` varchar(128) NOT NULL DEFAULT '' COMMENT 'Name of the optionitem, e.g. Large. Only used for a grid option.',
  `option_type` varchar(20) NOT NULL DEFAULT 'combo' COMMENT 'The type of option set, e.g. combo.',
  `option_value` text NOT NULL COMMENT 'The value of this selected option.',
  `option_price_change` varchar(20) NOT NULL DEFAULT '' COMMENT 'The display value for a price change on this option.',
  PRIMARY KEY (`order_option_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2014 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_orderdetail`
--

DROP TABLE IF EXISTS `ec_orderdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_orderdetail` (
  `orderdetail_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_orderdetail.',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the ec_orderdetail table to the ec_order table.',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the ec_orderdetail table to the ec_product table.',
  `title` varchar(255) DEFAULT NULL COMMENT 'The title of a product as specified at time of the order capture.',
  `model_number` varchar(255) NOT NULL COMMENT 'The model number of a product as specified and captured at time of order.',
  `order_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date the order was placed.',
  `unit_price` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Price of the product at the time of purchase.',
  `total_price` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Final price of this line item.',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of product purchased.',
  `image1` varchar(255) NOT NULL COMMENT 'The image 1 of the product at time of order capture.',
  `optionitem_name_1` varchar(128) NOT NULL DEFAULT '' COMMENT 'The optionitem name selected at time of purchase.',
  `optionitem_name_2` varchar(128) NOT NULL DEFAULT '' COMMENT 'The optionitem name selected at time of purchase.',
  `optionitem_name_3` varchar(128) NOT NULL DEFAULT '' COMMENT 'The optionitem name selected at time of purchase.',
  `optionitem_name_4` varchar(128) NOT NULL DEFAULT '' COMMENT 'The optionitem name selected at time of purchase.',
  `optionitem_name_5` varchar(128) NOT NULL DEFAULT '' COMMENT 'The optionitem name selected at time of purchase.',
  `optionitem_label_1` varchar(255) NOT NULL DEFAULT '' COMMENT 'Option Item 1 Label',
  `optionitem_label_2` varchar(255) NOT NULL DEFAULT '' COMMENT 'Option Item 2 Label',
  `optionitem_label_3` varchar(255) NOT NULL DEFAULT '' COMMENT 'Option Item 3 Label',
  `optionitem_label_4` varchar(255) NOT NULL DEFAULT '' COMMENT 'Option Item 4 Label',
  `optionitem_label_5` varchar(255) NOT NULL DEFAULT '' COMMENT 'Option Item 5 Label',
  `optionitem_price_1` float(15,3) NOT NULL DEFAULT '0.000',
  `optionitem_price_2` float(15,3) NOT NULL DEFAULT '0.000',
  `optionitem_price_3` float(15,3) NOT NULL DEFAULT '0.000',
  `optionitem_price_4` float(15,3) NOT NULL DEFAULT '0.000',
  `optionitem_price_5` float(15,3) NOT NULL DEFAULT '0.000',
  `use_advanced_optionset` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Used for display purposes to notify if this item uses advanced option sets.',
  `giftcard_id` varchar(20) NOT NULL DEFAULT '' COMMENT 'Relates the ec_orderdetail item to a ec_giftcard item if a gift card was ordered.',
  `shipper_id` int(11) DEFAULT '0',
  `shipper_first_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'First name of the shipper.',
  `shipper_last_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Last name of the shipper.',
  `gift_card_message` text COMMENT 'User entered gift card message.',
  `gift_card_from_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'User entered name that a gift card is from.',
  `gift_card_to_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'User entered name that a gift card is to.',
  `is_download` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Quick reference to if this sale was a downloadable good.',
  `is_giftcard` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Quick reference to if this sale was a gift card.',
  `is_taxable` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Quick reference to if this product is taxable.',
  `download_file_name` varchar(510) NOT NULL DEFAULT '' COMMENT 'Location of a downloadable item at time of purchase. This value allows for versioning and purchasing different versions.',
  `download_key` varchar(510) DEFAULT '' COMMENT 'The key of the downloadable good purchased.',
  `maximum_downloads_allowed` int(11) NOT NULL DEFAULT '0',
  `download_timelimit_seconds` int(11) DEFAULT '0',
  `is_amazon_download` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Turns the download location to Amazon S3 servers.',
  `amazon_key` varchar(1024) NOT NULL DEFAULT '' COMMENT 'The file name used on the Amazon S3 Server.',
  `is_deconetwork` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'This tells the system that it is a DecoNetwork product and changes the display type accordingly.',
  `deconetwork_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'The unique id for this item provided by the DecoNetwork',
  `deconetwork_name` varchar(512) NOT NULL DEFAULT '' COMMENT 'The name provided by the DecoNetwork.',
  `deconetwork_product_code` varchar(64) NOT NULL DEFAULT '' COMMENT 'The product code provided by the DecoNetwork.',
  `deconetwork_options` varchar(512) NOT NULL DEFAULT '' COMMENT 'The options selected by the customer on the DecoNetwork site.',
  `deconetwork_color_code` varchar(64) NOT NULL DEFAULT '' COMMENT 'The color code of the selected shirt provided by the DecoNetwork.',
  `deconetwork_product_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'The product id on the DecoNetwork.',
  `deconetwork_image_link` varchar(512) NOT NULL DEFAULT '' COMMENT 'The link to the image on the DecoNetwork.',
  `gift_card_email` varchar(512) NOT NULL DEFAULT '' COMMENT 'The gift card email is needed.',
  PRIMARY KEY (`orderdetail_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1935 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=130;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_orderstatus`
--

DROP TABLE IF EXISTS `ec_orderstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_orderstatus` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The status_id is used by gateways to set easycart order status.',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Holds various order status fields that are acceptable',
  `is_approved` tinyint(1) DEFAULT '0' COMMENT 'If 1, then this status is a recognized approved order status for downloads and giftcard type purchases.',
  PRIMARY KEY (`status_id`),
  UNIQUE KEY `status_id` (`status_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=32;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_pageoption`
--

DROP TABLE IF EXISTS `ec_pageoption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_pageoption` (
  `pageoption_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_pageoption',
  `post_id` int(11) NOT NULL DEFAULT '0' COMMENT 'The post id for this WordPress page',
  `option_type` varchar(155) NOT NULL DEFAULT '' COMMENT 'The key for the pageoption.',
  `option_value` text NOT NULL COMMENT 'The value for the pageoption',
  PRIMARY KEY (`pageoption_id`),
  UNIQUE KEY `pageoption_id` (`pageoption_id`)
) ENGINE=MyISAM AUTO_INCREMENT=122 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_perpage`
--

DROP TABLE IF EXISTS `ec_perpage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_perpage` (
  `perpage_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_perpage.',
  `perpage` int(11) NOT NULL DEFAULT '0' COMMENT 'The value of this ec_perpage item.',
  PRIMARY KEY (`perpage_id`),
  UNIQUE KEY `perpageid` (`perpage_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=9 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_pricepoint`
--

DROP TABLE IF EXISTS `ec_pricepoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_pricepoint` (
  `pricepoint_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_pricepoint.',
  `is_less_than` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, item is a less than type price point.',
  `is_greater_than` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'if selected, item is a greater than type price point.',
  `low_point` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'If is_greater_than, low_point is the value used, but if is a between value type then it is the low end of the range.',
  `high_point` float(15,3) DEFAULT '0.000' COMMENT 'If is_less_than, high_point is the value used, but if is a between value type then it is the high end of the range.',
  `order` int(11) NOT NULL DEFAULT '0' COMMENT 'User defined order of ec_pricepoint.',
  PRIMARY KEY (`pricepoint_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=19 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_pricetier`
--

DROP TABLE IF EXISTS `ec_pricetier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_pricetier` (
  `pricetier_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_pricetier.',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the ec_pricetier to an ec_product.',
  `price` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'The price used when this tier is active.',
  `quantity` int(11) NOT NULL DEFAULT '10' COMMENT 'The quantity required in the cart to activate the new price.',
  PRIMARY KEY (`pricetier_id`),
  UNIQUE KEY `PriceTierID` (`pricetier_id`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=17 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_product`
--

DROP TABLE IF EXISTS `ec_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for the ec_product table.',
  `model_number` varchar(255) NOT NULL DEFAULT '' COMMENT 'Model number used for SEO and display purposes to identify a product by a meaningful term.',
  `post_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Post ID to connect the product to the WordPress custom post type structure.',
  `activate_in_store` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Activate this product for display in the store. Used to allow admin to create a product and perfect before displaying.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Title of the product.',
  `description` text COMMENT 'Long description for the product.',
  `specifications` text COMMENT 'Specifications for the product.',
  `price` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Price of the product.',
  `list_price` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Previous price, used to display a simple guaranteed discount (e.g. used to be 30.00, now 20.00).',
  `vat_rate` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'VAT rate for this product, used in store calculations.',
  `handling_price` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'This price represents an extra handling charge  added to the shipping.',
  `stock_quantity` int(7) NOT NULL DEFAULT '0' COMMENT 'Simple stock quantity control, used to check overall stock total.',
  `weight` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Weight for the product.',
  `seo_description` text COMMENT 'SEO description for the product. Should be short and used in the META-DATA.',
  `seo_keywords` varchar(255) NOT NULL DEFAULT '' COMMENT 'SEO keywords for the product. Used in the META-DATA.',
  `use_specifications` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, this product should display the specifications section.',
  `use_customer_reviews` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, this product should display and allow for customer reviews.',
  `manufacturer_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Used to connect the product to the cooresponding manufacturer.',
  `download_file_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'File name for a downloadable product.',
  `image1` varchar(255) NOT NULL DEFAULT '' COMMENT 'Image 1 used for a basic product.',
  `image2` varchar(255) NOT NULL DEFAULT '' COMMENT 'Image 2 used for a basic product.',
  `image3` varchar(255) NOT NULL DEFAULT '' COMMENT 'Image 3 used for a basic product.',
  `image4` varchar(255) NOT NULL DEFAULT '' COMMENT 'Image 4 used for a basic product.',
  `image5` varchar(255) NOT NULL DEFAULT '' COMMENT 'Image 5 used for a basic product.',
  `option_id_1` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected option choice to ec_option.',
  `option_id_2` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected option choice to ec_option.',
  `option_id_3` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected option choice to ec_option.',
  `option_id_4` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected option choice to ec_option.',
  `option_id_5` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected option choice to ec_option.',
  `use_advanced_optionset` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If true, uses the advanced, unlimited option set type.',
  `menulevel1_id_1` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the product to a menu set.',
  `menulevel1_id_2` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the product to a menu set.',
  `menulevel1_id_3` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the product to a menu set.',
  `menulevel2_id_1` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the product to a menu set.',
  `menulevel2_id_2` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the product to a menu set.',
  `menulevel2_id_3` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the product to a menu set.',
  `menulevel3_id_1` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the product to a menu set.',
  `menulevel3_id_2` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the product to a menu set.',
  `menulevel3_id_3` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the product to a menu set.',
  `featured_product_id_1` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates a featured product to a product using the product_id.',
  `featured_product_id_2` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates a featured product to a product using the product_id.',
  `featured_product_id_3` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates a featured product to a product using the product_id.',
  `featured_product_id_4` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates a featured product to a product using the product_id.',
  `is_giftcard` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, treat this product as a gift card item.',
  `is_download` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, treat this product as a downloadable good.',
  `is_donation` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, treat as a donation product.',
  `is_special` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, this product will be displayed in the specials widget.',
  `is_taxable` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Turn tax on/off for this product.',
  `added_to_db_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Gives the product a date that it was added to the DB.',
  `show_on_startup` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Show this product on the main store page.',
  `use_optionitem_images` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, images 1-5 of the product will be ignored and the relating optionitem images will be displayed.',
  `use_optionitem_quantity_tracking` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, product will require a quantity entered for each optionitem combination.',
  `views` int(11) NOT NULL DEFAULT '0' COMMENT 'The number of times the product has been viewed.',
  `last_viewed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'The last time this product has been viewed.',
  `show_stock_quantity` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'If selected, quantity tracking for overall product is available and stock quantity visible on product details page.',
  `maximum_downloads_allowed` int(11) NOT NULL DEFAULT '0',
  `download_timelimit_seconds` int(11) NOT NULL DEFAULT '0',
  `list_id` varchar(50) NOT NULL DEFAULT '' COMMENT 'Quickbooks Specific List ID.',
  `edit_sequence` varchar(55) NOT NULL DEFAULT '' COMMENT 'Quickbooks Specific Edit Sequence.',
  `is_subscription_item` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Makes this product a subscription product which is purchased individually.',
  `subscription_bill_length` int(11) NOT NULL DEFAULT '1' COMMENT 'Number of the period times to charge the customer, e.g. 3 paired with month is charge once every 3 months.',
  `subscription_bill_period` varchar(20) NOT NULL DEFAULT 'M' COMMENT 'The period of the subscription, valid values are: D, W, M, Y.',
  `width` double(15,3) NOT NULL DEFAULT '1.000' COMMENT 'Width of the product in the default shipping unit.',
  `height` double(15,3) NOT NULL DEFAULT '1.000' COMMENT 'Height of the product in the default shipping unit.',
  `length` double(15,3) NOT NULL DEFAULT '1.000' COMMENT 'Length of the product in the default shipping unit.',
  `trial_period_days` int(11) NOT NULL DEFAULT '0' COMMENT 'Length of subscription trial period in days.',
  `stripe_plan_added` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Has this subscription product been added to Stripe.',
  `subscription_plan_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Used to group the subscriptions in a membership plan used for upgrade.',
  `allow_multiple_subscription_purchases` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Should this item be able to be purchased multiple times.',
  `is_preorder` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Makes this product a preorder product, allowing for an authorization of a card without capturing at this time',
  `membership_page` varchar(512) NOT NULL DEFAULT '' COMMENT 'Optional link to a membership content page to be displayed after subscription purchased.',
  `min_purchase_quantity` int(11) NOT NULL DEFAULT '0' COMMENT 'Optional minimum amount required for during purchase.',
  `is_amazon_download` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Turns the download location to Amazon S3 servers.',
  `amazon_key` varchar(1024) NOT NULL DEFAULT '' COMMENT 'The file name used on the Amazon S3 Server.',
  `catalog_mode` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Turns catalog mode on for individual product',
  `catalog_mode_phrase` varchar(1024) DEFAULT NULL COMMENT 'Sets a phrase to appear instead of add to cart button',
  `inquiry_mode` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'turns inquiry mode on and replaces add to cart with link button',
  `inquiry_url` varchar(1024) DEFAULT NULL COMMENT 'inquiry url where button will take customer instead of add to cart',
  `is_deconetwork` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Makes this a DecoNetwork product, allowing for custom designed goods.',
  `deconetwork_mode` varchar(64) NOT NULL DEFAULT 'designer' COMMENT 'If using deconetwork, enter designer, blank, designer_predec, predec, design, or view_design as a value.',
  `deconetwork_product_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'If using deconetwork, this is the product id to send the customer to.',
  `deconetwork_size_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'If using deconetwork, this is the size id to force the product into by default, optional.',
  `deconetwork_color_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'If using deconetwork, this is the color id to force the product into by default, optional.',
  `deconetwork_design_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'If using deconetwork, this is the design id to force the product into by default, optional.',
  `short_description` varchar(2048) NOT NULL DEFAULT '' COMMENT 'Short description for the product.',
  `display_type` int(11) NOT NULL DEFAULT '1' COMMENT 'The display type selected for a given product.',
  `image_hover_type` int(11) NOT NULL DEFAULT '3' COMMENT 'The hover effect of a product image.',
  `tag_type` int(11) NOT NULL DEFAULT '0' COMMENT 'The type of optional tag applied to the product.',
  `tag_bg_color` varchar(20) NOT NULL DEFAULT '' COMMENT 'The optional bg color of a tag applied to the product.',
  `tag_text_color` varchar(20) NOT NULL DEFAULT '' COMMENT 'The optional text color of a tag applied to a product.',
  `tag_text` varchar(256) NOT NULL DEFAULT '' COMMENT 'The option text of a tag applied to a product.',
  `image_effect_type` varchar(20) NOT NULL DEFAULT 'none' COMMENT 'An optional border or shadow can be applied to a product.',
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `ProductID` (`product_id`),
  UNIQUE KEY `ModelNumber_2` (`model_number`),
  UNIQUE KEY `model_number` (`model_number`),
  UNIQUE KEY `model_number_2` (`model_number`),
  UNIQUE KEY `model_number_3` (`model_number`),
  UNIQUE KEY `model_number_4` (`model_number`),
  UNIQUE KEY `model_number_5` (`model_number`),
  UNIQUE KEY `model_number_6` (`model_number`),
  UNIQUE KEY `model_number_7` (`model_number`),
  UNIQUE KEY `model_number_8` (`model_number`),
  UNIQUE KEY `model_number_9` (`model_number`),
  UNIQUE KEY `model_number_10` (`model_number`),
  UNIQUE KEY `model_number_11` (`model_number`),
  UNIQUE KEY `model_number_12` (`model_number`),
  UNIQUE KEY `model_number_13` (`model_number`),
  UNIQUE KEY `model_number_14` (`model_number`),
  UNIQUE KEY `model_number_15` (`model_number`),
  UNIQUE KEY `model_number_16` (`model_number`),
  UNIQUE KEY `model_number_17` (`model_number`),
  UNIQUE KEY `model_number_18` (`model_number`),
  UNIQUE KEY `model_number_19` (`model_number`),
  UNIQUE KEY `model_number_20` (`model_number`),
  UNIQUE KEY `model_number_21` (`model_number`),
  FULLTEXT KEY `Title` (`title`),
  FULLTEXT KEY `Description` (`description`),
  FULLTEXT KEY `ModelNumber` (`model_number`)
) ENGINE=MyISAM AUTO_INCREMENT=289 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1960;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_product_google_attributes`
--

DROP TABLE IF EXISTS `ec_product_google_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_product_google_attributes` (
  `product_google_attribute_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this table.',
  `product_id` int(11) NOT NULL COMMENT 'Link to a specific product.',
  `attribute_value` text COMMENT 'json data stored here to use with product in google merchant feed.',
  PRIMARY KEY (`product_google_attribute_id`),
  UNIQUE KEY `product_google_attribute_id` (`product_google_attribute_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_promocode`
--

DROP TABLE IF EXISTS `ec_promocode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_promocode` (
  `promocode_id` varchar(50) NOT NULL DEFAULT '' COMMENT 'The unique identifier for ec_promocode.',
  `is_dollar_based` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, this is a dollar based promotion.',
  `is_percentage_based` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, this is a percentage based promotion.',
  `is_shipping_based` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, this is a shipping based promotion.',
  `is_free_item_based` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, this is a free item based promotion.',
  `is_for_me_based` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, this is a for me based promotion.',
  `by_manufacturer_id` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, this promotion applies only to products with a cooresponding manufacturer id.',
  `by_product_id` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, this promotion applies only to products with the cooresponding id.',
  `by_all_products` int(11) NOT NULL DEFAULT '0' COMMENT 'If selected, this promotion applies to all products and orders.',
  `promo_dollar` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Discount used when dollar based selected.',
  `promo_percentage` float(15,2) NOT NULL DEFAULT '0.00' COMMENT 'Percentage off when a percentage based promotion.',
  `promo_shipping` float(15,2) NOT NULL DEFAULT '0.00' COMMENT 'Amount off shipping total when shipping based promotion is used.',
  `promo_free_item` float(15,2) NOT NULL DEFAULT '0.00' COMMENT 'Amount off when free item promotion is used.',
  `promo_for_me` float(15,2) NOT NULL DEFAULT '0.00' COMMENT 'Amount off when for me type promotion is used.',
  `manufacturer_id` int(11) NOT NULL DEFAULT '0' COMMENT 'The manufacturer_id used if this promotion is a by_manufacturer_id type.',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT 'The product_id used if the promotion is a by_product_id type promotion.',
  `message` blob NOT NULL COMMENT 'The message displayed when the promotion is used.',
  `max_redemptions` int(11) NOT NULL DEFAULT '999' COMMENT 'The maximum number of times you can use this promotion code.',
  `times_redeemed` int(11) NOT NULL DEFAULT '0' COMMENT 'This is the number of times this coupon has been redeemed.',
  PRIMARY KEY (`promocode_id`),
  UNIQUE KEY `promoID` (`promocode_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=147;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_promotion`
--

DROP TABLE IF EXISTS `ec_promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_promotion` (
  `promotion_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_promotion.',
  `name` varchar(512) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'The name of the promotion.',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT 'The type of promotion this represents.',
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'The start date for this promotion.',
  `end_date` datetime DEFAULT '0000-00-00 00:00:00' COMMENT 'The end date for this promotion',
  `product_id_1` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected product to a ec_product.',
  `product_id_2` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected product to a ec_product.',
  `product_id_3` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected product to a ec_product.',
  `manufacturer_id_1` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected manufacturer to a ec_manufacturer.',
  `manufacturer_id_2` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected manufacturer to a ec_manufacturer.',
  `manufacturer_id_3` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected manufacturer to a ec_manufacturer.',
  `category_id_1` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected category to a ec_category.',
  `category_id_2` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected category to a ec_category.',
  `category_id_3` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected category to a ec_category.',
  `price1` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Promotion price 1.',
  `price2` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Promotion price 2.',
  `price3` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Promotion price 3.',
  `percentage1` double(9,2) NOT NULL DEFAULT '0.00' COMMENT 'Promotion percentage 1.',
  `percentage2` double(9,2) NOT NULL DEFAULT '0.00' COMMENT 'Promotion percentage 2.',
  `percentage3` double(9,2) NOT NULL DEFAULT '0.00' COMMENT 'Promotion percentage 3.',
  `number1` int(11) NOT NULL DEFAULT '0' COMMENT 'Promotion number 1.',
  `number2` int(11) NOT NULL DEFAULT '0' COMMENT 'Promotion number 2.',
  `number3` int(11) NOT NULL DEFAULT '0' COMMENT 'Promotion number 3.',
  `limit` int(11) NOT NULL DEFAULT '3' COMMENT 'The limit to how many items can be redeemed for this promotion.',
  PRIMARY KEY (`promotion_id`),
  UNIQUE KEY `PromotionID` (`promotion_id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=76;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_response`
--

DROP TABLE IF EXISTS `ec_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_response` (
  `response_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique id for an order response.',
  `is_error` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Was this response an error.',
  `processor` varchar(255) DEFAULT NULL COMMENT 'The payment processor used.',
  `order_id` int(11) DEFAULT NULL COMMENT 'Order id to relate this gateway response.',
  `response_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The response time.',
  `response_text` text COMMENT 'The response from the gateway.',
  PRIMARY KEY (`response_id`)
) ENGINE=MyISAM AUTO_INCREMENT=583 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=198;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_review`
--

DROP TABLE IF EXISTS `ec_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_review` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_review.',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the review to an ec_product.',
  `approved` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, this review can be shown on the front end.',
  `rating` int(2) NOT NULL DEFAULT '0' COMMENT 'The rating given by this review.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The review title.',
  `description` mediumblob NOT NULL COMMENT 'The review description.',
  `date_submitted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The date the review was submitted.',
  PRIMARY KEY (`review_id`),
  UNIQUE KEY `review_id` (`review_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=99;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_role`
--

DROP TABLE IF EXISTS `ec_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_label` varchar(20) NOT NULL DEFAULT '',
  `admin_access` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_id` (`role_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_roleaccess`
--

DROP TABLE IF EXISTS `ec_roleaccess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_roleaccess` (
  `roleaccess_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_label` varchar(20) NOT NULL DEFAULT '',
  `admin_panel` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`roleaccess_id`),
  UNIQUE KEY `roleaccess_id` (`roleaccess_id`)
) ENGINE=MyISAM AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_roleprice`
--

DROP TABLE IF EXISTS `ec_roleprice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_roleprice` (
  `roleprice_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL DEFAULT '0',
  `role_label` varchar(20) NOT NULL DEFAULT '',
  `role_price` float(15,3) NOT NULL DEFAULT '0.000',
  PRIMARY KEY (`roleprice_id`),
  UNIQUE KEY `roleprice_id` (`roleprice_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_setting`
--

DROP TABLE IF EXISTS `ec_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_setting` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'This is the primary key for ec_setting.',
  `site_url` varchar(255) NOT NULL DEFAULT '' COMMENT 'This is the site url.',
  `reg_code` varchar(255) NOT NULL DEFAULT '' COMMENT 'This is the registration code entered by the user.',
  `storeversion` varchar(20) NOT NULL DEFAULT '',
  `storetype` varchar(20) NOT NULL DEFAULT 'wordpress',
  `storepage` varchar(255) NOT NULL DEFAULT 'store',
  `cartpage` varchar(255) NOT NULL DEFAULT 'cart',
  `accountpage` varchar(255) NOT NULL DEFAULT 'account',
  `timezone` varchar(255) NOT NULL DEFAULT 'Europe/London',
  `shipping_method` varchar(255) NOT NULL DEFAULT 'method' COMMENT 'price, weight, method, live',
  `shipping_expedite_rate` float(11,2) NOT NULL DEFAULT '0.00' COMMENT 'This is a static value that can be used or not used by the customer for pricing and weight based methods.',
  `shipping_handling_rate` float(11,2) NOT NULL DEFAULT '0.00' COMMENT 'This is a global 1 time handling charge added to all shipping methods if present.',
  `ups_access_license_number` varchar(255) NOT NULL DEFAULT '' COMMENT 'Your UPS access license number for UPS based shipping.',
  `ups_user_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'Your UPS user ID for UPS based shipping.',
  `ups_password` varchar(255) NOT NULL DEFAULT '' COMMENT 'Your UPS password for UPS based shipping.',
  `ups_ship_from_zip` varchar(20) NOT NULL DEFAULT '' COMMENT 'Your zip code for UPS based shipping.',
  `ups_shipper_number` varchar(20) NOT NULL DEFAULT '' COMMENT 'Your UPS account shipper number for UPS based shipping.',
  `ups_country_code` varchar(9) NOT NULL DEFAULT 'US' COMMENT 'Your country code for UPS based shipping.',
  `ups_weight_type` varchar(19) NOT NULL DEFAULT 'LBS' COMMENT 'Your preferred weight label for UPS based shipping (lbs, kgs).',
  `usps_user_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Your USPS user name for USPS shipping.',
  `usps_ship_from_zip` varchar(20) NOT NULL DEFAULT '' COMMENT 'Your zip code for USPS shipping.',
  `fedex_key` varchar(255) NOT NULL DEFAULT '' COMMENT 'Your FedEx account key for FedEx shipping.',
  `fedex_account_number` varchar(255) NOT NULL DEFAULT '' COMMENT 'Your FedEx account number for FedEx shipping.',
  `fedex_meter_number` varchar(255) NOT NULL DEFAULT '' COMMENT 'Your FedEx account meter number for FedEx shipping.',
  `fedex_password` varchar(255) NOT NULL DEFAULT '' COMMENT 'Your FedEx account password for FedEx shipping.',
  `fedex_ship_from_zip` varchar(255) NOT NULL DEFAULT '' COMMENT 'Your FedEx ship from zip for FedEx shipping.',
  `fedex_weight_units` varchar(20) NOT NULL DEFAULT 'LB' COMMENT 'The weight unit for FedEx shipping (LB or KG).',
  `fedex_country_code` varchar(20) NOT NULL DEFAULT 'US' COMMENT 'The country code for FedEx shipping.',
  `auspost_api_key` varchar(255) NOT NULL DEFAULT '' COMMENT 'Your Australian Post API Key',
  `auspost_ship_from_zip` varchar(55) NOT NULL DEFAULT '' COMMENT 'Your Australian Post Ship From Postal Code',
  `dhl_site_id` varchar(155) NOT NULL DEFAULT '' COMMENT 'Your DHL Site ID.',
  `dhl_password` varchar(155) NOT NULL DEFAULT '' COMMENT 'Your DHL Password.',
  `dhl_ship_from_country` varchar(25) NOT NULL DEFAULT 'US' COMMENT 'Your DHL Ship From Country.',
  `dhl_ship_from_zip` varchar(64) NOT NULL DEFAULT '' COMMENT 'Your DHL Ship From Zip.',
  `dhl_weight_unit` varchar(20) NOT NULL DEFAULT 'LB' COMMENT 'Your DHL Weight Unit.',
  `dhl_test_mode` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Use DHL Test Mode.',
  `ups_conversion_rate` float(9,3) NOT NULL DEFAULT '1.000' COMMENT 'Converts the returned pricing.',
  `fedex_conversion_rate` float(9,3) NOT NULL DEFAULT '1.000' COMMENT 'Converts the returned pricing.',
  `fedex_test_account` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If true, FedEx account is a test account.',
  `fraktjakt_customer_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'Fraktjakt Customer ID.',
  `fraktjakt_login_key` varchar(64) NOT NULL DEFAULT '' COMMENT 'Fraktjakt Login Key.',
  `fraktjakt_conversion_rate` double(15,3) NOT NULL DEFAULT '1.000' COMMENT 'The conversion rate between your base currency and SEK.',
  `fraktjakt_test_mode` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Use test mode for Fraktjakt.',
  `fraktjakt_address` varchar(120) NOT NULL DEFAULT '' COMMENT 'Fraktjakt used for shipping estimate.',
  `fraktjakt_city` varchar(55) NOT NULL DEFAULT '' COMMENT 'Fraktjakt used for shipping estimate.',
  `fraktjakt_state` varchar(2) NOT NULL DEFAULT '' COMMENT 'Fraktjakt used for shipping estimate.',
  `fraktjakt_zip` varchar(20) NOT NULL DEFAULT '' COMMENT 'Fraktjakt used for shipping estimate.',
  `fraktjakt_country` varchar(2) NOT NULL DEFAULT '' COMMENT 'Fraktjakt used for shipping estimate.',
  `ups_ship_from_state` varchar(2) NOT NULL DEFAULT '' COMMENT 'This sets the ship from state when using UPS.',
  `ups_negotiated_rates` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'This sets the ship from state when using UPS.',
  `canadapost_username` varchar(512) NOT NULL DEFAULT '' COMMENT 'This is your Canada Post API username.',
  `canadapost_password` varchar(512) NOT NULL DEFAULT '' COMMENT 'This is your Canada Post API password.',
  `canadapost_customer_number` varchar(512) NOT NULL DEFAULT '' COMMENT 'This is your Canada Post customer number.',
  `canadapost_contract_id` varchar(512) NOT NULL DEFAULT '' COMMENT 'This is your Canada Post contract id (optional for special rates).',
  `canadapost_test_mode` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'This points to the test or live API URL for Canada Post.',
  `canadapost_ship_from_zip` varchar(100) NOT NULL DEFAULT '' COMMENT 'This is your Canada Post ship from zip.',
  PRIMARY KEY (`setting_id`)
) ENGINE=MyISAM AUTO_INCREMENT=223 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=268;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_shippingrate`
--

DROP TABLE IF EXISTS `ec_shippingrate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_shippingrate` (
  `shippingrate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_shippingrate.',
  `zone_id` int(11) NOT NULL DEFAULT '0' COMMENT 'References the ec_zone table for zoned shipping rates.',
  `is_price_based` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, this rate is for price based trigger rate shipping.',
  `is_weight_based` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, this rate is for a weight based trigger rate shipping.',
  `is_method_based` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, this rate is for method based shipping.',
  `is_ups_based` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, the live rate system for UPS.',
  `is_usps_based` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, the live rate system for USPS.',
  `is_fedex_based` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, the live rate system for FedEx.',
  `is_auspost_based` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, the live rate system for Australian Post is used.',
  `is_dhl_based` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, the live rate system for DHL.',
  `trigger_rate` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'The price or weight that triggers a different shipping rate.',
  `shipping_rate` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'The price for shipping at this trigger_rate.',
  `shipping_label` varchar(255) NOT NULL DEFAULT '' COMMENT 'This is the label used for shipping methods requiring a label.',
  `shipping_order` int(11) NOT NULL DEFAULT '0' COMMENT 'This is the order used to display shipping methods.',
  `shipping_code` varchar(255) NOT NULL DEFAULT '' COMMENT 'This is the code used for methods like UPS to determine the cost for this method.',
  `shipping_override_rate` float(11,3) DEFAULT NULL COMMENT 'This is the override price for live shipping rates.',
  `is_quantity_based` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, this rate is for quantity based shipping.',
  `is_percentage_based` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, this rate is for percentage based shipping.',
  `is_canadapost_based` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'This sets the rate type to Canada Post.',
  `free_shipping_at` float(15,3) NOT NULL DEFAULT '-1.000' COMMENT 'This is a subtotal price at which a live or method based rate gives the customer free shipping.',
  PRIMARY KEY (`shippingrate_id`),
  UNIQUE KEY `shippingrate_id` (`shippingrate_id`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=30;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_state`
--

DROP TABLE IF EXISTS `ec_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_state` (
  `id_sta` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_state.',
  `idcnt_sta` int(11) NOT NULL DEFAULT '0' COMMENT 'id_cnt connection, Country id.',
  `code_sta` varchar(50) NOT NULL DEFAULT '' COMMENT 'State code.',
  `name_sta` varchar(100) NOT NULL DEFAULT '' COMMENT 'State name.',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'User defined order for states, used in combo boxes.',
  `group_sta` varchar(100) NOT NULL DEFAULT '' COMMENT 'Option to group states in the state dropdown by a group title',
  PRIMARY KEY (`id_sta`),
  KEY `idcnt_sta` (`idcnt_sta`),
  KEY `code_sta` (`code_sta`)
) ENGINE=MyISAM AUTO_INCREMENT=84 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=30;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_subscriber`
--

DROP TABLE IF EXISTS `ec_subscriber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_subscriber` (
  `subscriber_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_subscriber.',
  `email` varchar(128) NOT NULL DEFAULT '' COMMENT 'Email address for the subscriber.',
  `first_name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The first name of the subscriber.',
  `last_name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The first name of the subscriber.',
  PRIMARY KEY (`subscriber_id`),
  UNIQUE KEY `subscriber_id` (`subscriber_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `email_2` (`email`),
  UNIQUE KEY `email_3` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=455 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=40;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_subscription`
--

DROP TABLE IF EXISTS `ec_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_subscription` (
  `subscription_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this table',
  `subscription_type` varchar(125) NOT NULL DEFAULT 'paypal' COMMENT 'Type of subscription, e.g. paypal',
  `subscription_status` varchar(125) NOT NULL DEFAULT 'Active' COMMENT 'Status of the subscription, Active or Canceled for example.',
  `title` varchar(510) NOT NULL DEFAULT '' COMMENT 'Title of the product purchased.',
  `model_number` varchar(510) NOT NULL DEFAULT '' COMMENT 'Model number of the product purchased.',
  `price` double(21,3) NOT NULL DEFAULT '0.000' COMMENT 'Price of the product per period',
  `payment_length` int(11) NOT NULL DEFAULT '1' COMMENT 'Length of time between payments, e.g. 3 months, represented by 3 in this field.',
  `payment_period` varchar(20) NOT NULL DEFAULT '' COMMENT 'Period of the payment, day, week, month of year, represented as D, W, M, or Y in this field.',
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date that this payment was submitted to start the subscription.',
  `last_payment_date` varchar(510) NOT NULL DEFAULT '' COMMENT 'Last payment made.',
  `next_payment_date` varchar(510) NOT NULL DEFAULT '' COMMENT 'The next payment due date.',
  `email` varchar(510) NOT NULL DEFAULT '' COMMENT 'Email entered by the user while purchasing the subscription',
  `first_name` varchar(155) NOT NULL DEFAULT '' COMMENT 'First name of the customer.',
  `last_name` varchar(155) NOT NULL DEFAULT '' COMMENT 'Last name of the customer.',
  `user_country` varchar(20) NOT NULL DEFAULT 'US' COMMENT 'Customer country of residence',
  `number_payments_completed` int(11) NOT NULL DEFAULT '1' COMMENT 'The number of times this subscription has been paid for.',
  `paypal_txn_id` varchar(510) NOT NULL DEFAULT '' COMMENT 'Initial transaction ID from PayPal',
  `paypal_txn_type` varchar(510) NOT NULL DEFAULT '' COMMENT 'Initial transaction type from PayPal',
  `paypal_subscr_id` varchar(510) NOT NULL DEFAULT '' COMMENT 'Initial subscription ID from PayPal used to track the subscription when updated or canceled.',
  `paypal_username` varchar(510) NOT NULL DEFAULT '' COMMENT 'Username assigned to this subscription by PayPal.',
  `paypal_password` varchar(510) NOT NULL DEFAULT '' COMMENT 'Password assigned to this subscription by PayPal.',
  `stripe_subscription_id` varchar(128) NOT NULL DEFAULT '' COMMENT 'If subscription created with Stripe, Stripe ID here.',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT 'User ID of the subscription owner.',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Product ID of the subscription to connect to.',
  PRIMARY KEY (`subscription_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_subscription_plan`
--

DROP TABLE IF EXISTS `ec_subscription_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_subscription_plan` (
  `subscription_plan_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for a Subscription Plan.',
  `plan_title` varchar(512) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'Title to describe the plan of connecting subscriptions.',
  `can_downgrade` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Can a customer automatically downgrade their subscription plan.',
  PRIMARY KEY (`subscription_plan_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_taxrate`
--

DROP TABLE IF EXISTS `ec_taxrate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_taxrate` (
  `taxrate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_taxrate.',
  `tax_by_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, tax users in this state_code only.',
  `tax_by_country` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, tax users in country_code only.',
  `tax_by_duty` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, tax users will be exempt from tax if this country_code exists.',
  `tax_by_vat` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, show the VAT calculation to the users on checkout.',
  `tax_by_single_vat` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Vat tax all users the same if selected.',
  `tax_by_all` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, tax all users.',
  `state_rate` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'The rate to tax the user.',
  `country_rate` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'If the country_code matches, rate to tax the user.',
  `duty_rate` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'This rate to tax for duty charges',
  `vat_rate` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'The VAT rate at which the user is calculating VAT additions to the products.',
  `vat_added` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Vat is added to the total at the end, not included in the products.',
  `vat_included` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Vat is included in the price of the product.',
  `all_rate` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'if tax_all_enabled, The rate to tax all users.',
  `state_code` varchar(50) NOT NULL DEFAULT '' COMMENT 'The state code needed to trigger this tax rate.',
  `country_code` varchar(50) NOT NULL DEFAULT '' COMMENT 'The country code needed to trigger this tax rate.',
  `vat_country_code` varchar(50) NOT NULL DEFAULT '' COMMENT 'The country code for VAT taxes.',
  `duty_exempt_country_code` varchar(50) NOT NULL DEFAULT '' COMMENT 'The country that will be exempt from a customs export duty tax.',
  PRIMARY KEY (`taxrate_id`),
  UNIQUE KEY `taxrate_id` (`taxrate_id`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=44;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_tempcart`
--

DROP TABLE IF EXISTS `ec_tempcart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_tempcart` (
  `tempcart_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Temporary Cart Row ID',
  `session_id` varchar(100) DEFAULT NULL COMMENT 'User Session ID From PHP',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates ec_tempcart row to ec_product row',
  `quantity` int(11) DEFAULT '0' COMMENT 'Amount in the cart',
  `grid_quantity` int(11) DEFAULT '0' COMMENT 'Amount in the cart for grid option set products only',
  `gift_card_message` blob COMMENT 'Message entered by user for the customer receiving this gift card.',
  `gift_card_from_name` varchar(255) DEFAULT NULL COMMENT 'Name of the user sending the gift card, entered by the user.',
  `gift_card_to_name` varchar(255) DEFAULT NULL COMMENT 'Name of the customer receiving the gift card, entered by the user.',
  `optionitem_id_1` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected option item ID to the information in the ec_optionitem table.',
  `optionitem_id_2` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected option item ID to the information in the ec_optionitem table.',
  `optionitem_id_3` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected option item ID to the information in the ec_optionitem table.',
  `optionitem_id_4` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected option item ID to the information in the ec_optionitem table.',
  `optionitem_id_5` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the selected option item ID to the information in the ec_optionitem table.',
  `donation_price` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Optional field for a donation product.',
  `last_changed_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date the last time this record was accessed.',
  `is_deconetwork` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Sets this item as a DecoNetwork item and changes the display to work with this product type.',
  `deconetwork_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'The unique id sent back from the DecoNetwork when adding to cart.',
  `deconetwork_name` varchar(512) NOT NULL DEFAULT '' COMMENT 'The name of the product from the DecoNetwork.',
  `deconetwork_product_code` varchar(64) NOT NULL DEFAULT '' COMMENT 'The product code from the DecoNetwork',
  `deconetwork_options` varchar(512) NOT NULL DEFAULT '' COMMENT 'The options selected by the customer on the DecoNetwork',
  `deconetwork_edit_link` varchar(512) NOT NULL DEFAULT '' COMMENT 'The edit link provided by the DecoNetwork',
  `deconetwork_color_code` varchar(64) NOT NULL DEFAULT '' COMMENT 'The color code of the shirt by the DecoNetwork',
  `deconetwork_product_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'The product id of this product on the DecoNetwork',
  `deconetwork_image_link` varchar(512) NOT NULL DEFAULT '' COMMENT 'The image link provided by the DecoNetwork',
  `deconetwork_discount` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'Any discount provided by the DecoNetwork',
  `deconetwork_tax` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'The tax amount by the DecoNetwork',
  `deconetwork_total` float(15,3) NOT NULL DEFAULT '0.000' COMMENT 'The total line item cost by the DecoNetwork',
  `deconetwork_version` int(11) NOT NULL DEFAULT '1' COMMENT 'A value updated each time the customer returns from the Deconetwork for this product, which is used to update the image to the user.',
  `gift_card_email` varchar(255) NOT NULL DEFAULT '' COMMENT 'The value of the gift card email if needed.',
  PRIMARY KEY (`tempcart_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2647 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=68;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_tempcart_optionitem`
--

DROP TABLE IF EXISTS `ec_tempcart_optionitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_tempcart_optionitem` (
  `tempcart_optionitem_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this table.',
  `tempcart_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relating tempcart_id.',
  `option_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relating option_id',
  `optionitem_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relating optionitem_id.',
  `optionitem_value` text NOT NULL COMMENT 'Value of the selected option, blob to allow for any value.',
  `session_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'The ec_cart_id that determines the user who entered this value.',
  `optionitem_model_number` varchar(128) NOT NULL DEFAULT '' COMMENT 'Model number extension that gets added to product model number if selected.',
  PRIMARY KEY (`tempcart_optionitem_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5441 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_timezone`
--

DROP TABLE IF EXISTS `ec_timezone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_timezone` (
  `timezone_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for ec_timezone.',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'The label for an area to choose. Muliple names for one identifier.',
  `identifier` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'The offical time zone name.',
  PRIMARY KEY (`timezone_id`),
  UNIQUE KEY `timezone_id` (`timezone_id`)
) ENGINE=MyISAM AUTO_INCREMENT=141 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=46;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_user`
--

DROP TABLE IF EXISTS `ec_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for the ec_user table.',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT 'Email address for the user, must be unique.',
  `password` varchar(255) NOT NULL DEFAULT '' COMMENT 'Encrypted password for the user.',
  `list_id` varchar(55) NOT NULL DEFAULT '' COMMENT 'Quickbooks Specific List ID.',
  `edit_sequence` varchar(20) NOT NULL DEFAULT '' COMMENT 'Quickbooks Specific Edit Sequence',
  `first_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'First name of the user.',
  `last_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Last name of the user.',
  `default_billing_address_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the ec_user table to the ec_address table that represents the default billing address for this user.',
  `default_shipping_address_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Relates the ec_user table to the ec_address table. Represents the default shipping address for this user.',
  `user_level` varchar(20) NOT NULL DEFAULT 'shopper' COMMENT 'The user level, common values are shopper and admin.',
  `is_subscriber` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, tells the admin that this user wants to recieve emails and/or newsletters.',
  `realauth_registered` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If selected, customer is using Realex Payments and this customer already has an account in the RealVault.',
  `stripe_customer_id` varchar(128) NOT NULL DEFAULT '' COMMENT 'Stripe Customer ID if subscription created with Stripe.',
  `default_card_type` varchar(20) NOT NULL DEFAULT '' COMMENT 'Used for subscription display of where billed to.',
  `default_card_last4` varchar(8) NOT NULL DEFAULT '' COMMENT 'Used for subscription display of where billed to.',
  `intensivecity` varchar(45) DEFAULT '',
  `order_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `usersign` varchar(45) DEFAULT '',
  `type` int(11) DEFAULT '0',
  `exclude_tax` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Give customer tax free purchases.',
  `exclude_shipping` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Give free shipping to this customer.',
  `user_notes` text COMMENT 'This is available for an admin to keep notes on a user.',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `email_2` (`email`),
  KEY `Email` (`email`),
  KEY `Password` (`password`)
) ENGINE=MyISAM AUTO_INCREMENT=494 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=98;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_webhook`
--

DROP TABLE IF EXISTS `ec_webhook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_webhook` (
  `webhook_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The unique indentifier for the webhook table, used by Stripe.',
  `webhook_type` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'The type of webhook called.',
  `webhook_data` blob COMMENT 'The data returned from stripe in this webhook call.',
  PRIMARY KEY (`webhook_id`),
  UNIQUE KEY `webhook_id` (`webhook_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_zone`
--

DROP TABLE IF EXISTS `ec_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_zone` (
  `zone_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for the ec_zone table',
  `zone_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'An identifying name for this zone.',
  PRIMARY KEY (`zone_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_zone_to_location`
--

DROP TABLE IF EXISTS `ec_zone_to_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_zone_to_location` (
  `zone_to_location_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for the ec_zone_to_location',
  `zone_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Connects the location to the ec_zone table.',
  `iso2_cnt` char(20) NOT NULL DEFAULT '' COMMENT 'Connects this table to the ec_country table.',
  `code_sta` varchar(50) NOT NULL DEFAULT '' COMMENT 'Connects this table to the ec_state table.',
  PRIMARY KEY (`zone_to_location_id`)
) ENGINE=MyISAM AUTO_INCREMENT=257 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_cf7dbplugin_st`
--

DROP TABLE IF EXISTS `wp_cf7dbplugin_st`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_cf7dbplugin_st` (
  `submit_time` decimal(16,4) NOT NULL,
  PRIMARY KEY (`submit_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_cf7dbplugin_submits`
--

DROP TABLE IF EXISTS `wp_cf7dbplugin_submits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_cf7dbplugin_submits` (
  `submit_time` decimal(16,4) NOT NULL,
  `form_name` varchar(127) DEFAULT NULL,
  `field_name` varchar(127) DEFAULT NULL,
  `field_value` longtext,
  `field_order` int(11) DEFAULT NULL,
  `file` longblob,
  KEY `submit_time_idx` (`submit_time`),
  KEY `form_name_idx` (`form_name`),
  KEY `field_name_idx` (`field_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_commentmeta`
--

DROP TABLE IF EXISTS `wp_commentmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_comments`
--

DROP TABLE IF EXISTS `wp_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_comments` (
  `comment_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_post_ID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `comment_author` tinytext NOT NULL,
  `comment_author_email` varchar(100) NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) NOT NULL DEFAULT '',
  `comment_type` varchar(20) NOT NULL DEFAULT '',
  `comment_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_ID`),
  KEY `comment_post_ID` (`comment_post_ID`),
  KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  KEY `comment_date_gmt` (`comment_date_gmt`),
  KEY `comment_parent` (`comment_parent`),
  KEY `comment_author_email` (`comment_author_email`(10))
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_links`
--

DROP TABLE IF EXISTS `wp_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_links` (
  `link_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) NOT NULL DEFAULT '',
  `link_name` varchar(255) NOT NULL DEFAULT '',
  `link_image` varchar(255) NOT NULL DEFAULT '',
  `link_target` varchar(25) NOT NULL DEFAULT '',
  `link_description` varchar(255) NOT NULL DEFAULT '',
  `link_visible` varchar(20) NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) unsigned NOT NULL DEFAULT '1',
  `link_rating` int(11) NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) NOT NULL DEFAULT '',
  `link_notes` mediumtext NOT NULL,
  `link_rss` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_visible`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_options`
--

DROP TABLE IF EXISTS `wp_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(64) NOT NULL DEFAULT '',
  `option_value` longtext NOT NULL,
  `autoload` varchar(20) NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=MyISAM AUTO_INCREMENT=25862 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_postmeta`
--

DROP TABLE IF EXISTS `wp_postmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_postmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`meta_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=MyISAM AUTO_INCREMENT=1861 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_posts`
--

DROP TABLE IF EXISTS `wp_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_posts` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext NOT NULL,
  `post_title` text NOT NULL,
  `post_excerpt` text NOT NULL,
  `post_status` varchar(20) NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) NOT NULL DEFAULT 'open',
  `post_password` varchar(20) NOT NULL DEFAULT '',
  `post_name` varchar(200) NOT NULL DEFAULT '',
  `to_ping` text NOT NULL,
  `pinged` text NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext NOT NULL,
  `post_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `guid` varchar(255) NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`)
) ENGINE=MyISAM AUTO_INCREMENT=1208 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_term_relationships`
--

DROP TABLE IF EXISTS `wp_term_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_term_relationships` (
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  KEY `term_taxonomy_id` (`term_taxonomy_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_term_taxonomy`
--

DROP TABLE IF EXISTS `wp_term_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) NOT NULL DEFAULT '',
  `description` longtext NOT NULL,
  `parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_terms`
--

DROP TABLE IF EXISTS `wp_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `slug` varchar(200) NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  KEY `name` (`name`),
  KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_usermeta`
--

DROP TABLE IF EXISTS `wp_usermeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=MyISAM AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_users`
--

DROP TABLE IF EXISTS `wp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_users` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) NOT NULL DEFAULT '',
  `user_pass` varchar(64) NOT NULL DEFAULT '',
  `user_nicename` varchar(50) NOT NULL DEFAULT '',
  `user_email` varchar(100) NOT NULL DEFAULT '',
  `user_url` varchar(100) NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-03-04  9:48:32
