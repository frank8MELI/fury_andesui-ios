//
//  TagObjCViewController.m
//  AndesUI-demoapp
//
//  Created by Samuel Sainz on 5/29/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

#import "TagObjCViewController.h"
#import <AndesUI/AndesUI-Swift.h>

@interface TagObjCViewController ()

@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@end

@implementation TagObjCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup {
    _stackView.translatesAutoresizingMaskIntoConstraints = false;
    
    [self setupTags];
}

- (void)setupTags {
    UILabel* tagTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    tagTitle.text = @"Tag Simple";
    tagTitle.font = [UIFont systemFontOfSize:24];
    [_stackView addArrangedSubview:tagTitle];
    
    UIStackView* tagsStack = [[UIStackView alloc] init];
    tagsStack.axis = UILayoutConstraintAxisHorizontal;
    tagsStack.spacing = 10.0;

    UIStackView* leftTags = [[UIStackView alloc] init];
    leftTags.axis = UILayoutConstraintAxisVertical;
    leftTags.alignment = UIStackViewAlignmentCenter;
    leftTags.distribution = UIStackViewDistributionFillProportionally;
    leftTags.spacing = 6.0;
    
    UILabel* smallTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    smallTitle.text = @"Tag size: Small";
    smallTitle.font = [UIFont systemFontOfSize:16];
    [leftTags addArrangedSubview:smallTitle];
    
    [self addSimpleTagsWithSize:AndesTagSizeSmall toStack:leftTags];
    
    UILabel* largeTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    largeTitle.text = @"Tag size: Large";
    largeTitle.font = [UIFont systemFontOfSize:16];
    [largeTitle.heightAnchor constraintEqualToConstant:26].active = YES;
    [leftTags addArrangedSubview:largeTitle];

    [self addSimpleTagsWithSize:AndesTagSizeLarge toStack:leftTags];
    
    UIStackView* rightTags = [[UIStackView alloc] init];
    rightTags.axis = UILayoutConstraintAxisVertical;
    rightTags.alignment = UIStackViewAlignmentCenter;
    rightTags.distribution = UIStackViewDistributionEqualCentering;
    rightTags.spacing = 6.0;

    [self addSimpleTagsWithLeftContentToStack:rightTags];

    [tagsStack addArrangedSubview:leftTags];
    [tagsStack addArrangedSubview:rightTags];
    [_stackView addArrangedSubview:tagsStack];

}

- (void)addSimpleTagsWithSize:(AndesTagSize)size toStack:(UIStackView *)stackView
{
    AndesTagSimple *smallTag = [[AndesTagSimple alloc] initWithText:@"Some tag" size:size type:AndesTagTypeNeutral isDismissible:NO];
    [stackView addArrangedSubview:smallTag];
    
    AndesTagSimple *dismissibleTag = [[AndesTagSimple alloc] initWithText:@"Dismissible" size:size type:AndesTagTypeNeutral isDismissible:YES];
    [stackView addArrangedSubview:dismissibleTag];
    
    AndesTagSimple *successTag = [[AndesTagSimple alloc] initWithText:@"Success" size:size type:AndesTagTypeSuccess isDismissible:YES];
    [stackView addArrangedSubview:successTag];
    
    AndesTagSimple *errorTag = [[AndesTagSimple alloc] initWithText:@"Error tag" size:size type:AndesTagTypeError isDismissible:NO];
    [stackView addArrangedSubview:errorTag];
    
    AndesTagSimple *warningTag = [[AndesTagSimple alloc] initWithText:@"Warning tag" size:size type:AndesTagTypeWarning isDismissible:YES];
    [stackView addArrangedSubview:warningTag];
    
    AndesTagSimple *highlightTag = [[AndesTagSimple alloc] initWithText:@"Highligh" size:size type:AndesTagTypeHighlight isDismissible:NO];
    [stackView addArrangedSubview:highlightTag];
}

