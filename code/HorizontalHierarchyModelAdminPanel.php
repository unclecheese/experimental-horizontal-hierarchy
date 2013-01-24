<?php

class HorizontalHierarchyModelAdminPanel extends ViewableData implements HorizontalHierarchyPanelItem {

	public $controller;


	public $modelName;


	public function __construct(ModelAdmin $controller, $modelName) {
		$this->controller = $controller;
		$this->modelName = $modelName;
	}



	public function getController() {
		return $this->controller;
	}



	public function getTitle() {			
		return Injector::inst()->get($this->modelName)->i18n_plural_name();
	}



	public function getChildrenLink() {
		return Controller::join_links(
			"HorizontalHierarchyModelAdminController",			
			"sidebarchildren",
			$this->controller->class,
			$this->modelName
		);
	}



	public function getEditLink() {
		return $this->controller->Link();
	}



	public function getHasChild() {
		return true;
	}

}