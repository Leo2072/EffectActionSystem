extends Node2D
class_name Character # Base Class for Players and NPCs alike.wqA


signal ActivelyPacified(User: Character, Cause: Action, WaitBatch: BatchCoroutines)
signal ActivelyExited(User: Character, Cause: Action, WaitBatch: BatchCoroutines)
signal PassivelyPacified(User: Character, Cause: Effect, WaitBatch: BatchCoroutines)
signal PassivelyExited(User: Character, Cause: Effect, WaitBatch: BatchCoroutines)
signal ActionStarted(User: Character, Act: Action, WaitBatch: BatchCoroutines)
signal ActionEnded(User: Character, Act: Action, WaitBatch: BatchCoroutines)
signal KindnessActivelyChanged(User: Character, Amount: int, Cause: Action, WaitBatch: BatchCoroutines)
signal WillpowerActivelyChanged(User: Character, Amount: int, Cause: Action, WaitBatch: BatchCoroutines)
signal EffectListActivelyChanged(User: Character, Marker: EffectMarker, Cause: Action, Removal: bool, WaitBatch: BatchCoroutines)
signal KindnessPassivelyChanged(User: Character, Amount: int, Cause: Effect, WaitBatch: BatchCoroutines)
signal WillpowerPassivelyChanged(User: Character, Amount: int, Cause: Effect, WaitBatch: BatchCoroutines)
signal EffectListPassivelyChanged(User: Character, Marker: EffectMarker, Cause: Effect, Removal: bool, WaitBatch: BatchCoroutines)


@export var Kindness: int = 0;
@export var KindnessThreshold: int = 50;
@export var Willpower: int = 100;
@export var StartingEffects: Array[Effect] = [];
@export var StartingEffectCounters: PackedInt32Array = [];
var Effects: Array[EffectMarker] = [];


func _ready():
	for ID in range(min(StartingEffects.size(), StartingEffectCounters.size())):
		Effects.append(EffectMarker.new(self, StartingEffects[ID], StartingEffectCounters[ID]));


func ChangeKindness(Change: int, Cause = null) -> void:
	Kindness += Change;
	var ReactionBatch: BatchCoroutines = BatchCoroutines.new();
	if Cause != null and Cause is Action:
		KindnessActivelyChanged.emit(self, Change, Cause, ReactionBatch);
	else:
		KindnessPassivelyChanged.emit(self, Change, Cause, ReactionBatch);
	ReactionBatch.RunCoroutines();
	await ReactionBatch.WaitForAllCoroutines();


func ChangeWillpower(Change: int, Cause = null) -> void:
	Willpower += Change;
	var ReactionBatch: BatchCoroutines = BatchCoroutines.new();
	if Cause != null and Cause is Action:
		WillpowerActivelyChanged.emit(self, Change, Cause, ReactionBatch);
	else:
		WillpowerPassivelyChanged.emit(self, Change, Cause, ReactionBatch);
	ReactionBatch.RunCoroutines();
	await ReactionBatch.WaitForAllCoroutines();


func TurnStart() -> void:
	for Marker in Effects:
		await Marker.TurnStart();


func AddEffect(effect: Effect, EffectCount: int, Cause = null) -> void:
	var Marker: EffectMarker = EffectMarker.new(self, effect, EffectCount);
	AddEffectMarker(Marker, Cause);


func AddEffectMarker(Marker: EffectMarker, Cause = null) -> void:
	var i: int = 0;
	for marker in Effects:
		if marker.Behavior == Marker.Behavior:
			marker.Counter += Marker.Counter
			return
		elif marker.Behavior.Priority < Marker.Behavior.Priority:
			Effects.insert(i, Marker)
			break
		i += 1
	var ReactionBatch: BatchCoroutines = BatchCoroutines.new();
	if Cause != null and Cause is Action:
		EffectListActivelyChanged.emit(self, Marker, Cause, false, ReactionBatch);
	else:
		EffectListPassivelyChanged.emit(self, Marker, Cause, false, ReactionBatch);
	ReactionBatch.RunCoroutines();
	await ReactionBatch.WaitForAllCoroutines();


func RemoveEffect(effect: Effect, Cause = null) -> void:
	var Removed: bool = false;
	var i: int = 0;
	var Marker = null;
	for marker in Effects:
		if marker.Behavior == effect:
			Marker = marker;
			Effects.pop_at(i);
			Removed = true;
			break;
		i += 1;
	var ReactionBatch: BatchCoroutines = BatchCoroutines.new();
	if Removed:
		if Cause != null and Cause is Action:
			EffectListActivelyChanged.emit(self, Marker, Cause, true, ReactionBatch);
		else:
			EffectListPassivelyChanged.emit(self, Marker, Cause, true, ReactionBatch);
	ReactionBatch.RunCoroutines();
	await ReactionBatch.WaitForAllCoroutines();


func RemoveEffectMarker(Marker: EffectMarker, Cause = null) -> void:
	var Removed: bool = false;
	var i: int = 0;
	for marker in Effects:
		if marker == Marker:
			Effects.pop_at(i);
			Removed = true;
			break;
		i += 1;
	var ReactionBatch: BatchCoroutines = BatchCoroutines.new();
	if Removed:
		if Cause != null and Cause is Action:
			EffectListActivelyChanged.emit(self, Marker, Cause, true, ReactionBatch);
		else:
			EffectListPassivelyChanged.emit(self, Marker, Cause, true, ReactionBatch);
	ReactionBatch.RunCoroutines();
	await ReactionBatch.WaitForAllCoroutines();


