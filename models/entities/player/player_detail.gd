extends Object

class_name PlayerDetail

var healt: int = 0
var stress: int = 0
var hungry: int = 0
var trash_count: int = 0

static func create(_healt:int = 0,_stress:int = 0,_hungry:int = 0) -> PlayerDetail:
	var defaultDetail: PlayerDetail = new()
	defaultDetail.healt = _healt;
	defaultDetail.stress = _stress;
	defaultDetail.hungry = _hungry;
	return defaultDetail
