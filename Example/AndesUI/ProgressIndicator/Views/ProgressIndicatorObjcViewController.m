//
//  ProgressIndicatorObjcViewController.m
//  AndesUI-demoapp
//
//  Created by Juan Andres Vasquez Ferrer on 09-12-20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

#import "ProgressIndicatorObjcViewController.h"
#import <AndesUI/AndesUI-Swift.h>

@interface ProgressIndicatorObjcViewController ()
@property (weak, nonatomic) IBOutlet AndesProgressIndicatorIndeterminate *progressIndicatorLargeWithText;
@property (weak, nonatomic) IBOutlet AndesProgressIndicatorIndeterminate *progressIndicatorMediumWithText;
@property (weak, nonatomic) IBOutlet AndesProgressIndicatorIndeterminate *progressIndicatorSmallWithText;

@property (weak, nonatomic) IBOutlet AndesProgressIndicatorIndeterminate *progressIndicatorXSmallWithText;


@property (weak, nonatomic) IBOutlet AndesProgressIndicatorIndeterminate *progressIndicatorLargeWithoutText;
@property (weak, nonatomic) IBOutlet AndesProgressIndicatorIndeterminate *progressIndicatorMediumWithoutText;
@property (weak, nonatomic) IBOutlet AndesProgressIndicatorIndeterminate *progressIndicatorSmallWithoutText;

@property (weak, nonatomic) IBOutlet AndesProgressIndicatorIndeterminate *progressIndicatorXSmallWithoutText;


@end

@implementation ProgressIndicatorObjcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Objc Cases";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startAnimation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopAnimation];
}

- (void) startAnimation {
    [self.progressIndicatorLargeWithText startAnimation];
    [self.progressIndicatorMediumWithText startAnimation];
    [self.progressIndicatorSmallWithText startAnimation];
    [self.progressIndicatorXSmallWithText startAnimation];

    
    [self.progressIndicatorLargeWithoutText startAnimation];
    [self.progressIndicatorMediumWithoutText startAnimation];
    [self.progressIndicatorSmallWithoutText startAnimation];
    [self.progressIndicatorXSmallWithoutText startAnimation];

}

- (void)stopAnimation {
    [self.progressIndicatorLargeWithText stopAnimation];
    [self.progressIndicatorMediumWithText stopAnimation];
    [self.progressIndicatorSmallWithText stopAnimation];
    [self.progressIndicatorXSmallWithText stopAnimation];
    
    [self.progressIndicatorLargeWithoutText stopAnimation];
    [self.progressIndicatorMediumWithoutText stopAnimation];
    [self.progressIndicatorSmallWithoutText stopAnimation];
    [self.progressIndicatorXSmallWithoutText stopAnimation];
}

@end
