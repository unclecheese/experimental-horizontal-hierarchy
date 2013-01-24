		<ul class="cms-menu-list child" data-refresh-url="$RefreshLink" data-parent="$Items.first.Node.ParentID" data-sort-url="$SortLink">
		<% loop Items %>
			<li id="node-$Node.ID" class="hh-node">
				<a data-children-url="$ChildrenLink" <% if HasChild %>class="has-child"<% end_if %> data-edit-url="$EditLink">
					<span class="handle"><img src="horizontal_hierarchy/images/handle.png" /></span>					
					<span class="text">$Title</span>					
					<% if HasChild %>
					<span class="hh-child-items"><img src="horizontal_hierarchy/images/right.png" /></span>
					<% end_if %>
				</a>
			</li>
		<% end_loop %>
			<li><a href="$AddLink" class="cms-panel-link"><img src="horizontal_hierarchy/images/add.png" /> Add content here</a></li>
		</ul>
