//
//  Todo.h
//  TodoList
//
//  Created by weston on 1/28/14.
//  Copyright (c) 2014 com.westonplatter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Todo : NSManagedObject

@property (nonatomic, retain) NSString * action;
@property (nonatomic, retain) NSString * state;

@end
