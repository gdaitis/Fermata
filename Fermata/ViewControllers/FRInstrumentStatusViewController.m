//
//  FRInstrumentStatusViewController.m
//  Fermata
//
//  Created by Lukas Kekys on 9/28/13.
//  Copyright (c) 2013 Seriously inc. All rights reserved.
//

#import "FRInstrumentStatusViewController.h"
#import "FRInstrumentLocationCell.h"
#import "FRTemperatureCell.h"
#import "FRHumidityCell.h"
#import "FRChartViewController.h"
#import "UIView+NibLoading.h"
#import "FRMapViewController.h"
#import "FRInstrumentInfoViewController.h"
#import "FRSettingsViewController.h"

#define kLocationCellNormalColor [UIColor colorWithRed:82.0f/255.0f green:178.0f/255.0f blue:157.0f/255.0f alpha:1.0f]
#define kLocationCellAlertColor [UIColor colorWithRed:210.0f/255.0f green:62.0f/255.0f blue:16.0f/255.0f alpha:1.0f]

#define kTemperatureCellNormalColor [UIColor colorWithRed:129.0f/255.0f green:183.0f/255.0f blue:145.0f/255.0f alpha:1.0f]
#define kTemperatureCellAlertColor [UIColor colorWithRed:224.0f/255.0f green:95.0f/255.0f blue:18.0f/255.0f alpha:1.0f]

#define kHumidityCellNormalColor [UIColor colorWithRed:62.0f/255.0f green:92.0f/255.0f blue:110.0f/255.0f alpha:1.0f]
#define kHumidityCellAlertColor [UIColor colorWithRed:167.0f/255.0f green:60.0f/255.0f blue:18.0f/255.0f alpha:1.0f]


@interface FRInstrumentStatusViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, assign) int distanceInMeters;
@property (nonatomic, assign) int temperature;
@property (nonatomic, assign) int humidity;

- (IBAction)robberyButtonPressed:(id)sender;

@end

@implementation FRInstrumentStatusViewController

- (void)setDistanceInMeters:(int)distanceInMeters
{
    FRAppDelegate *appDelegate = (FRAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.distance = distanceInMeters;
    _distanceInMeters = distanceInMeters;
    [self.tableView reloadData];
}

- (void)setTemperature:(int)temperature
{
    _temperature = temperature;
    [self.tableView reloadData];
}

- (void)setHumidity:(int)humidity
{
    _humidity = humidity;
    [self.tableView reloadData];
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
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"LogedIn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    FRAppDelegate *appDelegate = (FRAppDelegate *)[[UIApplication sharedApplication] delegate];
    //    appDelegate.distance = 12;
    
    self.temperature = 17;
    self.distanceInMeters = appDelegate.distance;
    self.humidity = 38;
    
    
    self.title = @"Fermata";
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 13, 16);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"InstrumentInfoButton"]
                          forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(instrumentInfoButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 16, 16);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"SettingsButton"]
                           forState:UIControlStateNormal];
    [rightButton addTarget:self
                    action:@selector(settingsButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    //    [self performSelector:@selector(increaseCount) withObject:nil afterDelay:1.5f];
    [self startSimulation];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO
                                             animated:YES];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (self.view.frame.size.height < 500) {
    if (indexPath.row == 0) {
        return 138;
    }
    else {
        return 139;
    }
    //    }
    //    else {
    //        return 168;
    //    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FRInstrumentLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FRInstrumentLocationCellID"];
        if (!cell) {
            cell = (id)[FRInstrumentLocationCell loadInstanceFromNib];
        }
        if (_distanceInMeters > 50)
        {
            cell.background.backgroundColor = kLocationCellAlertColor;
            cell.distanceLabel.backgroundColor = kLocationCellAlertColor;
        }
        else {
            cell.background.backgroundColor = kLocationCellNormalColor;
            cell.distanceLabel.backgroundColor = kLocationCellNormalColor;
        }
        
        FRAppDelegate *appDelegate = (FRAppDelegate *)[[UIApplication sharedApplication] delegate];
        cell.distanceLabel.text = [NSString stringWithFormat:@"%dm",appDelegate.distance];
        
        return cell;
    }
    else if (indexPath.row == 1) {
        FRTemperatureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FRTemperatureCellID"];
        if (!cell) {
            cell = (id)[FRTemperatureCell loadInstanceFromNib];
        }
        if (_temperature > 30)
            cell.background.backgroundColor = kTemperatureCellAlertColor;
        else
            cell.background.backgroundColor = kTemperatureCellNormalColor;
        
        cell.celciusLabel.text = [NSString stringWithFormat:@"%d°C",self.temperature];
        
        return cell;
    }
    else {
        FRHumidityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FRHumidityCellID"];
        if (!cell) {
            cell = (id)[FRHumidityCell loadInstanceFromNib];
        }
        if (_humidity > 40)
            cell.background.backgroundColor = kHumidityCellAlertColor;
        else
            cell.background.backgroundColor = kHumidityCellNormalColor;
        
        cell.percentLabel.text = [NSString stringWithFormat:@"%d%%",self.humidity];
        
        return cell;
    }
}

