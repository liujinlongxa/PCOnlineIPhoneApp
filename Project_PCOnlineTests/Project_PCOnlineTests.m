//
//  Project_PCOnlineTests.m
//  Project_PCOnlineTests
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSDate+MyDate.h"
#import "LJDataManager.h"

@interface Project_PCOnlineTests : XCTestCase

@end

@implementation Project_PCOnlineTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)test1 {
    XCTAssert(YES, @"Pass");
}

- (void)test2 {
    XCTAssert(NO, @"Error");
}


@end
