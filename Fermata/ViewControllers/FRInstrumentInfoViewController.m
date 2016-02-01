//
//  FRInstrumentInfoViewController.m
//  Fermata
//
//  Created by Vytautas Gudaitis on 9/29/13.
//  Copyright (c) 2013 Seriously inc. All rights reserved.
//

#import "FRInstrumentInfoViewController.h"
#import "UIView+NibLoading.h"
#import "FRInstrumentInfoCell.h"

@interface FRInstrumentInfoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FRInstrumentInfoViewController

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
    
    self.title = @"Your Instrument";
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView delegate and data source methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FRInstrumentInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FRInstrumentInfoCellID"];
    if (!cell) {
        cell = (id)[FRInstrumentInfoCell loadInstanceFromNib];
    }
    switch (indexPath.row) {
        case 0:
            cell.cellLabel.text = @"Instrument";
            cell.cellTextField.text = @"Basson";
            break;
        case 1:
            cell.cellLabel.text = @"Manufacturer";
            cell.cellTextField.text = @"Heckel";
            break;
        case 2:
            cell.cellLabel.text = @"Model/Type";
            cell.cellTextField.text = @"Short bore";
            break;
        case 3:
            cell.cellLabel.text = @"Serial number";
            cell.cellTextField.text = @"7101";
            break;
        case 4:
            cell.cellLabel.text = @"Year manufactured";
            cell.cellTextField.text = @"1934";
            break;
        case 5:
            cell.cellLabel.text = @"Appraised price";
            cell.cellTextField.text = @"$36,000";
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"InstrumentPhotoHeader"]];
    return headerImageView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 239;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}

@end
