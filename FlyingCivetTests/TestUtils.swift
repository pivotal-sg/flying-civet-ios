import Foundation

let DEFAULT_FOO_VARIANT = ItemVariant(
    name: "foo", detailedName: "detailed foo", type: .Milk)

func makeMenuItem(name: String, type: ItemType) -> MenuItem {
    return MenuItem(name: name,
                    detailedName: name,
                    type: type,
                    variants: [DEFAULT_FOO_VARIANT])
}

func makeOrderItem(item: MenuItem,
                   variants: [ItemVariant] = [DEFAULT_FOO_VARIANT],
                   quantity: Int) -> OrderItem {
    return OrderItem(item: item,
                     variants: variants,
                     quantity: quantity)
}

