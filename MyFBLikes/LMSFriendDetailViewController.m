//
//  LMSFriendDetailViewController.m
//  MyFBLikes
//
//  Created by Lauren Shapiro on 5/6/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import "LMSFriendDetailViewController.h"

@interface LMSFriendDetailViewController ()

@end

@implementation LMSFriendDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    
    
    // add the profile picture for this friend
    UIImageView *profPic = [[UIImageView alloc]initWithImage:self.friendProfPic];
    [profPic setFrame:CGRectMake(80, 100, 2*(self.friendProfPic.size.width)/3,  2*(self.friendProfPic.size.height)/3)];
    [self.view addSubview:profPic];
    
    // add the name label
    UILabel* nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 60, 280, 30)];
    [nameLabel setText:self.friendName];
    [self.view addSubview:nameLabel];
    
    // add a the friend count
    UILabel* friendCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, (2*(self.friendProfPic.size.height)/3 + 110), 300, 30)];
    
    [friendCountLabel setText: [NSString stringWithFormat: @"has %d friends", self.friendCount]];
    [self.view addSubview:friendCountLabel];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
