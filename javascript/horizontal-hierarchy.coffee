(($) ->
	$.entwine 'ss', ($) ->
		$('body.cms .cms-menu .horizontal-hierarchy *').entwine

			getContainer: ->  $ ".horizontal-hierarchy"		
		
		$('body.cms .cms-menu .horizontal-hierarchy').entwine
						
			Stack: []

			Panels: {}

			onmatch: ->
				$list = @find ".cms-menu-list"
				@pushToStack $list


			doRefresh: ->
				@getCurrentPanel().refresh()

			getCurrentPanel: ->
				@find ".cms-menu-list[data-position=#{@getStackSize()}]"

			pushToStack: (panel) ->
				@getStack().push panel
				panel.attr "data-position", @getStack().length

			insertPanel: (href) ->
				if data = @getPanels()[href]
					@openPanel data
				else
					$.ajax
						url: href
						dataType: "JSON"
						success: (data) =>
							@openPanel data
							@getPanels()[href] = data


			openPanel: (data) ->
				$panel = $ data.html
				$panel.css
					left: @outerWidth()
				@getCurrentPanel().after $panel				
				@getCurrentPanel().goLeft()															
				@pushToStack $panel							
				$panel.animate
					left: 0
				, =>
					@getBackButton().show()
					@getPanelTitle().attr("href", data.link).text data.title


			setSort: (id) ->
				siblingIDs = []
				@find("li").each -> siblingIDs.push $(@).getID()
				parentID = @getCurrentPanel().attr "data-parent"

				$.ajax
					url: @getCurrentPanel().attr "data-sort-url"
					data:
						ID: id
						ParentID: parentID
						SiblingIDs: siblingIDs
			getStackSize: ->
				@getStack().length
						
			getPreviousPanel: ->
				@find ".cms-menu-list[data-position=#{@getStackSize()-1}]"

			getTopPanel: ->
				@find ".cms-menu-list[data-position=1]"

			getBackButton: ->
				@find ".horizontal-hierarchy-back"

			getHomeButton: ->
				@find ".horizontal-hierarchy-home"

			getPanelTitle: ->
				@find ".panel-title"


		$(".cms-menu-list").entwine

			goRight: ->
				@animate
					left: @getContainer().outerWidth()
				, ->
					@remove()

			goLeft: ->
				@animate
					left: @getContainer().outerWidth()*-1

			goCenter: ->
				@animate
					left: 0

			getPosition: ->
				parseInt(@attr 'data-position')

			getLeftPanel: ->
				$ ".cms-menu-list[data-position=#{@getPosition()-1}]"

			getRightPanel: ->
				$ ".cms-menu-list[data-position=#{@getPosition()+1}]"


			setCurrent: ->
				c = @getContainer()				
				if @getPosition() is c.getStackSize() then return

				c.getStack().pop().goRight()
				@goCenter()

				until c.getStackSize() is @getPosition()
					$panel = c.getStack().pop()
					$panel.remove()



			refresh: ->
				url = @attr "data-refresh-url"
				pos = @attr "data-position"
				$.ajax
					url: url
					dataType: "JSON"
					success: (data) =>
						@html $(data.html).html()
						@getContainer().getPanels()[url] = data.html



		$('.cms-menu-list li.hh-node').entwine
			getID: ->
				(@attr "id").replace "node-", ""


		$('.horizontal-hierarchy-back').entwine
			onclick: (e) ->
				e.preventDefault()				
				@getContainer().getPreviousPanel().setCurrent()

		$('.horizontal-hierarchy-home').entwine
			onclick: (e) ->
				e.preventDefault()
				@getContainer().getTopPanel().setCurrent()



		$('body.cms .cms-menu .horizontal-hierarchy .cms-menu-list li a.has-child').entwine
			
			ClickTimeout: null

			onclick: (e) ->
				e.preventDefault()
				if @getClickTimeout()
					window.clearTimeout @getClickTimeout()
					$('.cms-container').loadPanel @attr 'data-edit-url'
				else
					if @attr 'data-children-url'
						@setClickTimeout window.setTimeout =>
							@getContainer().insertPanel @attr 'data-children-url'
						, 200

		$('body.cms .cms-container').entwine
			submitForm: (form, button, callback, ajaxOptions) ->
				if ($(button).attr 'name') in ["action_save","action_publish","action_doAdd"]					
					callback = ->
						$('.horizontal-hierarchy').doRefresh()

				@_super form, button, callback, ajaxOptions

		$(".cms-menu-list.child").entwine
			onmatch: ->
				c = @getContainer()
				@sortable
					items: "li.hh-node",
					handle: ".handle",
					update: (e, ui) ->
						id = ui.item.attr "id"
						console.log id.replace "node-",""
						c.setSort id.replace "node-",""						
					
						

		null

)(jQuery)

