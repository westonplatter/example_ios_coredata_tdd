//
//  DetailViewController.h
//  TodoList
//
//  Created by weston on 1/27/14.
//  Copyright (c) 2014 com.westonplatter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
