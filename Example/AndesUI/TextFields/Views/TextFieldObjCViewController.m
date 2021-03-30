//
//  TextFieldObjCViewController.m
//  AndesUI-demoapp
//
//  Created by Martin Damico on 13/03/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

#import "TextFieldObjCViewController.h"

#import <AndesUI-Swift.h>

@interface TextFieldObjCViewController ()
@property (weak, nonatomic) IBOutlet AndesTextField *textField1;
@property (weak, nonatomic) IBOutlet AndesTextField *textField2;
@property (weak, nonatomic) IBOutlet AndesTextField *textField3;
@property (weak, nonatomic) IBOutlet AndesTextField *textFieldIcon;
@property (weak, nonatomic) IBOutlet AndesTextField *textFieldWithCheck;
@property (weak, nonatomic) IBOutlet AndesTextField *textFieldWIthAction;
@property (weak, nonatomic) IBOutlet AndesTextField *textFieldPrefix;
@property (weak, nonatomic) IBOutlet AndesTextField *textFieldSuffix;

@end

@implementation TextFieldObjCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void) handleActionTap:(AndesMessage*)message {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Action Pressed"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:nil];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)setup {
    _textField1.rightContent = [[AndesTextFieldComponentClear alloc] init];
    AndesTextFieldComponentIcon* icon = [[AndesTextFieldComponentIcon alloc] initWithAndesIconName:@"andes_control_y_accion_buscar_20" tintColor:AndesStyleSheetManager.styleSheet.textColorPrimary];
    _textFieldIcon.rightContent = icon;
    _textFieldIcon.leftContent = icon;
    _textFieldWithCheck.rightContent = [[AndesTextFieldComponentCheck alloc] init];
    _textFieldPrefix.leftContent = [[AndesTextFieldComponentLabel alloc] initWithText:@"Prefix"];
    _textFieldSuffix.rightContent = [[AndesTextFieldComponentLabel alloc] initWithText:@"Suffix"];
    _textFieldWIthAction.rightContent = [[AndesTextFieldComponentAction alloc] init:@"Label!"];
    _textFieldWIthAction.delegate = self;
    
}

- (void)andesTextFieldDidTapRightAction: (AndesTextField*) field {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Action Pressed"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:nil];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end

