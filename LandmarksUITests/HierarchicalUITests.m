@import XCTest;

@interface HierarchicalTests : XCTestCase
@end

@implementation HierarchicalTests

- (void)testExample {
  XCUIApplication *app = [[XCUIApplication alloc] init];
  [app activate];

  [XCTContext runActivityNamed:@"First group" block:^(id<XCTActivity> activity) {
    [XCTContext runActivityNamed:@"Alpha test" block:^(id<XCTActivity> activity) {}];
    [XCTContext runActivityNamed:@"Bravo test" block:^(id<XCTActivity> activity) {}];
  }];

  [XCTContext runActivityNamed:@"Second group" block:^(id<XCTActivity> activity) {
    [XCTContext runActivityNamed:@"Charlie test" block:^(id<XCTActivity> activity) {}];
    [XCTContext runActivityNamed:@"Delta test" block:^(id<XCTActivity> activity) {}];
  }];

  XCTAssertTrue(true, "works");
}

@end
