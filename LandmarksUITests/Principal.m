@import Foundation;
@import XCTest;
#import "Principal.h"


@implementation Principal

- (instancetype)init {
  self = [super init];
  if (self) {
    NSLog(@"Principal instance has been initialized.");
  }

  [[XCTestObservationCenter sharedTestObservationCenter] addTestObserver:self];
  return self;
}

- (void)testBundleWillStart:(NSBundle *)testBundle {
  NSLog(@"Test bundle %@ will start", testBundle.bundleIdentifier);
}

- (void)testSuiteWillStart:(XCTestSuite *)testSuite {
  NSLog(@"Test suite \"%@\" will start", testSuite.name);
}

- (void)testSuiteDidFinish:(XCTestSuite *)testSuite {
  NSLog(@"Test suite \"%@\" did finish", testSuite.name);
}

- (void)testBundleDidFinish:(NSBundle *)testBundle {
  NSLog(@"Test bundle \"%@\" did finish", testBundle.bundleIdentifier);
}

@end
