//
//  LMSViewController.h
//  MyFBLikes
//
//  Created by Lauren Shapiro on 5/6/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LMSViewController : UIViewController <FBLoginViewDelegate>
@property (strong, nonatomic) FBProfilePictureView *profilePic;
@property (strong, nonatomic) UILabel *userNameLabel;
@end
