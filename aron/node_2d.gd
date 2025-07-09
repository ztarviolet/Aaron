extends Node

var server := TCPServer.new()
var client : StreamPeerTCP = null
var mensaje = ""
func _ready():
	server.listen(5050)
	print("Esperando conexión...")

func _process(_delta):
	# Aceptar nueva conexión
	if server.is_connection_available():
		client = server.take_connection()
		print("Cliente conectado.")

	# Leer datos del cliente si hay
	if client != null and client.get_status() == StreamPeerTCP.STATUS_CONNECTED:
		if client.get_available_bytes() > 0:
			mensaje = client.get_utf8_string(client.get_available_bytes()).strip_edges()
			print("Mensaje recibido:", mensaje)



func abrir():
	if client:
		client.put_utf8_string("START\n")
		print("Señal de inicio enviada.")

func cerrar():
	if client:
		client.put_utf8_string("STOP\n")
		print("Señal de detención enviada.")

func iniciar_programa_python():
	var exe_path = ProjectSettings.globalize_path("res://dist/aron/aron.exe")
	if FileAccess.file_exists(exe_path):
		var result = OS.create_process("cmd.exe", ["/C", exe_path])
		print("aron.exe iniciado. Resultado: ", result)
	else:
		push_error("No se encontró aron.exe en: " + exe_path)

# Botón para iniciar detección (START)
func _on_button_pressed():
	abrir()

# Botón para detener detección (STOP)
func _on_button_2_pressed():
	cerrar()

# Botón para iniciar el ejecutable Python
#func _on_button_3_pressed():
	#iniciar_programa_python()
