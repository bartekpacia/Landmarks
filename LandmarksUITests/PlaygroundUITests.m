@import XCTest;
@import ObjectiveC.runtime;
#import "Principal.h"

@interface PlagroundAlphaTests : XCTestCase
@end

@implementation PlagroundAlphaTests {
  XCUIApplication *app;
}

+ (void)setUp {
  NSLog(@"%@: class setUp()", NSStringFromClass([self class]));
}

- (void)setUp {
  NSLog(@"%@: instance setUp()", NSStringFromClass([self class]));
  app = [[XCUIApplication alloc] init];
  [app activate];
}

- (void)tearDown {
  NSLog(@"%@: instance tearDown()", NSStringFromClass([self class]));
  [app terminate];
}

+ (void)tearDown {
  NSLog(@"%@: class tearDown()", NSStringFromClass([self class]));
}

- (void)testAlpha {
  [app activate];
}

- (void)testBravo {
  [app activate];
}

- (void)testCharlie {
  [app activate];
}

@end
