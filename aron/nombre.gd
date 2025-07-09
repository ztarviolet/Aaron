extends Node

var letras_imagenes = {}
var letras_en_imagen = []
var indice_letra = 0
var controlador  # Referencia al nodo que contiene la variable 'mensaje'

func _ready():
	cargar_letras()
	controlador = get_node("Node2D")  # Asegúrate de que la ruta sea correcta

func _process(delta: float) -> void:
	var texto = $LineEdit.text.to_lower()
	
	# Verificar que el texto no esté vacío y que el índice esté dentro del rango
	if texto == "" or indice_letra >= texto.length():
		return

	var letra_actual = texto[indice_letra]
	var mensaje = controlador.mensaje.to_lower()

	# Verifica también que el mensaje tenga suficiente longitud
	if indice_letra < mensaje.length() and letra_actual == mensaje[indice_letra]:
		avanzar_si_coincide()

func cargar_letras():
	var extensiones = [".png", ".jpg", ".jpeg"]
	for letra in "abcdefghijklmnopqrstuvwxyz":
		for ext in extensiones:
			var ruta = "res://letras/%s%s" % [letra, ext]
			if FileAccess.file_exists(ruta):
				letras_imagenes[letra] = load(ruta)
				break

func _on_button_pressed() -> void:
	letras_en_imagen.clear()
	indice_letra = 0
	controlador.abrir()  # Asegúrate que este método exista en el nodo "Node2D"

	var texto = $LineEdit.text.to_lower()
	for letra in texto:
		if letra in letras_imagenes:
			letras_en_imagen.append(letras_imagenes[letra])
		else:
			letras_en_imagen.append(null)

	if letras_en_imagen.size() > 0:
		mostrar_letra(indice_letra)

func mostrar_letra(index):
	if index < letras_en_imagen.size():
		var imagen = letras_en_imagen[index]
		$TextureRect.texture = imagen
	else:
		print("Fin de la palabra")

func avanzar_si_coincide():
	indice_letra += 1
	if indice_letra < letras_en_imagen.size():
		mostrar_letra(indice_letra)
	else:
		print("Palabra completada")
