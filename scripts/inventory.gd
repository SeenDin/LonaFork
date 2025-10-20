class_name Inventory
extends Node

var slots: Array[InventorySlot] = []
@onready var window: Panel = $InventoryWindow
@onready var info_text: Label = $InventoryWindow/InfoText
@export var starter_items: Array[Item] = []  # Экспортируемый массив для стартовых предметов

func _ready():
	# Скрываем окно изначально
	toggle_window(false)
	
	# Назначаем слоты
	for child in $InventoryWindow/SlotContainer.get_children():
		slots.append(child)
		child.set_item(null)
		child.inventory = self
	
	# Добавляем стартовые предметы
	for item in starter_items:
		add_item(item)

func _process(delta):
	if Input.is_action_just_pressed("inventory"):  # Настройте действие "inventory" в Project Settings (например, Tab)
		toggle_window(!window.visible)

func toggle_window(open: bool):
	window.visible = open
	if open:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func add_item(item: Item):
	var slot = get_slot_to_add(item)
	if slot == null:
		return  # Нет места
	if slot.item == null:
		slot.set_item(item)
	elif slot.item == item:  # Стек, если тот же предмет
		slot.add_item()

func remove_item(item: Item):
	var slot = get_slot_to_remove(item)
	if slot == null or slot.item != item:
		return
	slot.remove_item()

func get_slot_to_add(item: Item) -> InventorySlot:
	# Ищем стековый слот
	for slot in slots:
		if slot.item == item and slot.quantity < item.max_stack_size:
			return slot
	# Ищем пустой слот
	for slot in slots:
		if slot.item == null:
			return slot
	return null

func get_slot_to_remove(item: Item) -> InventorySlot:
	for slot in slots:
		if slot.item == item:
			return slot
	return null

func get_number_of_item(item: Item) -> int:
	var total = 0
	for slot in slots:
		if slot.item == item:
			total += slot.quantity
			return total
