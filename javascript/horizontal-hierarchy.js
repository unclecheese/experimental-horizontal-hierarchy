(function() {

  (function($) {
    return $.entwine('ss', function($) {
      $('body.cms .cms-menu .horizontal-hierarchy *').entwine({
        getContainer: function() {
          return $(".horizontal-hierarchy");
        }
      });
      $('body.cms .cms-menu .horizontal-hierarchy').entwine({
        Stack: [],
        Panels: {},
        onmatch: function() {
          var $list;
          $list = this.find(".cms-menu-list");
          return this.pushToStack($list);
        },
        doRefresh: function() {
          return this.getCurrentPanel().refresh();
        },
        getCurrentPanel: function() {
          return this.find(".cms-menu-list[data-position=" + (this.getStackSize()) + "]");
        },
        pushToStack: function(panel) {
          this.getStack().push(panel);
          return panel.attr("data-position", this.getStack().length);
        },
        insertPanel: function(href) {
          var data,
            _this = this;
          if (data = this.getPanels()[href]) {
            return this.openPanel(data);
          } else {
            return $.ajax({
              url: href,
              dataType: "JSON",
              success: function(data) {
                _this.openPanel(data);
                return _this.getPanels()[href] = data;
              }
            });
          }
        },
        openPanel: function(data) {
          var $panel,
            _this = this;
          $panel = $(data.html);
          $panel.css({
            left: this.outerWidth()
          });
          this.getCurrentPanel().after($panel);
          this.getCurrentPanel().goLeft();
          this.pushToStack($panel);
          return $panel.animate({
            left: 0
          }, function() {
            _this.getBackButton().show();
            return _this.getPanelTitle().attr("href", data.link).text(data.title);
          });
        },
        setSort: function(id) {
          var parentID, siblingIDs;
          siblingIDs = [];
          this.find("li").each(function() {
            return siblingIDs.push($(this).getID());
          });
          parentID = this.getCurrentPanel().attr("data-parent");
          return $.ajax({
            url: this.getCurrentPanel().attr("data-sort-url"),
            data: {
              ID: id,
              ParentID: parentID,
              SiblingIDs: siblingIDs
            }
          });
        },
        getStackSize: function() {
          return this.getStack().length;
        },
        getPreviousPanel: function() {
          return this.find(".cms-menu-list[data-position=" + (this.getStackSize() - 1) + "]");
        },
        getTopPanel: function() {
          return this.find(".cms-menu-list[data-position=1]");
        },
        getBackButton: function() {
          return this.find(".horizontal-hierarchy-back");
        },
        getHomeButton: function() {
          return this.find(".horizontal-hierarchy-home");
        },
        getPanelTitle: function() {
          return this.find(".panel-title");
        }
      });
      $(".cms-menu-list").entwine({
        goRight: function() {
          return this.animate({
            left: this.getContainer().outerWidth()
          }, function() {
            return this.remove();
          });
        },
        goLeft: function() {
          return this.animate({
            left: this.getContainer().outerWidth() * -1
          });
        },
        goCenter: function() {
          return this.animate({
            left: 0
          });
        },
        getPosition: function() {
          return parseInt(this.attr('data-position'));
        },
        getLeftPanel: function() {
          return $(".cms-menu-list[data-position=" + (this.getPosition() - 1) + "]");
        },
        getRightPanel: function() {
          return $(".cms-menu-list[data-position=" + (this.getPosition() + 1) + "]");
        },
        setCurrent: function() {
          var $panel, c, _results;
          c = this.getContainer();
          if (this.getPosition() === c.getStackSize()) return;
          c.getStack().pop().goRight();
          this.goCenter();
          _results = [];
          while (c.getStackSize() !== this.getPosition()) {
            $panel = c.getStack().pop();
            _results.push($panel.remove());
          }
          return _results;
        },
        refresh: function() {
          var pos, url,
            _this = this;
          url = this.attr("data-refresh-url");
          pos = this.attr("data-position");
          return $.ajax({
            url: url,
            dataType: "JSON",
            success: function(data) {
              _this.html($(data.html).html());
              return _this.getContainer().getPanels()[url] = data.html;
            }
          });
        }
      });
      $('.cms-menu-list li.hh-node').entwine({
        getID: function() {
          return (this.attr("id")).replace("node-", "");
        }
      });
      $('.horizontal-hierarchy-back').entwine({
        onclick: function(e) {
          e.preventDefault();
          return this.getContainer().getPreviousPanel().setCurrent();
        }
      });
      $('.horizontal-hierarchy-home').entwine({
        onclick: function(e) {
          e.preventDefault();
          return this.getContainer().getTopPanel().setCurrent();
        }
      });
      $('body.cms .cms-menu .horizontal-hierarchy .cms-menu-list li a.has-child').entwine({
        ClickTimeout: null,
        onclick: function(e) {
          var _this = this;
          e.preventDefault();
          if (this.getClickTimeout()) {
            window.clearTimeout(this.getClickTimeout());
            return $('.cms-container').loadPanel(this.attr('data-edit-url'));
          } else {
            if (this.attr('data-children-url')) {
              return this.setClickTimeout(window.setTimeout(function() {
                return _this.getContainer().insertPanel(_this.attr('data-children-url'));
              }, 200));
            }
          }
        }
      });
      $('body.cms .cms-container').entwine({
        submitForm: function(form, button, callback, ajaxOptions) {
          var _ref;
          if ((_ref = $(button).attr('name')) === "action_save" || _ref === "action_publish" || _ref === "action_doAdd") {
            callback = function() {
              return $('.horizontal-hierarchy').doRefresh();
            };
          }
          return this._super(form, button, callback, ajaxOptions);
        }
      });
      $(".cms-menu-list.child").entwine({
        onmatch: function() {
          var c;
          c = this.getContainer();
          return this.sortable({
            items: "li.hh-node",
            handle: ".handle",
            update: function(e, ui) {
              var id;
              id = ui.item.attr("id");
              console.log(id.replace("node-", ""));
              return c.setSort(id.replace("node-", ""));
            }
          });
        }
      });
      return null;
    });
  })(jQuery);

}).call(this);
