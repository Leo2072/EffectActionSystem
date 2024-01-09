extends Resource
class_name Effect # Base Class for Modelling Effect Behavior.


# Higher Priority Effects are Executed First.
@export var Priority: int = 1


func TurnStart(Marker: EffectMarker):
	pass


func CharacterActivelyPacified(Marker: EffectMarker, Target: Character, Cause: Action) -> void:
	pass


func CharacterActivelyExited(Marker: EffectMarker, Target: Character, Cause: Action) -> void:
	pass


func CharacterPassivelyPacified(Marker: EffectMarker, Target: Character, Cause: Effect) -> void:
	pass


func CharacterPassivelyExited(Marker: EffectMarker, Target: Character, Cause: Effect) -> void:
	pass


func CharacterActionStarted(Marker: EffectMarker, Target: Character, Act: Action) -> void:
	pass


func CharacterActionEnded(Marker: EffectMarker, Target, Act: Action) -> void:
	pass


func ModifyAction(Marker: EffectMarker, Act: Action) -> void:
	pass


func CharacterKindnessActivelyChanged(Marker: EffectMarker, Target: Character, Amount: int, Cause: Action) -> void:
	pass


func CharacterWillpowerActivelyChanged(Marker: EffectMarker, Target: Character, Amount: int, Cause: Action) -> void:
	pass


func CharacterEffectListActivelyChanged(Marker: EffectMarker, Target: Character, TargetedEffect: EffectMarker, Cause: Action, Removal: bool) -> void:
	pass


func CharacterKindnessPassivelyChanged(Marker: EffectMarker, Target: Character, Amount: int, Cause: Effect) -> void:
	pass


func CharacterWillpowerPassivelyChanged(Marker: EffectMarker, Target: Character, Amount: int, Cause: Effect) -> void:
	pass


func CharacterEffectListPassivelyChanged(Marker: EffectMarker, Target: Character, TargetedEffect: EffectMarker, Cause: Effect, Removal: bool) -> void:
	pass


func TurnEnd(Marker: EffectMarker) -> void:
	pass
