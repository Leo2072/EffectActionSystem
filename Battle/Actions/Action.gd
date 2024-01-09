extends RefCounted
class_name Action # Container Class for Attacks to be Performed.
signal a

var User: Character;
var Target: Character;
var Intent: Intention;


func _init(user: Character, target: Character, intent: Intention):
	User = user;
	Target = target;
	Intent = intent.duplicate();


func Inflict() -> void:
	InflictEffect();
	Target.ChangeKindness(Intent.InflectedKindness);
	Target.ChangeWillpower(Intent.InflectedWillpower);


func InflictEffect() -> void:
	if Intent.InflictedEffect != null:
		var EffectTarget = Target;
		if Intent.InflictEffectOnUser:
			EffectTarget = User;
		for effect in User.Effects:
			if effect.Behavior == Intent.InflictedEffect:
				effect.EffectCounter += Intent.EffectCount;
		EffectTarget.Effects.append(EffectMarker.new(User, Intent.InflictedEffect, Intent.EffectCount));
