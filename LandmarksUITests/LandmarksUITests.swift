import XCTest
import Fakery
import OSLog

final class LandmarksUITests: XCTestCase {

  let app = XCUIApplication()
  
  let faker = Faker()
  let contactsApp = XCUIApplication(bundleIdentifier: "com.apple.MobileAddressBook")
  let settingsApp = XCUIApplication(bundleIdentifier: "com.apple.Preferences")

  override func setUp() {
    app.launch()
  }
  
  func testCreateContacts() throws {
    contactsApp.activate()
    createContact()
    createContact()
  }
  
  func testListViewsInSettings() {
    let TAG = "TEST"
    let app = settingsApp
    let text = "Screen Time"
    app.activate()
    
    NSLog("OS VERSSSSIOON: \((UIDevice.current.systemVersion as NSString).floatValue)")
    
    // let elements = app.descendants(matching: .any)["Screen Time"].otherElements.allElementsBoundByIndex
    
    
    let format = """
      label == %@
      """
    let predicate = NSPredicate(format: format, text)
    let elements = app.descendants(matching: .any).matching(predicate).allElementsBoundByIndex

    let views = elements.map { xcuielement in
      NSLog("\(TAG): label: \(xcuielement.label), title: \(xcuielement.title), ident: \(xcuielement.identifier), type: \(xcuielement.elementType)")
      NSLog("\(TAG): type:")
      
      return xcuielement.label
    }
    
    NSLog("\(TAG): found \(views.count) views")
  }
  
  private func createContact() -> String {
    let firstName = faker.name.firstName()
    let lastName = faker.name.lastName()
    
    contactsApp.descendants(matching: .any)["Add"].tap()
    
    contactsApp.textFields.element(boundBy: 0).tap()
    contactsApp.textFields.element(boundBy: 0).typeText(firstName)
    
    contactsApp.textFields.element(boundBy: 1).tap()
    contactsApp.textFields.element(boundBy: 1).typeText(lastName)
    
    contactsApp.textFields.element(boundBy: 2).tap()
    contactsApp.textFields.element(boundBy: 2).typeText("\(faker.company.name())\n")
    
    contactsApp.descendants(matching: .any)["add phone"].firstMatch.tap()
    contactsApp.textFields["Phone"].typeText("\(faker.phoneNumber.cellPhone())\n")
    
    contactsApp.descendants(matching: .any)["add email"].firstMatch.tap()
    contactsApp.textFields["Email"].typeText(faker.internet.email())
    
    contactsApp.descendants(matching: .any)["Done"].tap()
    
    // go back
    contactsApp.descendants(matching: .any)["iPhone"].tap()
    
    return "\(firstName) \(lastName)"
  }
  
  func createNewContact(firstName: String, lastName: String) {
    
  }
  
  // This is a fix for webview_leancode_test.dart that should be made to package:patrol
  func testPatrolExampleApp() throws {
    let patrolApp = XCUIApplication(bundleIdentifier: "pl.leancode.patrol.Example")
    patrolApp.activate()
    patrolApp.descendants(matching: .any)["Open webview (LeanCode)"].tap()
    // patrolApp.descendants(matching: .any)["Accept cookies"].tap()
    patrolApp.descendants(matching: .any).matching(identifier: "What do you do in IT?").element(boundBy: 1).tap()
    
    
    // patrolApp.descendants(matching: .any)["Developer"].firstMatch.tap()
    
    let arg = "Developer"
    let format = """
      identifier == %@ OR \
      title == %@ OR \
      label == %@ OR \
      value == %@ OR \
      placeholderValue == %@
      """
    let predicate = NSPredicate(format: format, arg, arg, arg, arg, arg)
    let element = patrolApp.descendants(matching: .any).matching(predicate)
    element.firstMatch.tap()
    
    patrolApp.descendants(matching: .any).matching(identifier: "What do you do in IT?").element(boundBy: 1).tap()
    
  }

  func testNormal() throws {
    let element = app.descendants(matching: .any)["Turtle Rock"]
    element.firstMatch.tap()
  }

  func testNormalIdentifer() throws {
    let element = app.descendants(matching: .any).matching(identifier: "Turtle Rock")
    element.firstMatch.tap()
  }

  func testNormalContains() throws {
    // Recreating XCUIElementQuery.subscript(key: String)
    //
    // key:
    // A string to match against any one of each element’s identifying properties:
    // identifier, title, label, value, or placeholderValue.
    let arg = "Siema"
    let format = """
      identifier CONTAINS %@ OR \
      title CONTAINS %@ OR \
      label CONTAINS %@ OR \
      value CONTAINS %@ OR \
      placeholderValue CONTAINS %@
      """
    let predicate = NSPredicate(format: format, arg, arg, arg, arg, arg)
    let element = app.descendants(matching: .any).matching(predicate)
    element.firstMatch.tap()
  }

  func testPredicates() throws {
    let element = app.descendants(matching: .any).matching(
      NSPredicate(format: "label == 'Turtle Rock'"))
    element.firstMatch.tap()
  }

  func testTextFieldNormal() throws {
    let element = app.textFields["username"]
    element.firstMatch.tap()
    element.firstMatch.typeText("hello")
  }

  func testStaticTextPredicate() throws {
    let element = app.descendants(matching: .any).element(
      matching: (NSPredicate(format: "label == 'Turtle Rock'")))
    element.firstMatch.tap()
  }

  func testTextFieldNormal2() throws {
    let element = app.descendants(matching: .any).element(
      matching: (NSPredicate(format: "placeholderValue == 'username'")))
    element.firstMatch.tap()
    element.firstMatch.typeText("hello")
  }

  func testTextFieldNormal3() throws {
    let element = app.descendants(matching: .any).element(
      matching: (NSPredicate(format: "elementType == 49")))
    element.firstMatch.tap()
    element.firstMatch.typeText("hello")
  }

  func testTextFields() throws {
    let textFieldPredicate = NSPredicate(format: "elementType == 49")
    let secureTextFieldPredicate = NSPredicate(format: "elementType == 50")
    let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [
      textFieldPredicate, secureTextFieldPredicate,
    ])

    let textFields = app.descendants(matching: .any).matching(predicate)

    textFields.element(boundBy: 0).tap()
    textFields.element(boundBy: 0).typeText("bartek")

    textFields.element(boundBy: 1).firstMatch.tap()
    textFields.element(boundBy: 1).firstMatch.typeText("ny4ncat")
  }
}
