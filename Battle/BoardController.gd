extends Node2D


func DistributeActivelyPacifiedSignal(User: Character, Cause: Action, WaitBatch: BatchCoroutines) -> void:
	for character in Characters:
		WaitBatch.AddCoroutine(character.CharacterActivelyPacified.bind(User, Cause));

func DistributeActivelyExitedSignal(User: Character, Cause: Action, WaitBatch: BatchCoroutines) -> void:
	for character in Characters:
		WaitBatch.AddCoroutine(character.CharacterActivelyExited.bind(User, Cause));

func DistributePassivelyPacifiedSignal(User: Character, Cause: Effect, WaitBatch: BatchCoroutines) -> void:
	for character in Characters:
		WaitBatch.AddCoroutine(character.CharacterPassivelyPacified.bind(User, Cause));

func DistributePassivelyExitedSignal(User: Character, Cause: Effect, WaitBatch: BatchCoroutines) -> void:
	for character in Characters:
		WaitBatch.AddCoroutine(character.CharacterPassivelyExited.bind(User, Cause));

func DistributeActionStartedSignal(User: Character, Act: Action, WaitBatch: BatchCoroutines) -> void:
	for character in Characters:
		WaitBatch.AddCoroutine(character.CharacterActionStarted.bind(User, Act));

func DistributeActionEndedSignal(User: Character, Act: Action, WaitBatch: BatchCoroutines) -> void:
	for character in Characters:
		WaitBatch.AddCoroutine(character.CharacterActionEnded.bind(User, Act));

func DistributeKindnessActivelyChangedSignal(User: Character, Amount: int, Cause: Action, WaitBatch: BatchCoroutines) -> void:
	for character in Characters:
		WaitBatch.AddCoroutine(character.CharacterKindnessActivelyChanged.bind(User, Amount, Cause));

func DistributeWillpowerActivelyChangedSignal(User: Character, Amount: int, Cause: Action, WaitBatch: BatchCoroutines) -> void:
	for character in Characters:
		WaitBatch.AddCoroutine(character.CharacterWillpowerActivelyChanged.bind(User, Amount, Cause));

func DistributeEffectListActivelyChangedSignal(User: Character, Marker: EffectMarker, Cause: Action, Removal: bool, WaitBatch: BatchCoroutines) -> void:
	for character in Characters:
		WaitBatch.AddCoroutine(character.CharacterEffectListActivelyChanged.bind(User, Marker, Cause, Removal));

func DistributeKindnessPassivelyChangedSignal(User: Character, Amount: int, Cause: Effect, WaitBatch: BatchCoroutines) -> void:
	for character in Characters:
		WaitBatch.AddCoroutine(character.CharacterKindnessPassivelyChanged.bind(User, Amount, Cause));

func DistributeWillpowerPassivelyChangedSignal(User: Character, Amount: int, Cause: Effect, WaitBatch: BatchCoroutines) -> void:
	for character in Characters:
		WaitBatch.AddCoroutine(character.CharacterWillpowerPassivelyChanged.bind(User, Amount, Cause));

func DistributeEffectListPassivelyChangedSignal(User: Character, Marker: EffectMarker, Cause: Effect, Removal: bool, WaitBatch: BatchCoroutines) -> void:
	for character in Characters:
		WaitBatch.AddCoroutine(character.CharacterEffectListPassivelyChanged.bind(User, Marker, Cause, Removal));


var Characters: Array[Character] = [];


func _ready():
	for child in get_children():
		if child is Character:
			Characters.append(child);
			child.ActivelyPacified.connect(DistributeActivelyPacifiedSignal);
			child.ActivelyExited.connect(DistributeActivelyExitedSignal);
			child.PassivelyPacified.connect(DistributePassivelyPacifiedSignal);
			child.PassivelyExited.connect(DistributePassivelyExitedSignal);
			child.ActionStarted.connect(DistributeActionStartedSignal);
			child.ActionEnded.connect(DistributeActionEndedSignal);
			child.KindnessActivelyChanged.connect(DistributeKindnessActivelyChangedSignal);
			child.WillpowerActivelyChanged.connect(DistributeWillpowerActivelyChangedSignal);
			child.EffectListActivelyChanged.connect(DistributeEffectListActivelyChangedSignal);
			child.KindnessPassivelyChanged.connect(DistributeKindnessPassivelyChangedSignal);
			child.WillpowerPassivelyChanged.connect(DistributeWillpowerPassivelyChangedSignal);
			child.EffectListPassivelyChanged.connect(DistributeEffectListPassivelyChangedSignal);



var AffectKindness: bool = true;
var TurnEnded: bool = true;
var GameOver: bool = false;
func _input(event):
	if GameOver:
		return;
	if get_child_count() != 2:
		GameOver = true;
		print("Game Ended.")
		return;

	if event.is_action_released("ui_accept"):
		if !TurnEnded:
			return;
		print("Your Stats:")
		print("\tKindness: " + str(Characters[0].Kindness))
		print("\tWillpower: " + str(Characters[0].Willpower) + '\n')
		print("test Dummy Stats:")
		print("\tKindness: " + str(Characters[1].Kindness))
		print("\tWillpower: " + str(Characters[1].Willpower) + '\n')
		if AffectKindness:
			print("Now Affecting: Kindness.\n")
		else:
			print("Now Affecting: Willpower.\n")
	
	if event.is_action_pressed("ui_cancel"):
		if !TurnEnded:
			return;
		AffectKindness = !AffectKindness;
		if AffectKindness:
			print("Now Affecting: Kindness.\n")
		else:
			print("Now Affecting: Willpower.\n")
	
	if event.is_action_released("ui_up"):
		if !TurnEnded:
			return;
		TurnEnded = false;
		print('Turn Started.')
		if AffectKindness:
			await Characters[0].ChangeKindness(10);
		else:
			await Characters[0].ChangeWillpower(10);
		print("Turn Ended.\n")
		TurnEnded = true;

	elif event.is_action_released("ui_down"):
		if !TurnEnded:
			return;
		TurnEnded = false;
		print('Turn Started.')
		if AffectKindness:
			await Characters[0].ChangeKindness(-10);
		else:
			await Characters[0].ChangeWillpower(-10);
		print("Turn Ended.\n")
		TurnEnded = true;

	elif event.is_action_released("ui_left"):
		if !TurnEnded:
			return;
		TurnEnded = false;
		print('Turn Started.')
		if AffectKindness:
			await Characters[1].ChangeKindness(10);
		else:
			await Characters[1].ChangeWillpower(10);
		print("Turn Ended.\n")
		TurnEnded = true;

	elif event.is_action_released("ui_right"):
		if !TurnEnded:
			return;
		TurnEnded = false;
		print('Turn Started.')
		if AffectKindness:
			await Characters[1].ChangeKindness(-10);
		else:
			await Characters[1].ChangeWillpower(-10);
		print("Turn Ended.\n")
		TurnEnded = true;
