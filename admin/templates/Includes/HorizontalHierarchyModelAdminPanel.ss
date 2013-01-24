		<ul class="cms-menu-list child" data-refresh-url="$RefreshLink">
		<% loop Items %>
			<li class="hh-node">
				<a data-children-url="$ChildrenLink" <% if HasChild %>class="has-child"<% end_if %> data-edit-url="$EditLink">					
					<span class="text">$Title</span>					
					<% if HasChild %>
					<span class="hh-child-items"><i class="right"></i>  </span>
					<% end_if %>
				</a>
			</li>
		<% end_loop %>
			<% if AddLink %>
			<li><a href="$AddLink" class="cms-panel-link"><img src="horizontal-hierarchy/images/add.png" /> Add content here</a></li>
			<% end_if %>
		</ul>
