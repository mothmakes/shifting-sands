draw_set_color(c_lime);
if(drawConnector) {
	draw_line_width(drawCoords[0,0],drawCoords[0,1],drawCoords[1,0],drawCoords[1,1],3);	
}

var _node;
for(var i=0;i<instance_number(obj_node);i++) {
	_node = instance_find(obj_node, i)
	if(_node.isOutput) {
		for(var j=0;j<array_length(_node.connectedNodes);j++) {
			draw_line_width(_node.x,_node.y,_node.connectedNodes[j].x,_node.connectedNodes[j].y,3);
		}
	}
}