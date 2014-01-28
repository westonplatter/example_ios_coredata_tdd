//
//  User.h
//  TodoList
//
//  Created by weston on 1/28/14.
//  Copyright (c) 2014 com.westonplatter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Todo;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) Todo *todos;

@end
