extends RefCounted
class_name EffectMarker # Container for Character-Altering Effects.


var User: Character;
var Counter: int = 1;
var EffectCounter: int:
	get:
		return Counter
	set(value):
		Counter = value;
		if Counter == 0:
			User.RemoveEffectMarker(self);
var Behavior: Effect;


func _init(user: Character, effect: Effect, counter: int) -> void:
	User = user;
	EffectCounter = counter;
	Behavior = effect;


func TurnStart():
	await Behavior.TurnStart(self);


func CharacterActivelyPacified(Target: Character, Cause: Action) -> void:
	await Behavior.CharacterActivelyPacified(self, Target, Cause);


func CharacterActivelyExited(Target: Character, Cause: Action) -> void:
	await Behavior.CharacterActivelyPacified(self, Target, Cause);


func CharacterPassivelyPacified(Target: Character, Cause: Effect) -> void:
	await Behavior.CharacterPassivelyPacified(self, Target, Cause);


func CharacterPassivelyExited(Target: Character, Cause: Effect) -> void:
	await Behavior.CharacterPassivelyPacified(self, Target, Cause);


func CharacterActionStarted(Target: Character, Act: Action) -> void:
	await Behavior.CharacterActionStarted(self, Target, Act);


func CharacterActionEnded(Target: Character, Act: Action) -> void:
	await Behavior.CharacterActionEnded(self, Target, Act);


func ModifyAction(Act: Action) -> void:
	await Behavior.ModifyAction(self, Act);


func CharacterKindnessActivelyChanged(Target: Character, Amount: int, Cause: Action) -> void:
	await Behavior.CharacterKindnessActivelyChanged(self, Target, Amount, Cause);


func CharacterWillpowerActivelyChanged(Target: Character, Amount: int, Cause: Action) -> void:
	await Behavior.CharacterWillpowerActivelyChanged(self, Target, Amount, Cause);


func CharacterEffectListActivelyChanged(Target: Character, TargetedEffect: EffectMarker, Cause: Action, Removal: bool) -> void:
	await Behavior.CharacterEffectListActivelyChanged(self, Target, TargetedEffect, Cause, Removal);


func CharacterKindnessPassivelyChanged(Target: Character, Amount: int, Cause: Effect) -> void:
	await Behavior.CharacterKindnessPassivelyChanged(self, Target, Amount, Cause);


func CharacterWillpowerPassivelyChanged(Target: Character, Amount: int, Cause: Effect) -> void:
	await Behavior.CharacterWillpowerPassivelyChanged(self, Target, Amount, Cause);


func CharacterEffectListPassivelyChanged(Target: Character, TargetedEffect: EffectMarker, Cause: Effect, Removal: bool) -> void:
	await Behavior.CharacterEffectListPassivelyChanged(self, Target, TargetedEffect, Cause, Removal);


func TurnEnd() -> void:
	await Behavior.TurnEnd(self);
