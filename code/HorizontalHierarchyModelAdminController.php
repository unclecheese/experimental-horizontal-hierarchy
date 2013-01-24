<?php

class HorizontalHierarchyModelAdminController extends Controller {




	public function sidebarchildren(SS_HTTPRequest $r) {
		
		$adminName = $r->param('ID');
		$modelName = $r->param('OtherID');
		$list = ArrayList::create();		
		$SNG = Injector::inst()->get($adminName);
		$SNG->init();				
		if($modelName) {
			foreach($SNG->getList() as $record) {
				$list->push(HorizontalHierarchyModelAdminRecord::create($SNG, $record));
			}
		}
		else {
			foreach($SNG->config()->managed_models as $model) {
				$list->push(HorizontalHierarchyModelAdminPanel::create($SNG, $model));
			}
		}
		$json = array (				
			'html' => $this->customise(array(
				'Items' => $list,
				'RefreshLink' => $this->Link("sidebarchildren/$modelName"),
				'AddLink' => $modelName ? $SNG->Link("{$modelName}/EditForm/field/{$modelName}/item/new") : false				
			))->renderWith('HorizontalHierarchyModelAdminPanel'),
			'title' => $modelName ? Injector::inst()->get($modelName)->i18n_plural_name() : $SNG->config()->menu_title,
			'link' => $SNG->Link($modelName)
		);
		return Convert::array2json($json);

	}


}