class_name InventorySlot
extends Button

var item: Item  # Ссылка на ресурс предмета
var quantity: int = 0
@onready var icon: TextureRect = $Icon
@onready var quantity_text: Label = $QuantityText
var inventory: Inventory  # Ссылка на родительский инвентарь

func set_item(new_item: Item):
	item = new_item
	quantity = 1 if new_item else 0
	
	if item == null:
		icon.visible = false
	else:
		icon.visible = true
		icon.texture = item.icon
	
	update_quantity_text()

func update_quantity_text():
	if quantity <= 1:
		quantity_text.text = ""
	else:
		quantity_text.text = str(quantity)

func add_item():
	quantity += 1
	update_quantity_text()

func remove_item():
	quantity -= 1
	update_quantity_text()
	if quantity == 0:
		set_item(null)

# Клик для использования предмета
func _on_pressed():
	if item == null:
		return
	var remove_after_use = item._on_use(inventory.get_parent())  # Передаём игрока как родителя
	if remove_after_use:
		inventory.remove_item(item)
