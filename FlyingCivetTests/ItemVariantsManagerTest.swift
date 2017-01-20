import XCTest

class ItemVariantsManagerTest: XCTestCase {

    private func makeVariant(name: String, type: ItemVariantType) -> ItemVariant {
        return ItemVariant(
            name: name,
            type: type
        )
    }

    func testNumberOfVariants() {
        let variants = [
            makeVariant(name: "Normal", type: .Milk),
            makeVariant(name: "Normal", type: .Strength),
            makeVariant(name: "Gau", type: .Strength)
        ]

        let manager = ItemVariantsManager(variants: variants)

        XCTAssertEqual(1, manager.numberOfVariants(section: 0))
        XCTAssertEqual(2, manager.numberOfVariants(section: 1))
    }

    func testGetItemVariant() {
        let variants = [
            makeVariant(name: "foo", type: .Milk)
        ]

        let manager = ItemVariantsManager(variants: variants)
        let indexPath = IndexPath(row: 0, section: 0)
        let actualVariant = manager.getItemVariant(indexPath: indexPath)
        let expectedVariant = makeVariant(name: "foo", type: ItemVariantType.Milk)
        XCTAssertEqual(expectedVariant, actualVariant)
    }

    func testGetVariantType() {
        let variants = [
            makeVariant(name: "foo", type: .Milk)
        ]

        let manager = ItemVariantsManager(variants: variants)
        let actualVariant = manager.getVariantType(section: 0)
        let expectedVariant = ItemVariantType.Milk
        XCTAssertEqual(expectedVariant, actualVariant)
    }

    func testChooseVariant() {
        let variants = [
            makeVariant(name: "foo", type: .Milk)
        ]

        let manager = ItemVariantsManager(variants: variants)
        let indexPath = IndexPath(row: 0, section: 0)

        XCTAssertTrue(manager.chosenVariants.count == 0)
        manager.chooseVariant(indexPath: indexPath)
        XCTAssertTrue(manager.chosenVariants.count == 1)

        let actualVariant = manager.getItemVariant(indexPath: indexPath)
        let expectedVariant = manager.chosenVariants.first
        XCTAssertEqual(expectedVariant, actualVariant)
    }

    func testChooseVariant_switchesToADifferentType() {
        let evapVariant = makeVariant(name: "Evaporated", type: .Milk)
        let evapIndexPath = IndexPath(row: 1, section: 0)

        let blackVariant = makeVariant(name: "Black", type: .Milk)
        let blackIndexPath = IndexPath(row: 2, section: 0)

        let variants = [
            makeVariant(name: "Normal", type: .Milk),
            evapVariant,
            blackVariant
        ]

        let manager = ItemVariantsManager(variants: variants)
        manager.chooseVariant(indexPath: evapIndexPath)

        XCTAssertTrue(manager.chosenVariants.count == 1)
        XCTAssertTrue(manager.chosenVariants[0] == evapVariant)

        manager.chooseVariant(indexPath: blackIndexPath)
        XCTAssertTrue(manager.chosenVariants.count == 1)
        XCTAssertTrue(manager.chosenVariants[0] == blackVariant)
    }

    func testChooseVariant_handlesMultipleSections() {
        let variants = [
            makeVariant(name: "Normal", type: .Milk),
            makeVariant(name: "Black", type: .Milk),
            makeVariant(name: "Gau", type: .Strength),
            makeVariant(name: "Poh", type: .Strength)
        ]

        let manager = ItemVariantsManager(variants: variants)
        let blackIndexPath = IndexPath(row: 1, section: 0)
        let pohIndexPath = IndexPath(row: 1, section: 1)

        manager.chooseVariant(indexPath: blackIndexPath)
        manager.chooseVariant(indexPath: pohIndexPath)
        XCTAssertTrue(manager.chosenVariants.count == 2)

        let expectedVariants = [variants[1], variants[3]]

        XCTAssertEqual(expectedVariants, manager.chosenVariants)
    }
}
