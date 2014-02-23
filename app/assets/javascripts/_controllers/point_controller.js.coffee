((app) ->
  app.PointController = Ember.Controller.extend
    controllerPropertyBinding:'Ria.mapInput'
    districts: app.store.findAll(app.District)
    save: ->
      point = @get('content')
      geo = app.get('mapInput')
      unless geo is undefined
        point.setProperties coord_x: geo.__lat, coord_y: geo.__lng
      point.get('store').commit()
    boardsView: Ember.CollectionView.extend
      tagName: 'ul'
      itemViewClass: Ember.View.extend
        template: Ember.Handlebars.compile('<a>{{ view.content.code }}</a>')

    districtsView: Ember.CollectionView.extend
      tagName: 'ul'
      itemViewClass: Ember.View.extend
        isExpanded: false
        tagName: 'li'
        expand: ->
          @set 'isExpanded', true
        collaps: ->
          @set 'isExpanded', false
        districtBinding: 'controller.content'
        select: ->
          window.map.go_to_district @get('content')
          @get('controller').get('content').set('reference_point_class', 'District')
          @get('controller').get('content').set('reference_point_id', @get('content').get('id'))
        templateName: 'point-form/district'#Ember.Handlebars.compile('!!1')
        citiesView: Ember.CollectionView.extend
          tagName: 'ul'
          contentBinding: 'parentView.content.cities'
          itemViewClass: Ember.View.extend
            template: Ember.Handlebars.compile('<a>{{ view.content.name }}</a>')
            click: ->
              window.map.go_to_city @get('content')
              @get('controller').get('content').set('reference_point_class', 'City')
              @get('controller').get('content').set('reference_point_id', @get('content').get('id'))



)(window.Ria)
