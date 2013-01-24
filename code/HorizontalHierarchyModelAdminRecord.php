<?php

class HorizontalHierarchyModelAdminRecord extends ViewableData implements HorizontalHierarchyPanelItem {

	public $controller;


	public $record;


	public function __construct(ModelAdmin $controller, DataObject $record) {
		$this->controller = $controller;
		$this->record = $record;
	}



	public function getRecord() {
		return $this->record;
	}



	public function getTitle() {
		return $this->record->getTitle();
	}



	public function getChildrenLink() {
		return false;
	}



	public function getEditLink() {
		return Controller::join_links(
				$this->controller->Link(),
				$this->record->ClassName,
				"EditForm",
				"field",
				$this->record->ClassName,
				"item",
				$this->record->ID,
				"edit"
		);		
	}



	public function getHasChild() {
		return false;
	}

}