extends RigidBody2D

class_name Item

func use():
	return

# reparent the item, then disable its hitboxes (this jsut calls the rpc version)
func pickup_local(new_parent):
	new_parent = str(new_parent) # cant pass objects over rpc easily, so we will just pass the name of the node we want
	pickup.rpc(new_parent)

# reparent the item, then disable its hitboxes
@rpc("any_peer", "call_local", "reliable")
func pickup(new_parent):
	new_parent = get_node("/root/Startup/Level").get_child(0).get_child(0).get_node(str(new_parent)) # long method to get the node passed via string
	get_parent().remove_child(self)
	new_parent.add_child(self)
	position = get_parent().get_node("HeldItemSlot").position
	
	self.freeze = true
	get_node("PickupArea").monitoring = false
	get_node("PickupArea").monitorable = false
