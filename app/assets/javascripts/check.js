function make_adminmap(center){
	var c = [24.711189,48.92473];
	if(center.length>0){c = center.split(',')}
	map = new YMaps.Map(document.getElementById('map'));
	map.setCenter(new YMaps.GeoPoint(c[0],c[1]),13);
	map.enableHotKeys();map.enableScrollZoom();
	map.addControl(new YMaps.SmallZoom());
	map.addControl(new YMaps.ToolBar());
	make_templates();
} 

function put_mark(saveid,x,y){
   var s = {hasBalloon:false};   
	var mark = new YMaps.Placemark(new YMaps.GeoPoint(x,y), s);   
	map.addOverlay(mark);   
	YMaps.Events.observe(map, map.Events.Click, function(map,mEvent){     
		var pt = mEvent.getGeoPoint();     
		map.removeOverlay(mark);     
		mark = new YMaps.Placemark(new YMaps.GeoPoint(pt.getLng(), pt.getLat()), s);
		map.addOverlay(mark);     
		$('#'+saveid).val(pt);   
	}); 
} 

function set_parent_rp(id){
	$('#parent_id').attr('value',id);   
	$('#parent_name').text(reference_points[id].name);   
	var sc = reference_points[id].coords;   
	map.setCenter(new YMaps.GeoPoint(sc[0],sc[1]),13); 
} 
function setcentr(a,b){
   map.setCenter(new YMaps.GeoPoint(a,b)); 
}
