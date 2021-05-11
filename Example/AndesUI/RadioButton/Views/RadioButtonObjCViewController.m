//
//  RadioButtonObjCViewController.m
//  AndesUI-demoapp
//
//  Created by Rodrigo Pintos Costa on 7/3/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

#import "RadioButtonObjCViewController.h"
#import <AndesUI/AndesUI-Swift.h>

@interface RadioButtonObjCViewController ()

@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@end

@implementation RadioButtonObjCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup {
    [self setupRadioButtons];
}

- (void)setupRadioButtons {
        
    UIStackView* radioButtonIdledStack = [[UIStackView alloc] init];
    radioButtonIdledStack.axis = UILayoutConstraintAxisVertical;
    radioButtonIdledStack.alignment = UIStackViewAlignmentCenter;
    radioButtonIdledStack.distribution = UIStackViewDistributionFillProportionally;
    radioButtonIdledStack.spacing = 6.0;
    
    UILabel* idelTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    idelTitle.text = @"Idle RadioButton";
    idelTitle.font = [UIFont systemFontOfSize:24];
    [radioButtonIdledStack addArrangedSubview:idelTitle];
    
    [self addIdelRadioButtons:radioButtonIdledStack];

    UIStackView* radiobuttonDisabledErrorStack = [[UIStackView alloc] init];
    radiobuttonDisabledErrorStack.axis = UILayoutConstraintAxisVertical;
    radiobuttonDisabledErrorStack.alignment = UIStackViewAlignmentCenter;
    radiobuttonDisabledErrorStack.distribution = UIStackViewDistributionEqualCentering;
    radiobuttonDisabledErrorStack.spacing = 6.0;

    [self addDisabledAndErrorRadioButtons:radiobuttonDisabledErrorStack];
    
    [self.stackView addArrangedSubview:radioButtonIdledStack];
    [self.stackView addArrangedSubview:radiobuttonDisabledErrorStack];
}

- (void)addIdelRadioButtons : (UIStackView *)stackView
{
    //LEFT
    AndesRadioButton* selectedStack = [[AndesRadioButton alloc] initWithType:AndesRadioButtonTypeIdle align:AndesRadioButtonAlignLeft status:AndesRadioButtonStatusSelected title:@"Idle Selected" attributedTitle:[[NSMutableAttributedString alloc] initWithString:@"Idle Selected"]label:[UILabel new]];
    
  
    
    [selectedStack setRadioButtonTappedWithCallback:^(AndesRadioButton * selectedStack) {
        [self didRadiobuttonTap:selectedStack];
    }];
        
    [stackView addArrangedSubview:selectedStack];
    
    AndesRadioButton* unselectedStack = [[AndesRadioButton alloc] initWithType:AndesRadioButtonTypeIdle align:AndesRadioButtonAlignLeft status:AndesRadioButtonStatusUnselected title:@"Idle Selected" attributedTitle:[[NSMutableAttributedString alloc] initWithString:@"Idle Unselected"]label:[UILabel new]];
    

    [unselectedStack setRadioButtonTappedWithCallback:^(AndesRadioButton * unselectedStack) {
        [self didRadiobuttonTap:unselectedStack];
    }];
    
    [stackView addArrangedSubview:unselectedStack];
            
    //RIGHT
    
    AndesRadioButton* selectedRightStack = [[AndesRadioButton alloc] initWithType:AndesRadioButtonTypeIdle align:AndesRadioButtonAlignRight status:AndesRadioButtonStatusUnselected title:@"Idle Unselected" attributedTitle:[[NSMutableAttributedString alloc] initWithString:@"Idle Unselected"]label:[UILabel new]];

    
    [selectedRightStack setRadioButtonTappedWithCallback:^(AndesRadioButton * selectedRightStack) {
        [self didRadiobuttonTap:selectedRightStack];
    }];
        
    [stackView addArrangedSubview:selectedRightStack];
    
    AndesRadioButton* unselectedRightStack = [[AndesRadioButton alloc] initWithType:AndesRadioButtonTypeIdle align:AndesRadioButtonAlignRight status:AndesRadioButtonStatusUnselected title:@"Idle Unselected" attributedTitle:[[NSMutableAttributedString alloc] initWithString:@"Idle Unselected"]label:[UILabel new]];
    
    [unselectedRightStack setRadioButtonTappedWithCallback:^(AndesRadioButton * unselectedRightStack) {
          [self didRadiobuttonTap:unselectedRightStack];
      }];
        
    [stackView addArrangedSubview:unselectedRightStack];
}

