//
//  FRAddInstrumentViewController.m
//  Fermata
//
//  Created by Vytautas Gudaitis on 9/28/13.
//  Copyright (c) 2013 Seriously inc. All rights reserved.
//

#import "FRAddInstrumentViewController.h"
#import "FRInstrumentStatusViewController.h"

@interface FRAddInstrumentViewController () <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIButton *chooseInstrumentButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseManufacturerButton;
@property (weak, nonatomic) IBOutlet UIButton *pairDeviceButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *devicePairedLabelImageView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation FRAddInstrumentViewController

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
    
    [self.chooseInstrumentButton setBackgroundImage:[UIImage imageNamed:@"WhiteButtonBg"]
                                           forState:UIControlStateNormal];
    [self.chooseInstrumentButton setTitle:@"Instrument"
                                 forState:UIControlStateNormal];
    [self.chooseInstrumentButton setTitleColor:[UIColor lightGrayColor]
                                      forState:UIControlStateNormal];
    
    [self.chooseManufacturerButton setTitle:@"Manufacturer"
                                   forState:UIControlStateDisabled];
    [self.chooseManufacturerButton setTitleColor:[UIColor lightGrayColor]
                                        forState:UIControlStateDisabled];
    self.chooseManufacturerButton.enabled = NO;
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

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)chooseInstrumentButtonPressed:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose instrument:"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Basson", nil];
    actionSheet.tag = 101;
    [actionSheet showInView:self.view];
}

- (IBAction)chooseManufacturerButtonPressed:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose manufacturer:"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Heckel", nil];
    actionSheet.tag = 102;
    [actionSheet showInView:self.view];
}

- (IBAction)pairDeviceButtonPressed:(id)sender
{
    self.pairDeviceButton.hidden = YES;
    [self.activityIndicator startAnimating];
    [self performSelector:@selector(stopLoading)
               withObject:nil
               afterDelay:2.0];
}

- (void)stopLoading
{
    [self.activityIndicator stopAnimating];
    self.devicePairedLabelImageView.hidden = NO;
    self.nextButton.hidden = NO;
}

- (IBAction)nextButtonPressed:(id)sender
{
    FRInstrumentStatusViewController *instrumentStatusViewController = [[FRInstrumentStatusViewController alloc] initWithNibName:@"FRInstrumentStatusViewController" bundle:nil];
    [self.navigationController pushViewController:instrumentStatusViewController
                                         animated:YES];
}

#pragma mark - UIActionSheet delegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 101) {
        [self.chooseInstrumentButton setBackgroundImage:nil
                                               forState:UIControlStateNormal];
        [self.chooseInstrumentButton setTitle:@"Basson"
                                     forState:UIControlStateNormal];
        [self.chooseInstrumentButton setTitleColor:[UIColor blackColor]
                                          forState:UIControlStateNormal];
        
        [self.chooseManufacturerButton setBackgroundImage:[UIImage imageNamed:@"WhiteButtonBg"]
                                                 forState:UIControlStateNormal];
        [self.chooseManufacturerButton setTitle:@"Manufacturer"
                                       forState:UIControlStateNormal];
        [self.chooseManufacturerButton setTitleColor:[UIColor lightGrayColor]
                                            forState:UIControlStateNormal];
        self.chooseManufacturerButton.enabled = YES;
    }
    if (actionSheet.tag == 102) {
        [self.chooseManufacturerButton setBackgroundImage:nil
                                                 forState:UIControlStateNormal];
        [self.chooseManufacturerButton setTitle:@"Heckel"
                                       forState:UIControlStateNormal];
        [self.chooseManufacturerButton setTitleColor:[UIColor blackColor]
                                            forState:UIControlStateNormal];
    }
}

@end
