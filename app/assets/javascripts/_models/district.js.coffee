((app)->
  app.District =  DS.Model.extend
    name: DS.attr('string')
    coord_x: DS.attr('string')
    coord_y: DS.attr('string')
    cities: DS.hasMany('Ria.City')
    fullName: (->
      @get('name')
    ).property('name')
)(window.Ria)
