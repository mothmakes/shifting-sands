offset_y = 0;
host = id;

next_rope = instance_create_layer(x,y + offset_y,"Instances",obj_rope);


attach = physics_joint_distance_create(host, next_rope, host.x,host.y,next_rope.x,next_rope.y,false);
physics_joint_set_value(attach,phy_joint_damping_ratio,1)
physics_joint_set_value(attach,phy_joint_frequency,10)

with(next_rope) {
	parent = other.id;
}

repeat(10) {
	
	offset_y += 1;
	last_rope = next_rope;
	next_rope = instance_create_layer(x,y+offset_y, "Instances", obj_rope);
	
	link = physics_joint_distance_create(last_rope,next_rope,last_rope.x,last_rope.y,next_rope.x,next_rope.y,false)
	physics_joint_set_value(link,phy_joint_damping_ratio,1)
	physics_joint_set_value(link,phy_joint_frequency,10)
	
	with(next_rope) {
		parent = other.last_rope;
	}
}
last_rope = next_rope;
end_point = instance_create_layer(x,y+offset_y,"Instances",obj_rope_holder_float);
link = physics_joint_distance_create(last_rope,end_point,last_rope.x,last_rope.y,end_point.x,end_point.y,false)

physics_joint_set_value(link,phy_joint_damping_ratio,1)
physics_joint_set_value(link,phy_joint_frequency,10)
	
with(end_point) {
	parent = other.last_rope;
}