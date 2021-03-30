//
//  TextFieldsCodeObjCViewController.m
//  AndesUI-demoapp
//
//  Created by Esteban Adrian Boffa on 07/10/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

#import "TextFieldsCodeObjCViewController.h"
#import <AndesUI-Swift.h>

@interface TextFieldsCodeObjCViewController ()

@end

@implementation TextFieldsCodeObjCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.title = @"TextFieldsCodeObjCViewController";
    UILabel *title = [[UILabel alloc] init];
    title.translatesAutoresizingMaskIntoConstraints = false;
    title.text = @"AndesTextFieldCode (Objc)";
    [title setFont:[UIFont boldSystemFontOfSize:20]];
    [self.view addSubview:title];
    [title.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [title.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:24].active = YES;

    AndesTextFieldCode *andesTextFieldCode = [[AndesTextFieldCode alloc] initWithLabel:nil helpLabel:nil style:AndesTextFieldCodeStyleTHREESOME state:AndesTextFieldCodeStateIDLE];
    andesTextFieldCode.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:andesTextFieldCode];

    [andesTextFieldCode.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:32].active = YES;
    [andesTextFieldCode.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-32].active = YES;
    [andesTextFieldCode.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:70].active = YES;
}

@end
