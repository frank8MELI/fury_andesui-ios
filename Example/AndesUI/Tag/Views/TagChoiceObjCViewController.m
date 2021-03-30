//
//  TagChoiceObjCViewController.m
//  AndesUI-demoapp
//
//  Created by Facundo Conil on 9/29/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

#import "TagChoiceObjCViewController.h"
#import <AndesUI/AndesUI-Swift.h>

@interface TagChoiceObjCViewController ()

@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@end

@implementation TagChoiceObjCViewController

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
    tagTitle.text = @"Tag Choice";
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
    
    [self addChoiceTagsWithSize:AndesTagSizeSmall toStack:leftTags];
    
    UILabel* largeTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    largeTitle.text = @"Tag size: Large";
    largeTitle.font = [UIFont systemFontOfSize:16];
    [largeTitle.heightAnchor constraintEqualToConstant:26].active = YES;
    [leftTags addArrangedSubview:largeTitle];

    [self addChoiceTagsWithSize:AndesTagSizeLarge toStack:leftTags];
    
    UIStackView* rightTags = [[UIStackView alloc] init];
    rightTags.axis = UILayoutConstraintAxisVertical;
    rightTags.alignment = UIStackViewAlignmentCenter;
    rightTags.distribution = UIStackViewDistributionEqualCentering;
    rightTags.spacing = 6.0;

    [self addSimpleTagsWithLeftContentToStack:rightTags];

    [tagsStack addArrangedSubview:leftTags];
    [tagsStack addArrangedSubview:rightTags];
    [_stackView addArrangedSubview:tagsStack];
    
    UILabel* selectableTagTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    selectableTagTitle.text = @"Selectable Tags";
    selectableTagTitle.font = [UIFont systemFontOfSize:24];
    [_stackView addArrangedSubview:selectableTagTitle];
    
    UIStackView* selectableTagsStack = [[UIStackView alloc] init];
    selectableTagsStack.axis = UILayoutConstraintAxisHorizontal;
    selectableTagsStack.spacing = 10.0;
    
    [self addChoiceSelectableTags:selectableTagsStack];
    [_stackView addArrangedSubview:selectableTagsStack];
}

- (void)addChoiceTagsWithSize:(AndesTagSize)size toStack:(UIStackView *)stackView
{
    AndesTagChoice *simpleTag = [[AndesTagChoice alloc] initWithText:@"Simple" size:size type:AndesTagChoiceTypeSimple state:AndesTagStateIdle];
    [stackView addArrangedSubview:simpleTag];
    
    AndesTagChoice *dropdownTag = [[AndesTagChoice alloc] initWithText:@"Dropdown" size:size type:AndesTagChoiceTypeDropdown state:AndesTagStateIdle];
    [stackView addArrangedSubview:dropdownTag];
    
    AndesTagChoice *simpleTagSelected = [[AndesTagChoice alloc] initWithText:@"Simple Selected" size:size type:AndesTagChoiceTypeSimple state:AndesTagStateSelected];
    [stackView addArrangedSubview:simpleTagSelected];
    
    AndesTagChoice *dropdownTagSelected = [[AndesTagChoice alloc] initWithText:@"Dropdown Selected" size:size type:AndesTagChoiceTypeDropdown state:AndesTagStateSelected];
    [stackView addArrangedSubview:dropdownTagSelected];
}

