//
//  FRMapViewController.m
//  Fermata
//
//  Created by Lukas Kekys on 9/29/13.
//  Copyright (c) 2013 Seriously inc. All rights reserved.
//

#import "FRMapViewController.h"
#import <MapKit/MapKit.h>
#import "FRHistoryCell.h"
#import "UIView+NibLoading.h"

#define kNormalColor [UIColor colorWithRed:82.0f/255.0f green:178.0f/255.0f blue:157.0f/255.0f alpha:1.0f]
#define kAlertColor [UIColor colorWithRed:210.0f/255.0f green:62.0f/255.0f blue:16.0f/255.0f alpha:1.0f]

@interface FRMapViewController () <MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet UIView *distanceView;
@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UIView *buttonView;

@property (nonatomic, weak) IBOutlet UIButton *mapButton;
@property (nonatomic, weak) IBOutlet UIButton *historyButton;
@property (nonatomic, weak) IBOutlet UIButton *callPoliceButton;

@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) IBOutlet UILabel *locationLabel;

@property (nonatomic, assign) int distance;

@property (nonatomic, strong) NSArray *dataArray;

- (IBAction)mapButtonPressed:(id)sender;
- (IBAction)historyButtonPressed:(id)sender;

@property (nonatomic, weak) MKMapView *mapView;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation FRMapViewController

- (void)setDistance:(int)distance
{
    _distance = distance;
    [self updateView];
}

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
    self.title = @"Fermata";
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    // Do any additional setup after loading the view from its nib.
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self addData];
    
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
- (void)addData
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:@"16:10h" forKey:@"Time"];
    [dict setValue:@"222" forKey:@"Distance"];
    [dict setValue:@"O. Milašiaus g., Vilnius" forKey:@"Location"];
    
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
    [dict1 setValue:@"16:08h" forKey:@"Time"];
    [dict1 setValue:@"58" forKey:@"Distance"];
    [dict1 setValue:@"Saulėtekio al., Vilnius" forKey:@"Location"];
    
    NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] init];
    [dict2 setValue:@"16:00h" forKey:@"Time"];
    [dict2 setValue:@"16" forKey:@"Distance"];
    [dict2 setValue:@"Saulėtekio al., Vilnius" forKey:@"Location"];
    
    NSMutableDictionary *dict3 = [[NSMutableDictionary alloc] init];
    [dict3 setValue:@"15:30h" forKey:@"Time"];
    [dict3 setValue:@"3" forKey:@"Distance"];
    [dict3 setValue:@"Saulėtekio al., Vilnius" forKey:@"Location"];
    
    NSMutableDictionary *dict4 = [[NSMutableDictionary alloc] init];
    [dict4 setValue:@"15:00h" forKey:@"Time"];
    [dict4 setValue:@"3" forKey:@"Distance"];
    [dict4 setValue:@"Saulėtekio al., Vilnius" forKey:@"Location"];
    
    self.dataArray = [[NSArray alloc] initWithObjects:dict,dict1, dict2, dict3, dict4, nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateView];
    self.mapType = MAP_TYPE_MAP;
    [self changeMapView];
    

//    if (self.view.frame.size.height < 450) {
//        //stupid way of finding that iphone is smaller than iphone5
//        
//        [self.view removeConstraints:self.view.constraints];
//        
//        CGRect frame = self.buttonView.frame;
//        frame.origin.y = self.view.frame.size.height - self.buttonView.frame.size.height;
//        self.buttonView.frame = frame;
//        
//        NSLog(@" button frame.origin.y = %f",self.buttonView.frame.origin.y);
//    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(distanceChanged) name:kDistanceHasChangedNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    if (self.view.frame.size.height < 450) {
//        //stupid way of finding that iphone is smaller than iphone5
//        
//        CGRect frame = self.buttonView.frame;
//        frame.origin.y = self.view.frame.size.height - self.buttonView.frame.size.height;
//        self.buttonView.frame = frame;
//        
//        frame = self.containerView.frame;
//        frame.size.height = self.view.frame.size.height - self.buttonView.frame.origin.y;
//        self.containerView.frame = frame;
//        
//        NSLog(@" button frame.origin.y = %f",self.buttonView.frame.origin.y);
//    }
}

- (void)distanceChanged
{
    [self updateView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDistanceHasChangedNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateView
{
    FRAppDelegate *appDelegate = (FRAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.distance <= 50) {
        self.distanceView.backgroundColor = kNormalColor;
        self.distanceLabel.backgroundColor = kNormalColor;
        self.callPoliceButton.hidden = YES;
    }
    else {
        self.distanceView.backgroundColor = kAlertColor;
        self.distanceLabel.backgroundColor = kAlertColor;
        self.callPoliceButton.hidden = NO;
    }
    self.distanceLabel.text = [NSString stringWithFormat:@"%dm",appDelegate.distance];
}

- (void)changeMapView
{
    [self clearContainerView];
    self.mapButton.selected = NO;
    self.historyButton.selected = NO;
    
    if (self.mapType == MAP_TYPE_MAP) {
        
        MKMapView *mkMapView = [[MKMapView alloc] initWithFrame:self.containerView.bounds];
        self.mapView = mkMapView;
        self.mapView.delegate = self;
        [self.containerView addSubview:self.mapView];
        self.mapView.showsUserLocation = YES;
        
        self.mapButton.selected = YES;
        self.mapButton.backgroundColor = [UIColor whiteColor];
        self.historyButton.backgroundColor = [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f];
    }
    else {
        UITableView *table = [[UITableView alloc] initWithFrame:self.containerView.bounds];
        self.tableView = table;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.containerView addSubview:self.tableView];
        self.historyButton.backgroundColor = [UIColor whiteColor];
        self.mapButton.backgroundColor = [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f];
        
        self.historyButton.selected = YES;
    }
}

- (IBAction)mapButtonPressed:(id)sender
{
    if (self.mapType == MAP_TYPE_HISTORY) {
        self.mapType = MAP_TYPE_MAP;
        [self changeMapView];
    }
}

- (IBAction)historyButtonPressed:(id)sender
{
    if (self.mapType == MAP_TYPE_MAP) {
        self.mapType = MAP_TYPE_HISTORY;
        [self changeMapView];
    }
}

- (void)clearContainerView
{
    for (UIView *view in self.containerView.subviews)
    {
        if (![view isEqual:self.containerView]) {
            [view removeFromSuperview];
        }
    }
    self.mapView = nil;
    self.tableView = nil;
}

#pragma mark - MapView

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    self.mapView.centerCoordinate = self.mapView.userLocation.location.coordinate;
}

#pragma mark - History

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor whiteColor];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FRHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FRHistoryCellID"];
    if (!cell) {
        cell = (id)[FRHistoryCell loadInstanceFromNib];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.locationLabel.text = [dict valueForKey:@"Location"];
    cell.timeLabel.text = [dict valueForKey:@"Time"];
    cell.distanceLabel.text = [NSString stringWithFormat:@"%@m",[dict valueForKey:@"Distance"]];
    
    if ([[dict valueForKey:@"Distance"] intValue] > 50)
        cell.distanceLabel.textColor = [UIColor redColor];
    else
        cell.distanceLabel.textColor = [UIColor blackColor];
    
    return cell;
}

#pragma mark - Table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - location manager

//- (void)locationManager:(CLLocationManager *)manager
//	didUpdateToLocation:(CLLocation *)newLocation
//		   fromLocation:(CLLocation *)oldLocation
//{
//
//}

@end
