var map, board_groups = {}, board_sizes = {}, cities = {}, regions = {};
var this_city, this_region, boards = [], that = '', cityfilter;
var tpl1 = '<div class="b-board"><h2><a href="/board/$[metaDataProperty.code]">$[metaDataProperty.code]</a> </h2><div>$[metaDataProperty.type] $[metaDataProperty.size]</div><div>$[name]</div></div>'; 
var tpl2 = '<div class="b-board"><b>$[name]</b><div>$[metaDataProperty.code]</div></div>';  
function make_templates(){   
	YMaps.Templates.add('boards#tpl1', new YMaps.Template(tpl1));   
	var s = new YMaps.Style();   
	s.balloonContentStyle = new YMaps.BalloonContentStyle('boards#tpl1');   
	s.iconStyle = new YMaps.IconStyle();   
	s.iconStyle.offset = new YMaps.Point(-14,-32);   
	s.iconStyle.href = '/images/billboard.png';   
	s.iconStyle.size = new YMaps.Point(32,32);   
	YMaps.Styles.add('boards#space',s);    
	YMaps.Templates.add('boards#tpl2', new YMaps.Template(tpl2));   
	s = new YMaps.Style();   
	s.balloonContentStyle = new YMaps.BalloonContentStyle('boards#tpl2');   
	s.iconStyle = new YMaps.IconStyle();   
	s.iconStyle.offset = new YMaps.Point(-14,-32);  
	s.iconStyle.href = '/images/billboard.png';   
	s.iconStyle.size = new YMaps.Point(32,32);   
	YMaps.Styles.add('boards#spaces',s);
} 
function goto_region(n){
	map.panTo(regions[n].geo);map.setZoom(12)
} 
function goto_city(n){
	map.panTo(cities[n].geo);
	map.setZoom(14)
} 
function goto_coords(c){
	var cc = c.split(',');  
       	map.panTo(new YMaps.GeoPoint(cc[0],cc[1]));map.setZoom(14)
} 
function goto_boards(){
	map.setCenter(boards[0].geo);map.setZoom(14)
} 
function goto_board(b, custom_zoom){
	map.panTo(b.geo);
	map.setCenter(b.geo);
	b.mark.openBalloon();
	map.setZoom((custom_zoom === undefined ? 15 : custom_zoom))
} 
function load_city(c){
     if(typeof(board_groups[this_city+'/'+this_region])=="undefined"){  
	    $.get('/reference_points/'+cities[c].id+'/filter_options',function(data){
	           eval(data);     
		   make_points_from(b);     
		   goto_city(c);   
	    });   
     } 
} 
function switch_region(){   
	this_region = $('select#region option:selected').text();   
	$('select#city option').remove();   
	cityfilter.filter('[region="'+this_region+'"]').appendTo('select#city').eq(0).attr('selected','selected');
     	switch_city(); 
} 
function switch_city(){   
	var selected = $('select#city option:selected').text();   
	if (selected != this_city){ load_city(selected); }   
	this_city = selected; 
} 
function make_map(){
     	map = new YMaps.Map(document.getElementById('map'));
     	map.setCenter(new YMaps.GeoPoint(24.711189,48.92473),13);
     	map.setMinZoom(12);map.setMaxZoom(16);map.enableHotKeys();
     	var zoom = new YMaps.SmallZoom();map.addControl(zoom);
     	var toolbar = new YMaps.ToolBar();map.addControl(toolbar);
     	make_templates();
	put_marks();
	make_points(); 
} 
function make_points_from(b){
     var s = 'boards#space';
     for(var i=0;i<b.length;i++){
      	     var p = b[i];
      	     p.geo = new YMaps.GeoPoint(p.coords[0],p.coords[1]);
      	     var mark = new YMaps.Placemark(p.geo, {
		 style: p.multi ? 'boards#spaces' : s,
		 hasHint:false,          
		 balloonOptions:{maxWidth:160,margin:[8,16]} 
	     });       
	     mark.name = p.address;      
	     mark.metaDataProperty.code  = p.code;       
	     mark.metaDataProperty.photo = '/'+p.code+'.jpg';       
	     mark.metaDataProperty.type   = p.btype;      
	     mark.metaDataProperty.size   = p.bsize;       
	     p.mark = mark;        
	     var k = p.city+'/'+p.region;       
	     if (typeof(board_groups[k])=="undefined"){         
		     board_groups[k] = new YMaps.GeoObjectCollection();
	     }       
	     board_groups[k].add(mark);   
     }   
     for (var k in board_groups){
	     map.addOverlay(board_groups[k])
     } 
} 
function make_points(){
     for (var k in cities){     
	     cities[k].geo = new YMaps.GeoPoint(cities[k].coords[0],cities[k].coords[1]);
     }   
     for (var k in regions){    
	     regions[k].geo = new YMaps.GeoPoint(regions[k].coords[0],regions[k].coords[1]);
     }   
     make_points_from(boards); 
} 
function put_marks(){   
	for(var point in points){     
		var p = points[point];     
		p.geo = new YMaps.GeoPoint(p.coords[0],p.coords[1]);     
		var s = 'default#buildingsIcon';     
		if (p.icon){ 
			if(p.icon.indexOf('/')==0){
			 	s = new YMaps.Style();
			 	s.iconStyle = new YMaps.IconStyle();       
				s.iconStyle.offset = new YMaps.Point(-24,-24);       
				s.iconStyle.size = new YMaps.Point(48, 48);       
				s.iconStyle.href = p.icon;     
			}
		}     
		var mark = new YMaps.Placemark(p.geo,       {style:s,balloonOptions:{maxWidth:160,margin:[8,16]} });     
		mark.name = p.name;     
		p.mark = mark;     
		map.addOverlay(mark);   
	} 
}
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