- (void)addSimpleTagsWithLeftContentToStack:(UIStackView *)stackView
{
    UILabel* smallTagsTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    smallTagsTitle.text = @"Large with left content";
    smallTagsTitle.font = [UIFont systemFontOfSize:16];
    [stackView addArrangedSubview:smallTagsTitle];
    
    AndesTagChoice *yellowTag = [[AndesTagChoice alloc] initWithText:@"Amarillo" size:AndesTagSizeLarge type:AndesTagChoiceTypeSimple state:AndesTagStateIdle];
    AndesTagLeftContentDot *leftContentYellowDot = [[AndesTagLeftContentDot alloc] initWithBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:230.0/255.0 blue:2.0/255.0 alpha:1.0]];
    yellowTag.leftContent = leftContentYellowDot;
    [stackView addArrangedSubview:yellowTag];
    
    AndesTagLeftContentDot *leftContentAccentDot = [[AndesTagLeftContentDot alloc] initWithBackgroundColor:AndesStyleSheetManager.styleSheet.brandColor500];
    AndesTagChoice *dismissibleAccentTag = [[AndesTagChoice alloc] initWithText:@"Accent" size:AndesTagSizeLarge type:AndesTagChoiceTypeSimple state:AndesTagStateSelected leftContent:leftContentAccentDot];
    [stackView addArrangedSubview:dismissibleAccentTag];
    
    AndesTagLeftContentDot *leftContentAccentDotText = [[AndesTagLeftContentDot alloc] initWithBackgroundColor:AndesStyleSheetManager.styleSheet.accentColor text:@"CF" textColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    AndesTagChoice *textAccentTag = [[AndesTagChoice alloc] initWithText:@"Camila Farias" size:AndesTagSizeLarge type:AndesTagChoiceTypeSimple state:AndesTagStateIdle leftContent:leftContentAccentDotText];
    [stackView addArrangedSubview:textAccentTag];
    
    AndesTagLeftContentDot *leftContentDotText = [[AndesTagLeftContentDot alloc] initWithBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] text:@"CF" textColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    AndesTagChoice *leftContentDotTag = [[AndesTagChoice alloc] initWithText:@"Camila Farias" size:AndesTagSizeLarge type:AndesTagChoiceTypeSimple state:AndesTagStateSelected leftContent:leftContentDotText];
    [stackView addArrangedSubview:leftContentDotTag];
    
    AndesTagLeftContentIcon *leftContentIconCheck = [[AndesTagLeftContentIcon alloc] initWithBackgroundColor:UIColor.clearColor andesIconName:@"andes_control_y_accion_buscar_16" iconColor:UIColor.whiteColor];
    AndesTagChoice *leftContentIconCheckTag = [[AndesTagChoice alloc] initWithText:@"Tag con icono" size:AndesTagSizeLarge type:AndesTagChoiceTypeSimple state:AndesTagStateIdle leftContent:leftContentIconCheck];
    [stackView addArrangedSubview:leftContentIconCheckTag];
    
    AndesTagLeftContentIcon *leftContentIconSettings = [[AndesTagLeftContentIcon alloc] initWithBackgroundColor:UIColor.clearColor icon:[UIImage imageNamed:@"example-phone"] iconColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    AndesTagChoice *leftContentIconSettingsTag = [[AndesTagChoice alloc] initWithText:@"Tag con icono" size:AndesTagSizeLarge type:AndesTagChoiceTypeSimple state:AndesTagStateSelected leftContent:leftContentIconSettings];
    [stackView addArrangedSubview:leftContentIconSettingsTag];
    
    UIImage *avatar = [UIImage imageNamed:@"item-example"];
    AndesTagLeftContentImage *leftContentImage = [[AndesTagLeftContentImage alloc] initWithAvatar:avatar];
    AndesTagChoice *leftContentImageTag = [[AndesTagChoice alloc] initWithText:@"Tag con Avatar" size:AndesTagSizeLarge type:AndesTagChoiceTypeSimple state:AndesTagStateIdle leftContent:leftContentImage];
    [stackView addArrangedSubview:leftContentImageTag];
    
    UIImage *avatarImage = [UIImage imageNamed:@"avatar-example"];
    AndesTagLeftContentImage *leftContentImageAvatar = [[AndesTagLeftContentImage alloc] initWithAvatar:avatarImage];
    AndesTagChoice *leftContentImageAvatarTag = [[AndesTagChoice alloc] initWithText:@"Tag con Avatar" size:AndesTagSizeLarge type:AndesTagChoiceTypeSimple state:AndesTagStateSelected leftContent:leftContentImageAvatar];
    [stackView addArrangedSubview:leftContentImageAvatarTag];
}

- (void)addChoiceSelectableTags: (UIStackView *)stackView
{
    AndesTagChoice *dropdownTag = [[AndesTagChoice alloc] initWithText:@"Dropdown" size:AndesTagSizeLarge type:AndesTagChoiceTypeDropdown state:AndesTagStateIdle];
    [dropdownTag shouldSelectTagWithCallback:^BOOL{
        return YES;
    }];
    [stackView addArrangedSubview:dropdownTag];
    
    AndesTagLeftContentIcon *leftContentIconCheck = [[AndesTagLeftContentIcon alloc] initWithBackgroundColor:UIColor.clearColor andesIconName:@"andes_control_y_accion_buscar_16" iconColor:UIColor.whiteColor];
      AndesTagChoice *simpleTag = [[AndesTagChoice alloc] initWithText:@"Simple" size:AndesTagSizeLarge type:AndesTagChoiceTypeSimple state:AndesTagStateIdle leftContent:leftContentIconCheck];
      [simpleTag shouldSelectTagWithCallback:^BOOL{
          return YES;
      }];
      [stackView addArrangedSubview:simpleTag];
}

@end
