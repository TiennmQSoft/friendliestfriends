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
    loginView.frame = CGRectOffset(loginView.frame,
                                   (self.view.center.x - (loginView.frame.size.width / 2)),
                                   (self.view.center.y - (loginView.frame.size.height / 2)));
    [self.view addSubview:loginView];
    loginView.delegate = self;
    
    self.profilePic = [[FBProfilePictureView alloc] init];
    [self.profilePic setFrame:CGRectMake(20, 20, 75, 75)];
    [self.view addSubview:self.profilePic];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FBLoginDelegate Methods

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePic.profileID = nil;
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    // get the user's profile picture and name to customize the view
    self.profilePic.profileID = user.id;
    self.userNameLabel.text = [NSString stringWithFormat:
                                @"Welcome, %@", user.first_name];


//    // make a request to find friends with the most friends
    NSString *query = @"SELECT name, friend_count FROM user WHERE uid IN " @"(SELECT uid2 FROM friend WHERE uid1 = me()) ORDER BY friend_count DESC LIMIT 10";
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
                                  NSLog(@"Result: %@", result);
                                  
                                  self.userData =
                                  (NSArray *) [result objectForKey:@"data"];
                              }
                          }];
    
    // create a button to transition to the 
    UIButton *seeFriendliestButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [seeFriendliestButton setFrame: CGRectMake(80, 200, 160, 40)];
    [seeFriendliestButton  setTitle:@"Friendliest Friends" forState:UIControlStateNormal];
    [seeFriendliestButton addTarget:self action:@selector(seeFriendliest:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seeFriendliestButton];
    
    [self.view reloadInputViews];
    }

-(IBAction)seeFriendliest:(id)sender {
    LMSFriendliestViewController* friendliestVC = [[LMSFriendliestViewController alloc] init];
    friendliestVC.friendliest = self.userData;
    [self presentViewController:friendliestVC animated:NO completion:nil];
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
