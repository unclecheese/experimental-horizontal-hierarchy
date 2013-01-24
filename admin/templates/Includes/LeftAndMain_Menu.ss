<div class="cms-menu cms-panel cms-panel-layout west" id="cms-menu" data-layout-type="border">
	<div class="cms-logo-header north">
		<div class="cms-logo">
			<a href="$ApplicationLink" target="_blank" title="SilverStripe (Version - $CMSVersion)">
				SilverStripe <% if CMSVersion %><abbr class="version">$CMSVersion</abbr><% end_if %>
			</a>
			<span><% if SiteConfig %>$SiteConfig.Title<% else %>$ApplicationName<% end_if %></span>
		</div>
	
		<div class="cms-login-status">
			<a href="Security/logout" class="logout-link" title="<% _t('LeftAndMain_Menu.ss.LOGOUT','Log out') %>"><% _t('LeftAndMain_Menu.ss.LOGOUT','Log out') %></a>
			<% with CurrentMember %>
				<span>
					<% _t('LeftAndMain_Menu.ss.Hello','Hi') %>
					<a href="{$AbsoluteBaseURL}admin/myprofile" class="profile-link ss-ui-dialog-link" data-popupclass="edit-profile-popup">
						<% if FirstName && Surname %>$FirstName $Surname<% else_if FirstName %>$FirstName<% else %>$Email<% end_if %>
					</a>
				</span>
			<% end_with %>
		</div>
	</div>
		
	<div class="cms-panel-content center horizontal-hierarchy">	
		<div class="hh-menu-buttons">
				<a class="horizontal-hierarchy-home" href="javascript:void(0);"><img src="horizontal_hierarchy/images/home.png" /></a>
				<a class="cms-panel-link panel-title" href="javascript:void(0);">$SiteConfig.Title</a>
				<a class="horizontal-hierarchy-back" href="javascript:void(0);"><img src="horizontal_hierarchy/images/left.png" height="12"/> Back</a> 
				
		</div>
		<ul class="cms-menu-list top current">
		<% loop HorizontalHierarchyMainMenu %>
			<li class="$LinkingMode $FirstLast <% if LinkingMode == 'link' %><% else %>opened<% end_if %>" id="Menu-$Code" title="$Title.ATT">
				<a <% if HasChildItems %>class="has-child" href="javascript:void(0)" data-children-url="$Link"<% else %>href="$Link"<% end_if %>  <% if Code == 'Help' %>target="_blank"<% end_if%>>
					<span class="icon icon-16 icon-{$Code.LowerCase}">&nbsp;</span>
					<span class="text">$Title</span>
					<% if HasChildItems %>
					<span class="hh-child-items"><img src="horizontal_hierarchy/images/right.png" /></span>
					<% end_if %>
				</a>
			
			</li>
		<% end_loop %>
		</ul>
	</div>
		
	<div class="cms-panel-toggle south">
		<a class="toggle-expand" href="#"><span>&raquo;</span></a>
		<a class="toggle-collapse" href="#"><span>&laquo;</span></a>
	</div>
</div>
