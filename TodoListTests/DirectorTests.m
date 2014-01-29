//
//  DirectorTests.m
//  TodoList
//
//  Created by weston on 1/28/14.
//  Copyright (c) 2014 com.westonplatter. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataHelper.h"

#import "CoreDataHelper.h"
#import "Director.h"
#import "User.h"


@interface DirectorTests : XCTestCase
@property (nonatomic,retain) NSManagedObjectContext *moc;
@end

@implementation DirectorTests

- (void)setUp
{
    [super setUp];
    self.moc = [CoreDataHelper getManagedObjectContext];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testExample
{
    
    // {
    //    user: {
    //        email: "todo@example.com",
    //        todos: [
    //            {
    //                id: 1,
    //                action: "write tests",
    //            },
    //            {
    //                id: 2,
    //                action: "read tests"
    //            }
    //        ]
    //
    //   }
    // }
    NSString *jsonString = @"{\"user\":{\"email\":\"todo@example.com\",\"todos\":[{\"id\":\"1\",\"action\":\"write tests\"},{\"id\":2,\"action\":\"ios tests\"}]}}";

    
    NSError *error = nil;
    NSDictionary *jsonDictionary = [NSJSONSerialization
                                        JSONObjectWithData: [jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                        error: &error
                                    ];
    
    Director *director = [[Director alloc] initWithMOC:self.moc];

    BOOL result = [director loadJSON:jsonDictionary];
    XCTAssertTrue(result, @"loadJSON should return true");
    
    
//  1 User should be created
    
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] init];
    NSEntityDescription *userEntity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.moc];
    [fetchRequest1 setEntity:userEntity];
    NSArray *fetchedUsers = [self.moc executeFetchRequest:fetchRequest1 error:&error];

    XCTAssertTrue([fetchedUsers count] == 1, @"director should create user");
    XCTAssertFalse(error, @"fetch should generate no errors");
    
//  2 Todos should be created
    
    NSObject *user = [fetchedUsers firstObject];
    NSArray *userTodos = [user valueForKey:@"todos"];
    XCTAssertTrue([userTodos count] == 2, @"director should create 2 tods for user");
}

@end
