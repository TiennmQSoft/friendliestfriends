//
//  LMSFriendliestViewController.h
//  MyFBLikes
//
//  Created by Lauren Shapiro on 5/6/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMSAppDelegate.h"

@interface LMSFriendliestViewController : UITableViewController
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray* friendliest;
@end