- (void)addSimpleTagsWithLeftContentToStack:(UIStackView *)stackView
{
    UILabel* smallTagsTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    smallTagsTitle.text = @"Large with left content";
    smallTagsTitle.font = [UIFont systemFontOfSize:16];
    [stackView addArrangedSubview:smallTagsTitle];
    
    AndesTagSimple *yellowTag = [[AndesTagSimple alloc] initWithText:@"Amarillo" size:AndesTagSizeLarge type:AndesTagTypeNeutral isDismissible:NO];
    AndesTagLeftContentDot *leftContentYellowDot = [[AndesTagLeftContentDot alloc] initWithBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:230.0/255.0 blue:2.0/255.0 alpha:1.0]];
    yellowTag.leftContent = leftContentYellowDot;
    [stackView addArrangedSubview:yellowTag];
    
    AndesTagLeftContentDot *leftContentAccentDot = [[AndesTagLeftContentDot alloc] initWithBackgroundColor:AndesStyleSheetManager.styleSheet.brandColor500];
    AndesTagSimple *dismissibleAccentTag = [[AndesTagSimple alloc] initWithText:@"Accent" size:AndesTagSizeLarge type:AndesTagTypeNeutral isDismissible:YES leftContent:leftContentAccentDot];
    [stackView addArrangedSubview:dismissibleAccentTag];
    
    AndesTagLeftContentDot *leftContentAccentDotText = [[AndesTagLeftContentDot alloc] initWithBackgroundColor:AndesStyleSheetManager.styleSheet.accentColor text:@"CF" textColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    AndesTagSimple *textAccentTag = [[AndesTagSimple alloc] initWithText:@"Camila Farias" size:AndesTagSizeLarge type:AndesTagTypeNeutral isDismissible:NO leftContent:leftContentAccentDotText];
    [stackView addArrangedSubview:textAccentTag];
    
    AndesTagLeftContentDot *leftContentDotText = [[AndesTagLeftContentDot alloc] initWithBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] text:@"CF" textColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    AndesTagSimple *leftContentDotTag = [[AndesTagSimple alloc] initWithText:@"Camila Farias" size:AndesTagSizeLarge type:AndesTagTypeNeutral isDismissible:YES leftContent:leftContentDotText];
    [stackView addArrangedSubview:leftContentDotTag];
    
    AndesTagLeftContentIcon *leftContentIconCheck = [[AndesTagLeftContentIcon alloc] initWithBackgroundColor:AndesStyleSheetManager.styleSheet.feedbackColorPositive andesIconName:@"andes_ui_feedback_success_24" iconColor:UIColor.whiteColor];
    AndesTagSimple *leftContentIconCheckTag = [[AndesTagSimple alloc] initWithText:@"Tag con icono" size:AndesTagSizeLarge type:AndesTagTypeNeutral isDismissible:NO leftContent:leftContentIconCheck];
    [stackView addArrangedSubview:leftContentIconCheckTag];
    
    AndesTagLeftContentIcon *leftContentIconSettings = [[AndesTagLeftContentIcon alloc] initWithBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] icon:[UIImage imageNamed:@"example-phone"] iconColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    AndesTagSimple *leftContentIconSettingsTag = [[AndesTagSimple alloc] initWithText:@"Tag con icono" size:AndesTagSizeLarge type:AndesTagTypeNeutral isDismissible:YES leftContent:leftContentIconSettings];
    [stackView addArrangedSubview:leftContentIconSettingsTag];
    
    UIImage *avatar = [UIImage imageNamed:@"item-example"];
    AndesTagLeftContentImage *leftContentImage = [[AndesTagLeftContentImage alloc] initWithAvatar:avatar];
    AndesTagSimple *leftContentImageTag = [[AndesTagSimple alloc] initWithText:@"Tag con icono" size:AndesTagSizeLarge type:AndesTagTypeNeutral isDismissible:YES leftContent:leftContentImage];
    [stackView addArrangedSubview:leftContentImageTag];
    
    UIImage *avatarImage = [UIImage imageNamed:@"avatar-example"];
    AndesTagLeftContentImage *leftContentImageAvatar = [[AndesTagLeftContentImage alloc] initWithAvatar:avatarImage];
    AndesTagSimple *leftContentImageAvatarTag = [[AndesTagSimple alloc] initWithText:@"Tag con icono" size:AndesTagSizeLarge type:AndesTagTypeNeutral isDismissible:YES leftContent:leftContentImageAvatar];
    [stackView addArrangedSubview:leftContentImageAvatarTag];
}

@end
