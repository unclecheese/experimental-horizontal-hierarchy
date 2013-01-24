<?php


class HorizontalHierarchyLeftAndMain extends DataExtension {



	public function HorizontalHierarchyMainMenu() {
		$menu = $this->owner->MainMenu();
		foreach($menu as $item) {
			$class = $item->Code->forTemplate();
			if(class_exists($class)) {
				if(is_subclass_of($class, "CMSMain")) {
					$item->HasChildItems = true;
					$item->Link = Controller::join_links($item->Link, "sidebarchildren");
				}
				elseif(is_subclass_of($class, "ModelAdmin")) {
					$item->HasChildItems = true;
					$item->Link = "HorizontalHierarchyModelAdminController/sidebarchildren/$class";
				}
			}
		}
		return $menu;
	}
}