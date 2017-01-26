import XCTest

class PresenterTest: XCTestCase {

    var fakeToastItem: MenuItem?

    override func setUp() {
        fakeToastItem = makeMenuItem(name: "fake-kaya-toast", type: .Toast)
    }

    override func tearDown() {
        fakeToastItem = nil
    }

    func testPresentingMenuItem() {
        let presenter = Presenter(item: fakeToastItem!)

        XCTAssertEqual("fake-kaya-toast", presenter.name)
        XCTAssertNil(presenter.quantity)
        XCTAssertNil(presenter.subtitle)
    }

    func testPresentingOrderItem_withoutVariants() {
        let fakeToastOrder = makeOrderItem(item: fakeToastItem!, variants: [], quantity: 1)
        let presenter = Presenter(item: fakeToastOrder)

        XCTAssertEqual("fake-kaya-toast", presenter.name)
        XCTAssertEqual(1, presenter.quantity)
        XCTAssertEqual("Traditional", presenter.subtitle)
    }

}
