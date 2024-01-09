extends RefCounted
class_name BatchCoroutines

# Signal Emitted when All Coroutines have Finished.
# If no Coroutines are Asynchronous, the Signal may be emitted before being Awaited.
signal AllCoroutinesCompleted


 # List of Coroutines with Binded Arguments to Wait for. 
var Coroutines: Array[Callable] = [];

func SetCoroutines(CoroutineBatch: Array[Callable]) -> void:
	if CompletedCoroutines.size() != Coroutines.size():
		push_warning("Awaited Coroutines have not Completed, and Cannot be Modified.");
		return;
	Coroutines = CoroutineBatch;
	CompletedCoroutines = range(Coroutines.size())
func AddCoroutine(Coroutine: Callable) -> void:
	if CompletedCoroutines.size() != Coroutines.size():
		push_warning("Awaited Coroutines have not Completed, and Cannot be Modified.");
		return;
	Coroutines.append(Coroutine);
	CompletedCoroutines.append(CompletedCoroutines.size());
func RemoveCoroutine(Index: int) -> void:
	if CompletedCoroutines.size() != Coroutines.size():
		push_warning("Awaited Coroutines have not Completed, and Cannot be Modified.");
		return;
	if Index > 0 and Index < Coroutines.size():
		Coroutines.remove_at(Index);
		CompletedCoroutines.remove_at(CompletedCoroutines.size() - 1);


var CompletedCoroutines: PackedInt32Array = []; 


func _init(CoroutineBatch: Array[Callable] = []) -> void:
	SetCoroutines(CoroutineBatch)


func RunCoroutines() -> void:
	if CompletedCoroutines.size() != Coroutines.size():
		push_warning("Awaited Coroutines have not Completed, and Cannot be Awaited.");
		return;
	CompletedCoroutines.resize(0);
	for CoroutineID in range(Coroutines.size()):
		AwaitCoroutine(CoroutineID);


func RunSelectCoroutines(CoroutineIDs: PackedInt32Array) -> void:
	if CompletedCoroutines.size() != Coroutines.size():
		push_warning("Awaited Coroutines have not Completed, and Cannot be Awaited.");
		return;
	var Pointer: int = 0;
	for CoroutineID in range(Coroutines.size()):
		if CoroutineID in CoroutineIDs:
			CompletedCoroutines.remove_at(Pointer);
			AwaitCoroutine(CoroutineID);
		else:
			Pointer += 1;


func WaitForAllCoroutines() -> void:
	while CompletedCoroutines.size() != Coroutines.size():
		var CompletedCoroutineID = await CoroutineCompleted;
	return;


func MarkCoroutineCompleted(CoroutineID: int) -> void:
	CompletedCoroutines.append(CoroutineID);
	if CompletedCoroutines.size() == Coroutines.size():
		AllCoroutinesCompleted.emit();


signal CoroutineCompleted(CoroutineID: int);
func AwaitCoroutine(CoroutineID: int) -> void:
	await Coroutines[CoroutineID].call();
	MarkCoroutineCompleted(CoroutineID);
	CoroutineCompleted.emit(CoroutineID);
