//
//  FRLandingPageViewController.m
//  Fermata
//
//  Created by Lukas Kekys on 9/28/13.
//  Copyright (c) 2013 Seriously inc. All rights reserved.
//

#import "FRLandingPageViewController.h"
#import "FRAppDelegate.h"
#import "FRAddUserViewController.h"

@interface FRLandingPageViewController ()

@end

@implementation FRLandingPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES
                                             animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button methods

- (IBAction)addPressed:(id)sender
{
    FRAddUserViewController *addUserViewController = [[FRAddUserViewController alloc] initWithNibName:@"FRAddUserViewController"
                                                                                               bundle:nil];
    [self.navigationController pushViewController:addUserViewController
                                         animated:YES];
}

@end
