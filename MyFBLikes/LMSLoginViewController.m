//
//  LMSLoginViewController.m
//  MyFBLikes
//
//  Created by Lauren Shapiro on 5/6/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import "LMSLoginViewController.h"

@interface LMSLoginViewController ()

@end

@implementation LMSLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"user_likes"]];
    loginView.frame = CGRectOffset(loginView.frame,
                                   (self.view.center.x - (loginView.frame.size.width / 2)),
                                   (self.view.center.y - (loginView.frame.size.height / 2)));
    [self.view addSubview:loginView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
