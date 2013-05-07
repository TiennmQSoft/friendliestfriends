//
//  LMSViewController.m
//  MyFBLikes
//
//  Created by Lauren Shapiro on 5/6/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import "LMSViewController.h"
#import "LMSFriendliestViewController.h"

@interface LMSViewController ()

@end

@implementation LMSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    
    // set up login view
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"user_photos"]];
    loginView.frame = CGRectMake(80, 300, 160, 50);
    [self.view addSubview:loginView];
    loginView.delegate = self;
    
    self.profilePic = [[FBProfilePictureView alloc] init];
    [self.profilePic setFrame:CGRectMake(20, 20, 75, 75)];
    [self.view addSubview:self.profilePic];
    
    // initialize button to see friendliest friends
    self.seeFriendliestButton = [[UIButton alloc]initWithFrame:CGRectMake(60, 220, 200, 50)];
    [self.seeFriendliestButton setBackgroundImage:[UIImage imageNamed:@"friendliestfriends.png"] forState:UIControlStateNormal];
    
    [self.seeFriendliestButton addTarget:self action:@selector(seeFriendliest:)
                   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.seeFriendliestButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FBLoginDelegate Methods


-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePic.profileID = nil;
    self.seeFriendliestButton.hidden = TRUE;
   [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"welcomeloggedout.png"]]];
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    // get the user's profile picture and name to customize the view
    self.profilePic.profileID = user.id;
    self.userNameLabel.text = [NSString stringWithFormat:
                                @"Welcome, %@", user.first_name];

    // make a request to find friends with the most friends
    NSString *query = @"SELECT name, friend_count, pic_square, pic_big FROM user WHERE uid IN " @"(SELECT uid2 FROM friend WHERE uid1 = me()) ORDER BY friend_count DESC LIMIT 10";
    NSDictionary *queryParam =
    [NSDictionary dictionaryWithObjectsAndKeys: query, @"q", nil];
    [FBRequestConnection startWithGraphPath:@"fql" parameters:queryParam
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error) {
                              if (error) {
                                  NSLog(@"Error: %@", [error localizedDescription]);
                              } else {
                                  self.userData =
                                  (NSArray *) [result objectForKey:@"data"];
                                  
                                  // show transition button once data has loaded
                                  self.seeFriendliestButton.hidden = FALSE;
                              }
                          }];
    
    
        // update background
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"welcomeloggedin.png"]]];
       [self.view reloadInputViews];
    }

-(IBAction)seeFriendliest:(id)sender {
    LMSFriendliestViewController* friendliestVC = [[LMSFriendliestViewController alloc] init];
    friendliestVC.friendliest = self.userData;
    [self.navigationController pushViewController:friendliestVC animated:NO];
}

-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    if (error.fberrorShouldNotifyUser) {
        // If the SDK has a message for the user, surface it. This conveniently
        // handles cases like password change or iOS6 app slider state.
        alertTitle = @"Facebook Error";
        alertMessage = error.fberrorUserMessage;
    } else if (error.fberrorCategory == FBErrorCategoryAuthenticationReopenSession) {
        // It is important to handle session closures since they can happen
        // outside of the app. You can inspect the error for more context
        // but this sample generically notifies the user.
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
    } else if (error.fberrorCategory == FBErrorCategoryUserCancelled) {
        // The user has cancelled a login. You can inspect the error
        // for more context. For this sample, we will simply ignore it.
        NSLog(@"user cancelled login");
    } else {
        // For simplicity, this sample treats other errors blindly.
        alertTitle  = @"Unknown Error";
        alertMessage = @"Error. Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

@end
