@import XCTest;
@import ObjectiveC.runtime;

@interface ParametrizedTests : XCTestCase
@end

@implementation ParametrizedTests
+ (NSArray<NSInvocation *> *)testInvocations {
  NSLog(@"testInvocations() called");

  /* Prepare dummy input */
  __block NSMutableArray<NSString *> *dartTestFiles = [[NSMutableArray alloc] init];
  [dartTestFiles addObject:@"example_test"];
  [dartTestFiles addObject:@"permissions_location_test"];
  [dartTestFiles addObject:@"permissions_many_test"];

  NSMutableArray<NSInvocation *> *invocations = [[NSMutableArray alloc] init];

  NSLog(@"Before the loop, %lu elements in the array", (unsigned long)dartTestFiles.count);

  /* Create second class */
  Class newTestClass = objc_allocateClassPair([XCTestCase class], "DynamicTests", 0);

  for (int i = 0; i < dartTestFiles.count; i++) {
    /* Step 1 */

    NSString *name = dartTestFiles[i];

    void (^func)(ParametrizedTests *) = ^(ParametrizedTests *instance) {
      XCUIApplication* app = [[XCUIApplication alloc] init];
      [app launch];
      NSLog(@"func called!");
      XCTAssertTrue(true, "dummy assert");
      [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    };

    IMP implementation = imp_implementationWithBlock(func);
    NSString *selectorStr = [NSString stringWithFormat:@"test_%@", name];
    SEL selector = NSSelectorFromString(selectorStr);

    class_addMethod(self, selector, implementation, "v@:");
    class_addMethod(newTestClass, selector, implementation, "v@:");

    /* Step 2 */

    NSMethodSignature *signature = [self instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.selector = selector;

    NSLog(@"RunnerUITests.testInvocations(): selectorStr = %@", selectorStr);

    [invocations addObject:invocation];
  }

  objc_registerClassPair(newTestClass);

  NSLog(@"After the loop");


  return invocations;
}

@end
//@import XCTest;
//@import ObjectiveC.runtime;
//
//@interface ParametrizedTests : XCTestCase
//@end
//
//@implementation ParametrizedTests
//
//- (void)testTruthness {
//  NSLog(@"testTruthness called!");
//  XCTAssertTrue(true, @"true is true");
//}
//
//+ (NSArray<NSInvocation *> *)testInvocations {
//  NSLog(@"testInvocations() called");
//
//  /* Prepare dummy input */
//  __block NSMutableArray<NSString *> *dartTestFiles = [[NSMutableArray alloc] init];
//  [dartTestFiles addObject:@"example_test"];
//  [dartTestFiles addObject:@"permissions_location_test"];
//  [dartTestFiles addObject:@"permissions_many_test"];
//
//  NSMutableArray<NSInvocation *> *invocations = [[NSMutableArray alloc] init];
//
//  NSLog(@"Before the loop, %lu elements in the array", (unsigned long)dartTestFiles.count);
//
//
//  for (int i = 0; i < dartTestFiles.count; i++) {
//    /* Step 1 */
//
//    NSString *name = dartTestFiles[i];
//
//    void (^func)(ParametrizedTests *) = ^(ParametrizedTests *instance) {
//      XCUIApplication* app = [[XCUIApplication alloc] init];
//      [app launch];
//      NSLog(@"func called!");
//      XCTAssertTrue(true, "dummy assert");
//      [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
//    };
//
//    IMP implementation = imp_implementationWithBlock(func);
//    NSString *selectorStr = [NSString stringWithFormat:@"test_%@", name];
//    SEL selector = NSSelectorFromString(selectorStr);
//    class_addMethod(self, selector, implementation, "v@:");
//
//    /* Step 2 */
//
//    NSMethodSignature *signature = [self instanceMethodSignatureForSelector:selector];
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//    invocation.selector = selector;
//
//    NSLog(@"RunnerUITests.testInvocations(): selectorStr = %@", selectorStr);
//
//    [invocations addObject:invocation];
//  }
//
//  NSLog(@"After the loop");
//  
//  /* add statically-defined testTruthness() test method to testInvocation list */
//  
//  NSMethodSignature *signature = [self instanceMethodSignatureForSelector:@selector(testTruthness)];
//  NSInvocation *trueInvocation = [NSInvocation invocationWithMethodSignature:signature];
//  trueInvocation.selector = @selector(testTruthness);
//  
//  [invocations addObject:trueInvocation];
//
//  return invocations;
//}
//
//@end
//
//@interface ParametrizedTests2 : XCTestCase
//@end
//
//@implementation ParametrizedTests2
//+ (NSArray<NSInvocation *> *)testInvocations {
//  NSLog(@"testInvocations() called");
//
//  /* Prepare dummy input */
//  __block NSMutableArray<NSString *> *dartTestFiles = [[NSMutableArray alloc] init];
//  [dartTestFiles addObject:@"example_test"];
//  [dartTestFiles addObject:@"permissions_location_test"];
//  [dartTestFiles addObject:@"permissions_many_test"];
//
//  NSMutableArray<NSInvocation *> *invocations = [[NSMutableArray alloc] init];
//
//  NSLog(@"Before the loop, %lu elements in the array", (unsigned long)dartTestFiles.count);
//
//
//  for (int i = 0; i < dartTestFiles.count; i++) {
//    /* Step 1 */
//
//    NSString *name = dartTestFiles[i];
//
//    void (^func)(ParametrizedTests *) = ^(ParametrizedTests *instance) {
//      XCUIApplication* app = [[XCUIApplication alloc] init];
//      [app launch];
//      NSLog(@"func called!");
//      XCTAssertTrue(true, "dummy assert");
//      [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
//    };
//
//    IMP implementation = imp_implementationWithBlock(func);
//    NSString *selectorStr = [NSString stringWithFormat:@"test_%@", name];
//    SEL selector = NSSelectorFromString(selectorStr);
//    class_addMethod(self, selector, implementation, "v@:");
//
//    /* Step 2 */
//
//    NSMethodSignature *signature = [self instanceMethodSignatureForSelector:selector];
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//    invocation.selector = selector;
//
//    NSLog(@"RunnerUITests.testInvocations(): selectorStr = %@", selectorStr);
//
//    [invocations addObject:invocation];
//  }
//
//  NSLog(@"After the loop");
//
//  return invocations;
//}
//
//@end
//
