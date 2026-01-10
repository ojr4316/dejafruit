class_name UI extends CanvasLayer

@onready var interact_text: RichTextLabel = $InteractText
@onready var interactor: TextureRect = $interactor

func _ready():
	hide_interactor()

func hide_interactor():
	interactor.visible = false
	interact_text.visible = false

func show_interactor(text:="Interact"):
	interactor.visible = true
	interact_text.visible = true
	interact_text.text = text
