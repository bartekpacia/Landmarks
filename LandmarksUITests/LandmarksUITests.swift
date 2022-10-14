import XCTest

final class LandmarksUITests: XCTestCase {
  
  let app = XCUIApplication()
  
  override func setUpWithError() throws {
    continueAfterFailure = false
    app.launch()
  }
  
  func testNormal() throws {
    let element = app.descendants(matching: .any)["Turtle Rock"]
    element.firstMatch.tap()
  }
  
  func testPredicates() throws {
    let element = app.descendants(matching: .any).matching(NSPredicate(format: "label == 'Turtle Rock'"))
    element.firstMatch.tap()
  }
  
  func testTextFieldNormal() throws {
    let element = app.textFields["username"]
    element.firstMatch.tap()
    element.firstMatch.typeText("hello")
  }
  
  func testStaticTextPredicate() throws {
    let element = app.descendants(matching: .any).element(matching: (NSPredicate(format: "label == 'Turtle Rock'")))
    element.firstMatch.tap()
  }
  
  func testTextFieldNormal2() throws {
    let element = app.descendants(matching: .any).element(matching: (NSPredicate(format: "placeholderValue == 'username'")))
    element.firstMatch.tap()
    element.firstMatch.typeText("hello")
  }
  
  func testTextFieldNormal3() throws {
    let element = app.descendants(matching: .any).element(matching: (NSPredicate(format: "elementType == 49")))
    element.firstMatch.tap()
    element.firstMatch.typeText("hello")
  }
  
  func testTextFields() throws {
    let textFieldPredicate = NSPredicate(format: "elementType == 49")
    let secureTextFieldPredicate = NSPredicate(format: "elementType == 50")
    let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [textFieldPredicate, secureTextFieldPredicate])
    
    let textFields = app.descendants(matching: .any).matching(predicate)
    
    textFields.element(boundBy: 0).tap()
    textFields.element(boundBy: 0).typeText("bartek")
    
    textFields.element(boundBy: 1).firstMatch.tap()
    textFields.element(boundBy: 1).firstMatch.typeText("ny4ncat")
  }
}
