((app) ->
  app.ReferencePoint =  DS.Model.extend
    name: DS.attr('string')
    coord_x: DS.attr('string')
    coord_y: DS.attr('string')
    icon: DS.attr('string')
)(window.Ria)