- (void)addDisabledAndErrorRadioButtons:(UIStackView *)stackView
{
    UILabel* disabledTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    disabledTitle.text = @"Disabled and Error";
    disabledTitle.font = [UIFont systemFontOfSize:24];
    [stackView addArrangedSubview:disabledTitle];
    
    //DISABLED
    AndesRadioButton* disabledStack = [[AndesRadioButton alloc] initWithType:AndesRadioButtonTypeDisabled align:AndesRadioButtonAlignLeft status:AndesRadioButtonStatusUnselected title:@"Disabled Selected" attributedTitle:[[NSMutableAttributedString alloc] initWithString:@"Disabled Selected"]label:[UILabel new]];
   
    
    [stackView addArrangedSubview:disabledStack];
    
    AndesRadioButton* selectedRightStack = [[AndesRadioButton alloc] initWithType:AndesRadioButtonTypeDisabled align:AndesRadioButtonAlignRight status:AndesRadioButtonStatusUnselected title:@"Disabled Selected" attributedTitle:[[NSMutableAttributedString alloc] initWithString:@"Disabled Selected"]label:[UILabel new]];
    
    
    [stackView addArrangedSubview:selectedRightStack];
    
    AndesRadioButton* unselectedStack = [[AndesRadioButton alloc] initWithType:AndesRadioButtonTypeDisabled align:AndesRadioButtonAlignLeft status:AndesRadioButtonStatusUnselected title:@"Disabled Selected" attributedTitle:[[NSMutableAttributedString alloc] initWithString:@"Disabled Selected"]label:[UILabel new]];
        
        
    [stackView addArrangedSubview:unselectedStack];
            
    //ERROR
    AndesRadioButton* unselectedErrorStack = [[AndesRadioButton alloc] initWithType:AndesRadioButtonTypeError align:AndesRadioButtonAlignLeft status:AndesRadioButtonStatusUnselected title:@"Error Unselected" attributedTitle:[[NSMutableAttributedString alloc] initWithString:@"Error Unselected"]label:[UILabel new] ];
    
    
    [unselectedErrorStack setRadioButtonTappedWithCallback:^(AndesRadioButton * unselectedErrorStack) {
          [self didRadiobuttonTap:unselectedErrorStack];
      }];
    
    [stackView addArrangedSubview:unselectedErrorStack];
    
    AndesRadioButton* unselectedErrorRightStack = [[AndesRadioButton alloc] initWithType:AndesRadioButtonTypeError align:AndesRadioButtonAlignRight status:AndesRadioButtonStatusUnselected title:@"Error Unselected" attributedTitle:[[NSMutableAttributedString alloc] initWithString:@"Error Unselected"]label:[UILabel new]];
    
    
     [unselectedErrorRightStack setRadioButtonTappedWithCallback:^(AndesRadioButton * unselectedErrorRightStack) {
          [self didRadiobuttonTap:unselectedErrorRightStack];
      }];
    
    [stackView addArrangedSubview:unselectedErrorRightStack];
}

- (void)didRadiobuttonTap:(AndesRadioButton*)radioButton {
    UIAlertController *alert = [[UIAlertController alloc] init];
    switch (radioButton.type) {
    case AndesRadioButtonTypeIdle:
        if (radioButton.status == AndesRadioButtonStatusUnselected) {
            alert = [UIAlertController alertControllerWithTitle:@"AndesUI RadioButton"
            message:@"RadioButton idle unselected pressed"
            preferredStyle:UIAlertControllerStyleAlert];
        } else {
            alert = [UIAlertController alertControllerWithTitle:@"AndesUI RadioButton"
            message:@"RadioButton idle selected pressed"
            preferredStyle:UIAlertControllerStyleAlert];
        }
    case AndesRadioButtonTypeDisabled:
            break;
    case AndesRadioButtonTypeError:
        alert = [UIAlertController alertControllerWithTitle:@"AndesUI RadioButton"
           message:@"RadioButton error pressed"
           preferredStyle:UIAlertControllerStyleAlert];
        break;
    }
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
