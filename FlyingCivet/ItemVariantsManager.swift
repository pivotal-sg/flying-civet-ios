import Foundation

class ItemVariantsManager {

    var variants: [ItemVariant]!
    var variantTypes: [ItemVariantType]!

    var chosenVariants = [ItemVariant]()

    init(variants: [ItemVariant]) {
        self.variants = variants
        self.variantTypes = variants
            .map { $0.type }
            .reduce([]) { acc, variantType in
                return acc.contains(variantType) ? acc : acc + [ variantType ]
        }
    }

    func getItemVariant(indexPath: IndexPath) -> ItemVariant {
        let itemVariants = getItemVariants(section: indexPath.section)
        return itemVariants[indexPath.row]
    }

    func numberOfVariants(section: Int) -> Int {
        return getItemVariants(section: section).count
    }

    func getVariantType(section: Int) -> ItemVariantType {
        return variantTypes[section]
    }

    func chooseVariant(indexPath: IndexPath) {
        let selectedVariant = getItemVariant(indexPath: indexPath)
        var newChosenVariants = chosenVariants.filter { $0.type != selectedVariant.type }
        newChosenVariants.append(selectedVariant)
        chosenVariants = newChosenVariants
    }

    func variantSelected(variant: ItemVariant) -> Bool {
        return chosenVariants.contains(variant)
    }

    private func getItemVariants(section: Int) -> [ItemVariant] {
        return variants.filter { $0.type == variantTypes[section] }
    }

}
