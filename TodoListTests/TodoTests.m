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
#import "User.h"

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
    [todo setState:@"started"];
    
    NSError *error = nil;
    BOOL result = [self.moc save:&error];

    XCTAssertNil(error, @"save should not raise errors");
    XCTAssertTrue(result, @"save operation should be true");
}

- (void) testRelationshipTodoUser
{
//  Create user and todo
    
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.moc];
    [user setEmail:@"todo@example.com"];
    
    Todo *todo = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:self.moc];
    [todo setAction:@"first"];
    [todo setUser:user];
    
    NSError *error = nil;
    BOOL result = [self.moc save:&error];
    
    XCTAssertNil(error, @"save should not raise errors");
    XCTAssertTrue(result, @"save should be true");

//  Fetch todo and get user
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *todoEntity = [NSEntityDescription entityForName:@"Todo" inManagedObjectContext:self.moc];
    [fetchRequest setEntity:todoEntity];
    NSArray *fetchedObjects = [self.moc executeFetchRequest:fetchRequest error:&error];
    
    NSObject *fetchedTodo = [fetchedObjects firstObject];
    NSObject *fetchedUser = [fetchedTodo valueForKey:@"user"];
    NSString *email = [fetchedUser valueForKey:@"email"];

//  Check that email is the same as set value
    
    XCTAssert([email isEqualToString:@"todo@example.com"], @"user should have email");
}

@end
