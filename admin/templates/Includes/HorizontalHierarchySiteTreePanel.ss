		<ul class="cms-menu-list child" data-refresh-url="$RefreshLink" data-parent="$Items.first.Node.ParentID" data-sort-url="$SortLink">
		<% loop Items %>
			<li id="node-$Node.ID" class="hh-node">
				<a data-children-url="$ChildrenLink" <% if HasChild %>class="has-child"<% end_if %> data-edit-url="$EditLink">
					<span class="handle"></span>					
					<span class="text">$Title</span>					
					<% if HasChild %>
					<span class="hh-child-items"><i class="right"></i></span>
					<% end_if %>
				</a>
			</li>
		<% end_loop %>
			<li class="hh-node"><a href="$AddLink" class="cms-panel-link hh-add-content"> <i class="add"></i>Add content here</a></li>
		</ul>
