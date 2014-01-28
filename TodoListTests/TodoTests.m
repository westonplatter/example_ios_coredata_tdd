//
//  TodoTests.m
//  TodoList
//
//  Created by weston on 1/28/14.
//  Copyright (c) 2014 com.westonplatter. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataHelper.h"
#import "Todo.h"

@interface TodoTests: XCTestCase
@property (nonatomic,retain) NSManagedObjectContext *moc;
@end

@implementation TodoTests

- (void)setUp
{
    [super setUp];
    
    // get CoreData Managed Object Context from CoreData helper
    self.moc = [CoreDataHelper getManagedObjectContext];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testTodo
{
    Todo *todo = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:self.moc];
    
    [todo setAction:@"create todo TDD app"];
    
    NSError *error = nil;
    BOOL result = [self.moc save:&error];

    XCTAssertNil(error, @"save should not raise errors");
    XCTAssertTrue(result, @"make the test pass to test Travis CI");
}

@end
