extends Effect
class_name PlayerEffect


func CharacterKindnessActivelyChanged(Marker: EffectMarker, Target: Character, Amount: int, Cause: Action) -> void:
	if Target == Marker.User:
		if Amount < 0:
			print('You took ' + str(-Amount) + ' Insult Damage!');
			await Target.get_tree().create_timer(2).timeout;
			print('It hurt, but still, you tried.');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			if Target.Kindness <= 0:
				Target.Kindness = 0;
				print('You could no longer move on.')
				Marker.User.Exit(Cause);
			else:
				print('Once again, you got up.')
		elif Amount > 0:
			print('You felt a strange warmth bubbling from inside.');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('You gained ' + str(Amount) + ' Kindness!')
		else:
			print('Something had changed?');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('You steeled your resolve!');
			await Target.get_tree().create_timer(0.5).timeout;
			print("You will share the kindness you have been shown!")
			await Target.get_tree().create_timer(1).timeout;
			print('(So nothing has changed.)')
	else:
		if Amount > 0:
			print('Though not much, you could feel their joy.')
			await Target.get_tree().create_timer(1).timeout;
			print('That alone was more than enough to keep going!')
			await Marker.User.ChangeWillpower(10, self);
		elif Amount < 0:
			print('They seemed more hateful by the moment...')
			await Target.get_tree().create_timer(1).timeout;
			print('Could what you had done been wrong?')
			await Target.get_tree().create_timer(1).timeout;
			print('...')
			await Target.get_tree().create_timer(2).timeout;
			print('Maybe you could not tell anymore...')
			await Marker.User.ChangeWillpower(-5, self);


func CharacterWillpowerActivelyChanged(Marker: EffectMarker, Target: Character, Amount: int, Cause: Action) -> void:
	if Target == Marker.User:
		if Amount < 0:
			print('Your Willpower wavered by ' + str(-Amount) + '...');
			await Target.get_tree().create_timer(2).timeout;
			print('You no longer wanted to move.');
			await Target.get_tree().create_timer(2).timeout;
			print('Yet...');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			if Target.Willpower <= 1:
				Target.Willpower = 1;
				print('You refused to give up here.');
			else:
				print('Once again, you got up.');
		elif Amount > 0:
			print('A vague recollection surfaced in your mind.');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('You gained ' + str(Amount) + ' Willpower!')
		else:
			print('Something had changed?');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('You reaffirmed your decision!');
			await Target.get_tree().create_timer(0.5);
			print('You will never stop being kind!')
			await Target.get_tree().create_timer(1);
			print('(So nothing had changed.)')


func CharacterKindnessPassivelyChanged(Marker: EffectMarker, Target: Character, Amount: int, Cause: Effect) -> void:
	if Target == Marker.User:
		if Amount < 0:
			print('You took ' + str(-Amount) + ' Insult Damage!');
			await Target.get_tree().create_timer(2).timeout;
			print('It hurt, but still, you tried.');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			if Target.Kindness <= 0:
				Target.Kindness = 0;
				print('You could no longer move on.')
				Marker.User.Exit(Cause);
			else:
				print('Once again, you got up.')
		elif Amount > 0:
			print('You felt a strange warmth bubbling from inside.');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('You gained ' + str(Amount) + ' Kindness!')
		else:
			print('Something had changed?');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('You steeled your resolve!');
			await Target.get_tree().create_timer(0.5).timeout;
			print("You will share the kindness you have been shown!")
			await Target.get_tree().create_timer(1).timeout;
			print('(So nothing has changed.)')
	else:
		if Amount > 0:
			print('Though not much, you could feel their joy.')
			await Target.get_tree().create_timer(1).timeout;
			print('That alone was more than enough to keep going!')
			await Marker.User.ChangeWillpower(10, self);
		elif Amount < 0:
			print('They seemed more hateful by the moment...')
			await Target.get_tree().create_timer(1).timeout;
			print('Could something you had done been wrong?')
			await Target.get_tree().create_timer(1).timeout;
			print('...')
			await Target.get_tree().create_timer(2).timeout;
			print('You could not tell...')
			await Marker.User.ChangeWillpower(-5, self);


func CharacterWillpowerPassivelyChanged(Marker: EffectMarker, Target: Character, Amount: int, Cause: Effect) -> void:
	if Target == Marker.User:
		if Amount < 0:
			print('Your Willpower wavered by ' + str(-Amount) + '...');
			await Target.get_tree().create_timer(2).timeout;
			print('You no longer wanted to move.');
			await Target.get_tree().create_timer(2).timeout;
			print('Yet...');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			if Target.Willpower <= 1:
				Target.Willpower = 1;
				print('You refused to give up here.');
			else:
				print('Once again, you got up.');
		elif Amount > 0:
			print('A vague recollection surfaced in your mind.');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('You gained ' + str(Amount) + ' Willpower!')
		else:
			print('Something had changed?');
			await Target.get_tree().create_timer(2).timeout;
			print('...');
			await Target.get_tree().create_timer(2).timeout;
			print('You reaffirmed your decision!');
			await Target.get_tree().create_timer(0.5);
			print('You will never stop being kind!')
			await Target.get_tree().create_timer(1);
			print('(So nothing had changed.)')


func CharacterActivelyPacified(Marker: EffectMarker, Target: Character, Cause: Action) -> void:
	if Target != Marker.User:
		print('You made a new friend!');
		await Target.get_tree().create_timer(1).timeout;
		await Marker.User.ChangeWillpower(10, self);


func CharacterPassivelyPacified(Marker: EffectMarker, Target: Character, Cause: Effect) -> void:
	if Target != Marker.User:
		print('You made a new friend!');
		await Target.get_tree().create_timer(1).timeout;
		await Marker.User.ChangeWillpower(10, self);
