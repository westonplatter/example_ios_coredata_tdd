//
//  CoreDataHelper.m
//  TodoList
//
//  Created by weston on 1/28/14.
//  Copyright (c) 2014 com.westonplatter. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper

NSManagedObjectContext *testingContext;

+(NSManagedObjectContext *) getManagedObjectContext {
    
    // setup the ManagedObjectModel
    NSManagedObjectModel *mom = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // setup the PersistentStoreCoordinator
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    
    // tell PersistentCoordinator to use In Memoery DB to make tests faster
    [psc
        addPersistentStoreWithType:NSInMemoryStoreType
        configuration:nil
        URL:nil
        options:nil
        error:NULL];
    
    // Comment this out so that we get a new context for each test.
    // Caused erorrs for testRelationshipUserTodos
    //
    // return instantiated `testingContext` if instantiated
    // if (testingContext != nil) {
    //     return testingContext;
    // }
    
    // alloc ManagedObjectContext
    testingContext = [[NSManagedObjectContext alloc] init];
    
    // tell Context to rely on In Memeory Coordinator
    testingContext.persistentStoreCoordinator = psc;
    
    // This acutally runs multiple times since we're creating a
    // new context for each test.
    //
    // should only run once
    // NSLog(@"\n\n\n==>> should only run once\n\n\n");
    
    return testingContext;
}

@end