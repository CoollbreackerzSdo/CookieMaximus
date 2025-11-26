extends Object

class_name EntityKey

var id: int

static func create_global_current() -> EntityKey:
	var new_key = EntityKey.new() 
	new_key.id = GlobalKey.get_current_key()
	return new_key

static func create(value: int) -> EntityKey:
	var new_key = EntityKey.new() 
	new_key.id = value
	return new_key
