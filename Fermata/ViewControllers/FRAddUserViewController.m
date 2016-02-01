//
//  FRAddUserViewController.m
//  Fermata
//
//  Created by Vytautas Gudaitis on 9/28/13.
//  Copyright (c) 2013 Seriously inc. All rights reserved.
//

#import "FRAddUserViewController.h"
#import "FRAddInstrumentViewController.h"

@interface FRAddUserViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextView;

@end

@implementation FRAddUserViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES
                                             animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)animateWithOptions:(NSDictionary *)options
            andResizeBlock:(void (^)(void))resizeBlock
{
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    [[options objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[options objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[options objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationDuration:animationDuration];
    resizeBlock();
    [UIView commitAnimations];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    [self animateWithOptions:[notification userInfo]
              andResizeBlock:^{
                  self.logoImageView.frame = CGRectMake(self.logoImageView.frame.origin.x,
                                                        20,
                                                        self.logoImageView.frame.size.width,
                                                        self.logoImageView.frame.size.height);
                  self.nameTextView.frame = CGRectMake(self.nameTextView.frame.origin.x,
                                                       127,
                                                       self.nameTextView.frame.size.width,
                                                       self.nameTextView.frame.size.height);
                  self.emailTextView.frame = CGRectMake(self.emailTextView.frame.origin.x,
                                                        176,
                                                        self.emailTextView.frame.size.width,
                                                        self.emailTextView.frame.size.height);
                  self.phoneTextView.frame = CGRectMake(self.phoneTextView.frame.origin.x,
                                                        225,
                                                        self.phoneTextView.frame.size.width,
                                                        self.phoneTextView.frame.size.height);
              }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self animateWithOptions:[notification userInfo]
              andResizeBlock:^{
                  self.logoImageView.frame = CGRectMake(self.logoImageView.frame.origin.x,
                                                        81,
                                                        self.logoImageView.frame.size.width,
                                                        self.logoImageView.frame.size.height);
                  self.nameTextView.frame = CGRectMake(self.nameTextView.frame.origin.x,
                                                       192,
                                                       self.nameTextView.frame.size.width,
                                                       self.nameTextView.frame.size.height);
                  self.emailTextView.frame = CGRectMake(self.emailTextView.frame.origin.x,
                                                        250,
                                                        self.emailTextView.frame.size.width,
                                                        self.emailTextView.frame.size.height);
                  self.phoneTextView.frame = CGRectMake(self.phoneTextView.frame.origin.x,
                                                        307,
                                                        self.phoneTextView.frame.size.width,
                                                        self.phoneTextView.frame.size.height);
              }];
}

#pragma mark - Button methods

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextButtonPressed:(id)sender
{
    FRAddInstrumentViewController *addInstrumentViewController = [[FRAddInstrumentViewController alloc] initWithNibName:@"FRAddInstrumentViewController" bundle:nil];
    [self.navigationController pushViewController:addInstrumentViewController
                                         animated:YES];
}

#pragma mark - UITextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameTextView)
        [self.emailTextView becomeFirstResponder];
    if (textField == self.emailTextView)
        [self.phoneTextView becomeFirstResponder];
    if (textField == self.phoneTextView) {
        [textField resignFirstResponder];
    }
    return YES;
}

@end