func PerformAction(Targets: Array[Character], Intent: Intention) -> void:
	if Targets.size() == 0:
		return;
	
	var SubActionQueue: Array[Action] = [];
	for target in Targets:
		SubActionQueue.append(Action.new(self, target, Intent));
	
	var SubActionBatch: BatchCoroutines = BatchCoroutines.new();
	
	var ReactionBatch: BatchCoroutines = BatchCoroutines.new();
	for act in SubActionQueue:
		ActionStarted.emit(self, act, ReactionBatch);
# The User's Effects always activate before the Target's.
# It encourages proactivity.
		var EffectQueue: Array[EffectMarker] = Effects + act.Target.Effects;
		SubActionBatch.AddCoroutine(PerformSubAction.bind(EffectQueue));
	ReactionBatch.RunCoroutines();
	await ReactionBatch.WaitForAllCoroutines();
	
	SubActionBatch.RunCoroutines()
	await SubActionBatch.WaitForAllCoroutines();
	
	ReactionBatch.SetCoroutines([]);
	for act in SubActionQueue:
		ActionEnded.emit(self, act, ReactionBatch);
	ReactionBatch.RunCoroutines();
	await ReactionBatch.WaitForAllCoroutines();

func PerformSubAction(SubAction: Action, EffectQueue: Array[EffectMarker]):
	for effect in EffectQueue:
		await effect.ModifyAction(SubAction);
	await SubAction.Inflict();


func BecomePacified(Cause) -> void:
	var ReactionBatch: BatchCoroutines = BatchCoroutines.new();
	if Cause != null and Cause is Action:
		ActivelyPacified.emit(self, Cause, ReactionBatch);
	else:
		PassivelyPacified.emit(self, Cause, ReactionBatch);
	ReactionBatch.RunCoroutines();
	await ReactionBatch.WaitForAllCoroutines();	
	queue_free();


func Exit(Cause) -> void:
	var ReactionBatch: BatchCoroutines = BatchCoroutines.new();
	if Cause != null and Cause is Action:
		ActivelyExited.emit(self, Cause, ReactionBatch);
	else:
		PassivelyExited.emit(self, Cause, ReactionBatch);
	ReactionBatch.RunCoroutines();
	await ReactionBatch.WaitForAllCoroutines();	
	queue_free()


func CharacterActivelyPacified(Target: Character, Cause: Action) -> void:
	for Marker in Effects:
		await Marker.CharacterActivelyPacified(Target, Cause);


func CharacterActivelyExited(Target: Character, Cause: Action) -> void:
	for Marker in Effects:
		await Marker.CharacterActivelyExited(Target, Cause);


func CharacterPassivelyPacified(Target: Character, Cause: Effect) -> void:
	for Marker in Effects:
		await Marker.CharacterPassivelyPacified(Target, Cause);


func CharacterPassivelyExited(Target: Character, Cause: Effect) -> void:
	for Marker in Effects:
		await Marker.CharacterPassivelyExited(Target, Cause);


func CharacterActionStarted(Target: Character, Act: Action) -> void:
	for Marker in Effects:
		await Marker.CharacterActionStarted(Target, Act);


func CharacterActionEnded(Target: Character, Act: Action) -> void:
	for Marker in Effects:
		await Marker.CharacterActionEnded(Target, Act);


func CharacterKindnessActivelyChanged(Target: Character, Amount: int, Cause: Action) -> void:
	for Marker in Effects:
		await Marker.CharacterKindnessActivelyChanged(Target, Amount, Cause);


func CharacterWillpowerActivelyChanged(Target: Character, Amount: int, Cause: Action) -> void:
	for Marker in Effects:
		await Marker.CharacterKindnessActivelyChanged(Target, Amount, Cause);


func CharacterEffectListActivelyChanged(Target: Character, TargetedEffect: EffectMarker, Cause: Action, Removal: bool) -> void:
	for Marker in Effects:
		await Marker.CharacterEffectListActivelyChanged(Target, TargetedEffect, Cause, Removal);


func CharacterKindnessPassivelyChanged(Target: Character, Amount: int, Cause: Effect) -> void:
	for Marker in Effects:
		await Marker.CharacterKindnessPassivelyChanged(Target, Amount, Cause);


func CharacterWillpowerPassivelyChanged(Target: Character, Amount: int, Cause: Effect) -> void:
	for Marker in Effects:
		await Marker.CharacterWillpowerPassivelyChanged(Target, Amount, Cause);


func CharacterEffectListPassivelyChanged(Target: Character, TargetedEffect: EffectMarker, Cause: Effect, Removal: bool) -> void:
	for Marker in Effects:
		await Marker.CharacterEffectListPassivelyChanged(Target, TargetedEffect, Cause, Removal);


func TurnEnd() -> void:
	for Marker in Effects:
		await Marker.TurnEnd();



func EffectMarkerPrioritySort(a: EffectMarker, b: EffectMarker) -> bool:
	return a.Behavior.Priority > b.Behavior.Priority;
