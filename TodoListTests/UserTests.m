//
//  UserTests.m
//  TodoList
//
//  Created by weston on 1/28/14.
//  Copyright (c) 2014 com.westonplatter. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataHelper.h"
#import "User.h"
#import "Todo.h"

@interface UserTests : XCTestCase
@property (nonatomic,retain) NSManagedObjectContext *moc;
@end


@implementation UserTests

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

- (void)testUserCreate
{
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.moc];
    
    [user setEmail:@"todo@example.com"];
    
    NSError *error = nil;
    BOOL result = [self.moc save:&error];
    
    XCTAssertNil(error, @"save should not raise errors");
    XCTAssertTrue(result, @"save should be true");
}

@end

