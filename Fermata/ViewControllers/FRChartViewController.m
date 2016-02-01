//
//  FRChartViewController.m
//  Fermata
//
//  Created by Lukas Kekys on 9/29/13.
//  Copyright (c) 2013 Seriously inc. All rights reserved.
//

#import "FRChartViewController.h"

@interface FRChartViewController ()

@end

@implementation FRChartViewController

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
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // Do any additional setup after loading the view from its nib.
    if (self.chartType == CHART_TYPE_HUMIDITY) {
        self.title = @"Humidity";
        self.imageView.image = [UIImage imageNamed:@"HumidityChart.png"];
        self.view.backgroundColor = [UIColor colorWithRed:62.0f/255.0f green:92.0f/255.0f blue:110.0f/255.0f alpha:1.0f];
    }
    else {
        self.title = @"Temperature";
        self.imageView.image = [UIImage imageNamed:@"TemperatureChart.png"];
        self.view.backgroundColor = [UIColor colorWithRed:129.0f/255.0f green:183.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    }
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 9, 16);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"BackIconBlack"]
                          forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(backButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
