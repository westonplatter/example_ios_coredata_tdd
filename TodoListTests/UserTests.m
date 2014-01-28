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

- (void)testRelationshipUserTodos
{
    
//  Create User and Todos
    
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.moc];
    [user setEmail:@"todo@example.com"];
    
    Todo *todo_1 = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:self.moc];
    [todo_1 setAction:@"first"];
    [todo_1 setUser:user];

    Todo *todo_2 = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:self.moc];
    [todo_2 setAction:@"second"];
    [todo_2 setUser:user];
    
    NSError *error = nil;
    BOOL result = [self.moc save:&error];
    
    XCTAssertNil(error, @"save should not raise errors");
    XCTAssertTrue(result, @"save should be true");

//  Fetch user and todos
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.moc];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [self.moc executeFetchRequest:fetchRequest error:&error];

//  Check that user.todos is array of 2 objects
    
    NSObject *fetchedUser = [fetchedObjects firstObject];
    NSArray *todos = [fetchedUser valueForKey:@"todos"];
    XCTAssert([todos count] == 2, @"user should have 2 todos");
}

@end