#pragma mark - tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        //show map
        FRMapViewController *mapViewController = [[FRMapViewController alloc] initWithNibName:@"FRMapViewController" bundle:nil];
        [self.navigationController pushViewController:mapViewController animated:YES];
    }
    else if (indexPath.row == 1) {
        //show temperature chart view
        FRChartViewController *chartViewController = [[FRChartViewController alloc] initWithNibName:@"FRChartViewController" bundle:nil];
        chartViewController.chartType = CHART_TYPE_TEMPERATURE;
        [self.navigationController pushViewController:chartViewController animated:YES];
    }
    else {
        //show humidity chart view
        FRChartViewController *chartViewController = [[FRChartViewController alloc] initWithNibName:@"FRChartViewController" bundle:nil];
        chartViewController.chartType = CHART_TYPE_HUMIDITY;
        [self.navigationController pushViewController:chartViewController animated:YES];
    }
}

#pragma mark - view update

- (void)startSimulation
{
    [self performSelector:@selector(startTemperatureSimulation) withObject:nil afterDelay:2.5f];
    [self performSelector:@selector(startHummiditySimulation) withObject:nil afterDelay:1.0f];
    [self performSelector:@selector(startLocationSimulation) withObject:nil afterDelay:1.0f];
}

- (void)startTemperatureSimulation
{
    if (self.temperature == 17)
        self.temperature += 1;
    else
        self.temperature -=1;
    
    [self.tableView reloadData];
    [self performSelector:@selector(startTemperatureSimulation) withObject:nil afterDelay:6.5f];
}

- (void)startHummiditySimulation
{
    if (self.humidity == 38)
        self.humidity += 1;
    else
        self.humidity -=1;
    
    [self.tableView reloadData];
    [self performSelector:@selector(startHummiditySimulation) withObject:nil afterDelay:8.0f];
}

- (void)startLocationSimulation
{
    BOOL logedin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LogedIn"];
    
    if (logedin) {
        if (self.distanceInMeters == 12)
            self.distanceInMeters += 1;
        else
            self.distanceInMeters -=1;
        
        [self.tableView reloadData];
        [self performSelector:@selector(startLocationSimulation) withObject:nil afterDelay:8.3f];
    }
    else {
        self.distanceInMeters = 12;
    }
}

- (IBAction)robberyButtonPressed:(id)sender
{
    [self performSelector:@selector(performRobbery) withObject:nil afterDelay:4.2f];
}

- (void)performRobbery
{
    BOOL logedin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LogedIn"];
    
    if (logedin) {
        self.distanceInMeters += 6;
        [self.tableView reloadData];
        [self performSelector:@selector(performRobbery) withObject:nil afterDelay:1.2f];
    }
    else
    {
        self.distanceInMeters = 12;
    }
}

//- (void)increaseCount
//{
//    self.humidity +=1;
//    self.temperature +=1;
//    self.distanceInMeters +=1;
//
//    [self.tableView reloadData];
//    [self performSelector:@selector(increaseCount) withObject:nil afterDelay:1.5f];
//}

#pragma mark - Navigation button methods

- (void)instrumentInfoButtonPressed
{
    FRInstrumentInfoViewController *instrumentInfoViewController = [[FRInstrumentInfoViewController alloc] initWithNibName:@"FRInstrumentInfoViewController" bundle:nil];
    [self.navigationController pushViewController:instrumentInfoViewController
                                         animated:YES];
}

- (void)settingsButtonPressed
{
    FRSettingsViewController *settingsViewController = [[FRSettingsViewController alloc] initWithNibName:@"FRSettingsViewController"
                                                                                                  bundle:nil];
    [self.navigationController pushViewController:settingsViewController
                                         animated:YES];
}

@end
