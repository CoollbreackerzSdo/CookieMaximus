extends Object

class_name GlobalKey

static var _key:int = 0

static func get_current_key() -> int:
	_key += 1;
	return _key
