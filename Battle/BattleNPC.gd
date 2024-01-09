extends Character
class_name BattleNPC # Base Class for all NPC AI. Bare Bone Randomized Attack Pattern.


var Intent: Intention = null;
var Moves: Array[Intention] = [];
var Probability: Array[int] = [];

@export var Movepool: Array[Intention]:
	get:
		return Moves;
	set(value):
		Moves = value;
		Probability.resize(value.size());

@export var MoveDistribution: Array[int]:
	get:
		return Probability;
	set(value):
		if value.size() != Probability.size():
			return;
		Probability = value;


func _ready():
	randomize();


func TurnStart() -> void:
	super.TurnStart();
	Intent = GetIntention();


func Act() -> void:
	super.PerformAction([], Intent);


func GetIntention() -> Intention:
	var MaxVal: int = 0;
	for ID in range(min(Movepool.size(), Probability.size())):
		MaxVal += Probability[ID];
	var Val: int = randi_range(1, MaxVal);
	var MoveID: int = 0
	while Val > 1:
		Val -= Probability[MoveID];
		MoveID += 1;
	return Movepool[MoveID];


func TurnEnd() -> void:
	Intent = null;
	super.TurnEnd();
