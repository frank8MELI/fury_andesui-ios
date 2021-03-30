//
//  AndesUIViewController.m
//  AndesUI_Example
//
//  Created by Santiago Lazzari on 10/01/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

#import "AndesUIViewController.h"

#import <AndesUI-Swift.h>

@interface AndesUIViewController ()

@property (weak, nonatomic) IBOutlet AndesButton *largeAndesButton;
@property (weak, nonatomic) IBOutlet AndesButton *mediumAndesButton;
@property (weak, nonatomic) IBOutlet AndesButton *smallAndesButton;

@end

@implementation AndesUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup {
    [self setupStyles];
    [self setupSize];
}

- (void)setupStyles {
    [self.largeAndesButton setHierarchy:AndesButtonHierarchyLoud];
    [self.mediumAndesButton setHierarchy:AndesButtonHierarchyQuiet];
    [self.smallAndesButton setHierarchy:AndesButtonHierarchyTransparent];
    
    
}

- (void)setupSize {
    [self.largeAndesButton setLargeSizeWithIcon:[[AndesButtonIcon alloc] initWithIcon:[UIImage imageNamed:@"clip"] orientation:AndesButtonOrientationLeft]];
    [self.mediumAndesButton setSize:AndesButtonSizeMedium];
    [self.smallAndesButton setSize:AndesButtonSizeSmall];
}

@end
