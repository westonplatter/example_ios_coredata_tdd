//
//  Director.m
//  TodoList
//
//  Created by weston on 1/28/14.
//  Copyright (c) 2014 com.westonplatter. All rights reserved.
//

#import "Director.h"
#import "User.h"
#import "Todo.h"



@implementation Director

- (id) initWithMOC:(NSManagedObjectContext *)managedObjectContext
{
    self = [super init];
    if (self){
        self.moc = managedObjectContext;
    }
    return self;
}


- (BOOL)loadJSON:(NSDictionary *)jsonDictionary
{
    BOOL result = nil;
    
    NSDictionary *userDictionary  = [jsonDictionary valueForKey:@"user"];
    NSString *userEmail = [userDictionary valueForKey:@"email"];
    
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.moc];
    [user setEmail:userEmail];

    
    NSArray *todos = [userDictionary valueForKey:@"todos"];
    
    for (NSDictionary *todoDictionary in todos) {
        Todo *todo = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:self.moc];
        
        if([todoDictionary valueForKey:@"action"]){
            [todo setAction:[todoDictionary valueForKey:@"action"]];
        }
        
        if ([todoDictionary valueForKey:@"state"]) {
            [todo setState:[todoDictionary valueForKey:@"state"]];
        }
        
        [todo setUser:user];
        todo = nil;
    }
    
    NSError *error = nil;
    result = [self.moc save:&error];
    
    return result;
}

@end
