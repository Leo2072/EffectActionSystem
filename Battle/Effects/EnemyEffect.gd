extends Effect
class_name EnemyEffect


func CharacterKindnessActivelyChanged(Marker: EffectMarker, Target: Character, Amount: int, Cause: Action) -> void:
	if Target == Marker.User:
		if Amount < 0:
			await Target.get_tree().create_timer(1).timeout;
			print(Target.name + "'s Kindness reverted down by " + str(-Amount) + '...');
		elif Amount > 0:
			print(Target.name + ' felt a strange warmth bubbling from inside.');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			await print('...');
			await Target.get_tree().create_timer(2).timeout;
			print(Target.name + ' gained ' + str(Amount) + ' Kindness!')
			if Target.Kindness > Target.KindnessThreshold:
				await Target.get_tree().create_timer(1).timeout;
				print('...');
				await Target.get_tree().create_timer(2).timeout;
				print(Target.name + ' accepted your Kindness!')
				await Target.BecomePacified(Cause);
		else:
			print('Something occured.');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('Yet nothing changed...');


func CharacterWillpowerActivelyChanged(Marker: EffectMarker, Target: Character, Amount: int, Cause: Action) -> void:
	if Target == Marker.User:
		if Amount < 0:
			await Target.get_tree().create_timer(1).timeout;
			print(Target.name + "'s Willpower dropped by " + str(-Amount) + '...');
			if Target.Willpower <= 0:
				Target.Willpower = 0;
				await Target.get_tree().create_timer(1).timeout;
				print('...');
				await Target.get_tree().create_timer(2).timeout;
				print(Target.name + ' no longer wanted to be here...')
				await Target.Exit(Cause);
		elif Amount > 0:
			print(Target.name + ' felt a tremendous burst of power!');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			await print('...');
			await Target.get_tree().create_timer(2).timeout;
			print(Target.name + "'s Willpower was raised by " + str(Amount) + '!')
		else:
			print('Something occured.');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('Yet everything stayed the same...');


func CharacterKindnessPassivelyChanged(Marker: EffectMarker, Target: Character, Amount: int, Cause: Effect) -> void:
	if Target == Marker.User:
		if Amount < 0:
			await Target.get_tree().create_timer(1).timeout;
			print(Target.name + "'s Kindness reverted down by " + str(-Amount) + '...');
		elif Amount > 0:
			print(Target.name + ' felt a strange warmth bubbling from inside.');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			await print('...');
			await Target.get_tree().create_timer(2).timeout;
			print(Target.name + ' gained ' + str(Amount) + ' Kindness!')
			if Target.Kindness > Target.KindnessThreshold:
				await Target.get_tree().create_timer(1).timeout;
				print('...');
				await Target.get_tree().create_timer(2).timeout;
				print(Target.name + ' accepted your Kindness!')
				await Target.BecomePacified(Cause);
		else:
			print('Something occured.');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('Yet nothing changed...');


func CharacterWillpowerPassivelyChanged(Marker: EffectMarker, Target: Character, Amount: int, Cause: Effect) -> void:
	if Target == Marker.User:
		if Amount < 0:
			await Target.get_tree().create_timer(1).timeout;
			print(Target.name + "'s Willpower dropped by " + str(-Amount) + '...');
			if Target.Willpower <= 0:
				Target.Willpower = 0;
				await Target.get_tree().create_timer(1).timeout;
				print('...');
				await Target.get_tree().create_timer(2).timeout;
				print(Target.name + ' no longer wanted to be here...')
				await Target.Exit(Cause);
		elif Amount > 0:
			print(Target.name + ' felt a tremendous burst of power!');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			await print('...');
			await Target.get_tree().create_timer(2).timeout;
			print(Target.name + "'s Willpower was raised by " + str(Amount) + '!')
		else:
			print('Something occured.');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('Yet everything stayed the same...');
