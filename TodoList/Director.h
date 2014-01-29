//
//  Director.h
//  TodoList
//
//  Created by weston on 1/28/14.
//  Copyright (c) 2014 com.westonplatter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Director : NSObject


@property (nonatomic,retain) NSManagedObjectContext *moc;

-(id)initWithMOC:(NSManagedObjectContext *)managedObjectContext;

-(BOOL)loadJSON:(NSDictionary *)jsonDictionary;

@end
