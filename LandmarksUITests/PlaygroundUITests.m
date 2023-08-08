@import XCTest;
@import ObjectiveC.runtime;

@interface PlagroundAlphaTests : XCTestCase
@end

@implementation PlagroundAlphaTests

+ (void)setUp {
  NSLog(@"%@: class setUp()", NSStringFromClass([self class]));
}

- (void)setUp {
  NSLog(@"%@: instance setUp()", NSStringFromClass([self class]));
}

- (void)tearDown {
  NSLog(@"%@: instance tearDown()", NSStringFromClass([self class]));
}

+ (void)tearDown {
  NSLog(@"%@: class tearDown()", NSStringFromClass([self class]));
}

- (void)testAddition {
  XCTAssertTrue(true, "addition works");
}

- (void)testSubtraction {
  XCTAssertTrue(true, "subtraction works");
}

@end

@interface PlagroundBravoTests : XCTestCase
@end

@implementation PlagroundBravoTests

+ (void)setUp {
  NSLog(@"%@: class setUp()", NSStringFromClass([self class]));
}

- (void)setUp {
  NSLog(@"%@: instance setUp()", NSStringFromClass([self class]));
}

- (void)tearDown {
  NSLog(@"%@: instance tearDown()", NSStringFromClass([self class]));
}

+ (void)tearDown {
  NSLog(@"%@: class tearDown()", NSStringFromClass([self class]));
}

- (void)testAddition {
  XCTAssertTrue(true, "addition works");
}

- (void)testSubtraction {
  XCTAssertTrue(true, "subtraction works");
}

@end
