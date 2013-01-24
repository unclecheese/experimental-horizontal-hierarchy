<?php


class HorizontalHierarchySiteTreePanel extends ViewableData implements HorizontalHierarchyPanelItem {


	public $siteTreeObj;


	public function __construct(SiteTree $siteTree) {
		$this->siteTreeObj = $siteTree;
	}



	public function getNode() {
		return $this->siteTreeObj;
	}



	public function getTitle() {
		return $this->siteTreeObj->MenuTitle;
	}



	public function getChildrenLink() {
		return Controller::join_links(
				Injector::inst()->get("CMSPagesController")->Link(),
				"sidebarchildren", 
				$this->siteTreeObj->ID
		);
	}



	public function getEditLink() {
		return Controller::join_links(
				Injector::inst()->get("CMSPageEditController")->Link(),
				"show", 
				$this->siteTreeObj->ID
		);		
	}



	public function getHasChild() {
		return $this->siteTreeObj->AllChildren()->exists();
	}
}