//
//  LMSFriendliestViewController.m
//  MyFBLikes
//
//  Created by Lauren Shapiro on 5/6/13.
//  Copyright (c) 2013 Lauren Shapiro. All rights reserved.
//

#import "LMSFriendliestViewController.h"
#import "LMSFriendDetailViewController.h"

@interface LMSFriendliestViewController ()

@end

@implementation LMSFriendliestViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    // add back button
    
    CGRect tableSize = CGRectMake(0, 0, 320, 400);
    [self.tableView setFrame:tableSize];
    
    UIView* footer = [[UIView alloc]initWithFrame:CGRectMake(0, 400, 320, 50)];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setFrame: CGRectMake(0, 400, 100, 40)];

    [backButton setTitle:@"back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:backButton];
    
    
    self.tableView.tableFooterView = footer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.friendliest.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[self.friendliest objectAtIndex:indexPath.row]
                           objectForKey:@"name"];
    UIImage *image = [UIImage imageWithData:
                      [NSData dataWithContentsOfURL:
                       [NSURL URLWithString:
                        [[self.friendliest objectAtIndex:indexPath.row]
                         objectForKey:@"pic_square"]]]];
    cell.imageView.image = image;
    
    return cell;
}



-(IBAction)backButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMSFriendDetailViewController *detailVC = [[LMSFriendDetailViewController alloc]init];
    detailVC.friendProfPic = [UIImage imageWithData:
                              [NSData dataWithContentsOfURL:
                               [NSURL URLWithString:
                                [[self.friendliest objectAtIndex:indexPath.row]
                                 objectForKey:@"pic_big"]]]];
    detailVC.friendName = [[self.friendliest objectAtIndex:indexPath.row]
                           objectForKey:@"name"];
//    NSString *friendCount = [NSString stringWithFormat: @"%d", 45  ];
//                             ([[self.friendliest objectAtIndex:indexPath.row]
//                               objectForKey:@"friend_count"])
    
    detailVC.friendCount = 0;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

@end
