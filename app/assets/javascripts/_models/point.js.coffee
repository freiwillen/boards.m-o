((app)->
  app.Point = DS.Model.extend
    coord_x: DS.attr('string')
    coord_y: DS.attr('string')
    code: DS.attr('string')
    address: DS.attr('string')
    reference_point_id: DS.attr('number')
    reference_point_class: DS.attr('string')
    type: DS.attr('string')
    bsize: DS.attr('string')
    referencePoint: (->
      if @get('reference_point_class') is 'City'
        app.City.find @get('reference_point_id')
      else if @get('reference_point_class') is 'District'
        app.District.find @get('reference_point_id')
    ).property('reference_point_id')
    boards: DS.hasMany('Ria.Board', embedded: true)

)(window.Ria)
