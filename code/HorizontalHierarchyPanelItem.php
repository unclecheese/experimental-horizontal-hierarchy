<?php


interface HorizontalHierarchyPanelItem {

	public function getTitle();


	public function getChildrenLink();


	public function getEditLink();


	public function getHasChild();


}