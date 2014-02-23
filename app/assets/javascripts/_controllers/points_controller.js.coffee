((app) ->
  app.PointsController = Ember.Controller.extend
    districtsView: Ember.CollectionView.extend
      tagName: 'ul'
      classNames: ['nav', 'nav-tabs', 'nav-stacked']
      itemViewClass: Ember.View.extend
        template: Ember.Handlebars.compile '<a>{{view.content.name}}</a>'
        click: ->
            @_parentView.get('controller').set 'cities', @content.get('cities')
            @_parentView.set 'selected_id', @content.get('id')
        isSelected: (-> @_parentView.get('selected_id') == @content.get('id')).property('parentView.selected_id')
        classNameBindings: ['isSelected:active']
            
    districtView: Ember.CollectionView.extend
      tagName: 'ul'
      classNames: ['nav', 'nav-tabs', 'nav-stacked']
      itemViewClass: Ember.View.extend
        templateName: 'points/city'
        click: ->
          if @_parentView.get('selected_id') == @content.get('id')
            @_parentView.set 'selected_id', null
          else
            @_parentView.set 'selected_id', @content.get('id')
            window.map.go_to_city @content
        isSelected: (-> @_parentView.get('selected_id') == @content.get('id')).property('parentView.selected_id')
        classNameBindings: ['isSelected:active']
        pointsBinding: 'content.points'
        pointsView: Ember.CollectionView.extend
          tagName: 'ul'
          classNames: ['nav', 'nav-tabs', 'nav-stacked']
          itemViewClass: Ember.View.extend
            templateName: 'points/city/point'
            editPoint: ->
              window.location.href = "#{window.location.href}/#{@get('content').get('id')}/edit"
            
    districts: app.store.findAll(app.District)

    cities: []
)(window.Ria)
