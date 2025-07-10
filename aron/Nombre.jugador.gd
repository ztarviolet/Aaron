extends Node

var nombre: String = ""
var nivel: int = 0

var save_path := "user://save_game.dat"

# Guarda los datos actuales en un archivo
func save_game():
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	if save_file:
		var data = {
			"nombre": nombre,
			"progreso": nivel
		}
		save_file.store_var(data)
		save_file = null
		print("✅ Juego guardado correctamente.")
	else:
		print("❌ No se pudo abrir el archivo para guardar.")

# Carga los datos del archivo y actualiza las variables
func load_game():
	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path, FileAccess.READ)
		if save_file:
			var data = save_file.get_var()
			nombre = data.get("nombre", "")
			nivel = data.get("progreso", 0)
			save_file = null
			print("✅ Juego cargado: Nombre =", nombre, "Nivel =", nivel)
		else:
			print("❌ No se pudo abrir el archivo para cargar.")
	else:
		print("⚠️ No se encontró archivo guardado.")
