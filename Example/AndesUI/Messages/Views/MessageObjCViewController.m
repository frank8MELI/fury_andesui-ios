//
//  MessageObjCViewController.m
//  AndesUI_Example
//
//  Created by Nicolas Rostan Talasimov on 1/17/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//


#import "MessageObjCViewController.h"

#import <AndesUI-Swift.h>

@interface MessageObjCViewController ()
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (nonatomic, retain) IBOutletCollection(AndesMessage) NSArray *andesMessagesWithThumbnail;

@end

@implementation MessageObjCViewController

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
    __weak typeof(self) weakSelf = self;
    
    _stackView.translatesAutoresizingMaskIntoConstraints = false;
    AndesMessage* view = [[AndesMessage alloc] initWithHierarchy:AndesMessageHierarchyQuiet type:AndesMessageTypeSuccess title:@"Message title" body:@"Message body\nSuccess - Quiet"];
    [_stackView addArrangedSubview:view];
    [view.widthAnchor constraintEqualToAnchor:_stackView.widthAnchor].active = YES;
    
    view = [[AndesMessage alloc] initWithHierarchy:AndesMessageHierarchyLoud type:AndesMessageTypeNeutral title:@"Message title" body:@"Message body\nNeutral - Quiet - With Actions"];
    [view setPrimaryAction:@"Action" handler: ^(AndesMessage* message){
        [weakSelf handleActionTap:message];
    }];
    [view setSecondaryAction:@"Secondary Action" handler: ^(AndesMessage* message){
        [weakSelf handleActionTap:message];
    }];
    [_stackView addArrangedSubview:view];
    [view.widthAnchor constraintEqualToAnchor:_stackView.widthAnchor].active = YES;
    
    view = [[AndesMessage alloc] initWithHierarchy:AndesMessageHierarchyQuiet type:AndesMessageTypeError title:@"" body:@"Message Without title\nError - Quiet"];
    [view setPrimaryAction:@"Just Primary" handler: ^(AndesMessage* message){
        [weakSelf handleActionTap:message];
    }];
    [_stackView addArrangedSubview:view];
    [view.widthAnchor constraintEqualToAnchor:_stackView.widthAnchor].active = YES;
    
    view = [[AndesMessage alloc] initWithHierarchy:AndesMessageHierarchyLoud type:AndesMessageTypeWarning title:@"Message title" body:@"Message body\nWarning - Loud"];
    [_stackView addArrangedSubview:view];
    [view.widthAnchor constraintEqualToAnchor:_stackView.widthAnchor].active = YES;
    
    AndesBullet* bullet1 = [[AndesBullet alloc] initWithText:@"Bullet 1 Example."];
    AndesBullet* bullet2 = [[AndesBullet alloc] initWithText:@"Bullet 2 Example."];
    AndesBullet* bullet3 = [[AndesBullet alloc] initWithText:@"Bullet 3 Example."];
    
    NSArray * bulletArray = [NSArray arrayWithObjects:bullet1,bullet2,bullet3, nil];
    
    view = [[AndesMessage alloc] initWithHierarchy: AndesMessageHierarchyLoud type: AndesMessageTypeNeutral title: @"Message title" body: @"This is an Andes Message body with neutral - loud style with bullets" bullets: bulletArray];
    
    [_stackView addArrangedSubview:view];
    [view.widthAnchor constraintEqualToAnchor:_stackView.widthAnchor].active = YES;
    
    for(AndesMessage *message in self.andesMessagesWithThumbnail) {
        message.thumbnail = [UIImage imageNamed:@"avatar-example"];
    }
}

@end
