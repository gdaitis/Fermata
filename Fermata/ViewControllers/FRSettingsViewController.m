//
//  FRSettingsViewController.m
//  Fermata
//
//  Created by Vytautas Gudaitis on 9/29/13.
//  Copyright (c) 2013 Seriously inc. All rights reserved.
//

#import "FRSettingsViewController.h"
#import "FRInstrumentInfoCell.h"
#import "UIView+NibLoading.h"
#import "FRUnpairDeviceCell.h"
#import "FRAppDelegate.h"

@interface FRSettingsViewController () <UITableViewDataSource, UITableViewDelegate, FRUnpairDeviceCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FRSettingsViewController

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
    
    self.title = @"Settings";
    
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

- (void)unpairDeviceButtonClicked
{
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"LogedIn"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popToRootViewControllerAnimated:YES];
//    FRAppDelegate *appDelegate = (FRAppDelegate *)[[UIApplication sharedApplication] delegate];
//    appDelegate.distance = 12;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FRUnpairDeviceCell delegate methods

- (void)unpairDeviceCellDidClickUnpairDeviceButton:(FRUnpairDeviceCell *)unpairDeviceCell
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"LogedIn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    FRAppDelegate *appDelegate = (FRAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.distance = 12;
}

#pragma mark - UITableView delegate and data source methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 3;
    if (section == 1)
        return 3;
    if (section == 2)
        return 3;
    if (section == 3)
        return 1;
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"Personal details";
    if (section == 1)
        return @"Temperature";
    if (section == 2)
        return @"Humidity";
    if (section == 3)
        return @"Device";
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        FRUnpairDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FRUnpairDeviceCellID"];
        if (!cell) {
            cell = (id)[FRUnpairDeviceCell loadInstanceFromNib];
            cell.delegate = self;
        }
        
        return cell;
    } else {
        FRInstrumentInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FRInstrumentInfoCellID"];
        if (!cell) {
            cell = (id)[FRInstrumentInfoCell loadInstanceFromNib];
        }
        
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0:
                    cell.cellLabel.text = @"Name";
                    cell.cellTextField.text = @"Vidas Bučinskas";
                    break;
                case 1:
                    cell.cellLabel.text = @"E-mail";
                    cell.cellTextField.text = @"vidas@bucinskas.lt";
                    break;
                case 2:
                    cell.cellLabel.text = @"Phone";
                    cell.cellTextField.text = @"+370 605 44981";
                    break;
                    
                default:
                    break;
            }
        }
        if (indexPath.section == 1) {
            switch (indexPath.row) {
                case 0:
                    cell.cellLabel.text = @"Minimum";
                    cell.cellTextField.text = @"3°C";
                    cell.arrowImage.hidden = NO;
                    break;
                case 1:
                    cell.cellLabel.text = @"Perfext";
                    cell.cellTextField.text = @"";
                    cell.cellTextField.placeholder = @"Select";
                    cell.arrowImage.hidden = NO;
                    break;
                case 2:
                    cell.cellLabel.text = @"Maximum";
                    cell.cellTextField.text = @"";
                    cell.cellTextField.placeholder = @"Select";
                    cell.arrowImage.hidden = NO;
                    break;
                    
                default:
                    break;
            }
        }
        if (indexPath.section == 2) {
            switch (indexPath.row) {
                case 0:
                    cell.cellLabel.text = @"Minimum";
                    cell.cellTextField.text = @"3°C";
                    cell.arrowImage.hidden = NO;
                    break;
                case 1:
                    cell.cellLabel.text = @"Perfext";
                    cell.cellTextField.text = @"";
                    cell.cellTextField.placeholder = @"Select";
                    cell.arrowImage.hidden = NO;
                    break;
                case 2:
                    cell.cellLabel.text = @"Maximum";
                    cell.cellTextField.text = @"";
                    cell.cellTextField.placeholder = @"Select";
                    cell.arrowImage.hidden = NO;
                    break;
                    
                default:
                    break;
            }
        }
        
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIImageView *footerImageView = nil;
    if (section == 3) {
        footerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SettingsFooter"]];
    }
    return footerImageView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3)
        return 101;
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3)
        return 88;
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}

@end
