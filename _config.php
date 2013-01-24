<?php
$module_dir = basename(dirname(__FILE__));
$framework_dir = FRAMEWORK_DIR;
$result = strcmp($module_dir[0], $framework_dir[0]);
if($result < 1) {
	user_error("The Sidebar module must be in a directory with a greater alphabetical value than the $framework_dir.", E_USER_ERROR);
}

define('SIDEBAR_DIR',$module_dir);

LeftAndMain::require_javascript(SIDEBAR_DIR.'/javascript/horizontal-hierarchy.js');
LeftAndMain::require_css(SIDEBAR_DIR.'/css/horizontal-hierarchy.css');


Object::add_extension('CMSMain','HorizontalHierarchyCMSPagesController');
Object::add_extension('LeftAndMain','HorizontalHierarchyLeftAndMain');
