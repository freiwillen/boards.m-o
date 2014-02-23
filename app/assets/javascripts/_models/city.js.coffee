((app) ->
  app.City =  DS.Model.extend
    points: DS.hasMany('Ria.Point', embedded: true)
    reference_points: DS.hasMany('Ria.ReferencePoint', embedded: true)
    name: DS.attr('string')
    coord_x: DS.attr('string')
    coord_y: DS.attr('string')
    district: DS.belongsTo('Ria.District')
    fullName: (->
      if not(@get('district') is null)
        "#{@get('district').get('name')} / #{@get('name')}"
      else
        @get 'name'
    ).property('district', 'name')

)(window.Ria)
