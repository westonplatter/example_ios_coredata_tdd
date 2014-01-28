//
//  CoreDataHelper.h
//  TodoList
//
//  Created by weston on 1/28/14.
//  Copyright (c) 2014 com.westonplatter. All rights reserved.
//

#import "AppDelegate.h"
#import <Foundation/Foundation.h>

@interface CoreDataHelper : NSObject

+(NSManagedObjectContext *) getManagedObjectContext;

@end
