<?php


class HorizontalHierarchyCMSPagesController extends DataExtension {


	static $allowed_actions = array (
		'sidebarchildren'
	);

	public function getChildSidebarItems() {		
		return true;
	}



	public function sidebarchildren(SS_HTTPRequest $r) {
		$parentID = (int) $r->param('ID');
		$parent = SiteTree::get()->byID($parentID);
		$list = ArrayList::create();		
		foreach(SiteTree::get()->filter(array('ParentID' => $parentID)) as $page) {
			if($page->canView(Member::currentUser())) {
				$list->push(HorizontalHierarchySiteTreePanel::create($page));
			}
		}
		$json = array (				
			'html' => $this->owner->customise(array(
				'Items' => $list,
				'RefreshLink' => $this->owner->Link("sidebarchildren/$parentID"),
				'AddLink' => $this->getAddLink($parentID),
				'SortLink' => $this->owner->Link('savetreenode')
			))->renderWith('HorizontalHierarchySiteTreePanel'),
			'title' => $parent ? $parent->Title : "Pages",
			'link' => Injector::inst()->get("CMSPagesController")->Link()."?ParentID={$parentID}&view=list"
		);
		return Convert::array2json($json);

	}



	public function getAddLink($parentID) {
		return Injector::inst()->get("CMSPagesController")
			->Link("add/AddForm").
			"?action_doAdd=1&ParentID={$parentID}&SecurityID=".
			SecurityToken::getSecurityID();		
	}
}