((app) ->
  app.PointView = Ember.View.extend
    templateName: 'point-form'
    mapClickBinding: 'Ria.mapInput'
    defaultPropertyBinding: 'app.mapInput'
    gogo: ->
      alert 'gogo'
)(window.Ria)
