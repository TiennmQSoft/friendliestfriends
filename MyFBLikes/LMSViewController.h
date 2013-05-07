//
//  LMSViewController.h
//  MyFBLikes
//
//  Created by Lauren Shapiro on 5/6/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "LMSAppDelegate.h"

@interface LMSViewController : UIViewController <FBLoginViewDelegate, FBRequestDelegate>
@property (strong, nonatomic) FBProfilePictureView *profilePic;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) NSArray* userData;
@property (strong, nonatomic) UIButton* seeFriendliestButton;
@end
