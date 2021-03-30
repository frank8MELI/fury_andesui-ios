//
//  SnackbarObjCViewController.m
//  AndesUI-demoapp
//
//  Created by Samuel Sainz on 6/30/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

#import "SnackbarObjCViewController.h"
#import <AndesUI/AndesUI-Swift.h>

@interface SnackbarObjCViewController ()

@property (weak, nonatomic) IBOutlet AndesButton *showFirstSnackbar;
@property (weak, nonatomic) IBOutlet AndesButton *showSecondSnackbar;
@property (weak, nonatomic) IBOutlet AndesButton *showThirdSnackbar;

@end

@implementation SnackbarObjCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.showFirstSnackbar.text = @"Show Success with short duration";
    self.showSecondSnackbar.text = @"Show Error with normal duration";
    self.showThirdSnackbar.text = @"Show Neutral with long duration";
}

- (IBAction)showFirstSnackbarTapped:(id)sender {
    AndesSnackbar *snackbar = [[AndesSnackbar alloc] initWithText:@"Showing some handsome Snackbar"
                                                         duration:AndesSnackbarDurationShort
                                                             type:AndesSnackbarTypeSuccess];
    [snackbar show];
}

- (IBAction)showSecondSnackbarTapped:(id)sender {
    AndesSnackbar *snackbar = [[AndesSnackbar alloc] initWithText:@"Showing some handsome Snackbar"
                                                         duration:AndesSnackbarDurationNormal
                                                             type:AndesSnackbarTypeError];
    [snackbar show];
}

- (IBAction)showThirdSnackbarTapped:(id)sender {
    AndesSnackbar *snackbar = [[AndesSnackbar alloc] initWithText:@"Showing some handsome Snackbar"
                                                         duration:AndesSnackbarDurationLong
                                                             type:AndesSnackbarTypeNeutral];
    snackbar.action = [[AndesSnackbarAction alloc] initWithText:@"DISMISS" callback:nil];
    [snackbar show];
}

@end
