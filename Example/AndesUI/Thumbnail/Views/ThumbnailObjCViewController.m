//
//  ThumbnailObjCViewController.m
//  AndesUI-demoapp
//
//  Created by Alejo Echeguia on 01/07/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

#import "ThumbnailObjCViewController.h"
#import <AndesUI-Swift.h>

@interface ThumbnailObjCViewController ()
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UILabel *firstTitle;
@property (weak, nonatomic) IBOutlet UILabel *secondTitle;
@property (weak, nonatomic) IBOutlet UIStackView *firstHStackView;
@property (weak, nonatomic) IBOutlet UIStackView *secondHStackView;

@end

@implementation ThumbnailObjCViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.firstTitle.text = @"Images";
	[self createImagesStack];
	self.secondTitle.text = @"Icons";
	[self createIconStack];
}

- (void) createImagesStack {
	[_firstHStackView addArrangedSubview: [self createThumbnail:AndesThumbnailTypeImageCircle hierarchy:AndesThumbnailHierarchyDefaultHierarchy thumbnailStatus:AndesThumbnailStateEnabled]];
	[_firstHStackView addArrangedSubview: [self createThumbnail:AndesThumbnailTypeImageCircle hierarchy:AndesThumbnailHierarchyDefaultHierarchy thumbnailStatus:AndesThumbnailStateDisabled]];
	[_firstHStackView addArrangedSubview: [self createThumbnail:AndesThumbnailTypeImageSquare hierarchy:AndesThumbnailHierarchyDefaultHierarchy thumbnailStatus:AndesThumbnailStateEnabled]];
	[_firstHStackView addArrangedSubview: [self createThumbnail:AndesThumbnailTypeImageSquare hierarchy:AndesThumbnailHierarchyDefaultHierarchy thumbnailStatus:AndesThumbnailStateDisabled]];
}


- (void)createIconStack {
	[_secondHStackView addArrangedSubview: [self createThumbnail: AndesThumbnailTypeIcon hierarchy:AndesThumbnailHierarchyDefaultHierarchy thumbnailStatus:AndesThumbnailStateEnabled]];
	[_secondHStackView addArrangedSubview: [self createThumbnail: AndesThumbnailTypeIcon hierarchy:AndesThumbnailHierarchyDefaultHierarchy thumbnailStatus:AndesThumbnailStateDisabled]];
	[_secondHStackView addArrangedSubview: [self createThumbnail: AndesThumbnailTypeIcon hierarchy: AndesThumbnailHierarchyQuiet thumbnailStatus:AndesThumbnailStateEnabled]];
	[_secondHStackView addArrangedSubview: [self createThumbnail: AndesThumbnailTypeIcon hierarchy: AndesThumbnailHierarchyLoud thumbnailStatus:AndesThumbnailStateEnabled]];
	[_secondHStackView addArrangedSubview: [self createThumbnail: AndesThumbnailTypeIcon hierarchy: AndesThumbnailHierarchyQuiet thumbnailStatus:AndesThumbnailStateDisabled]];
}

- (UIStackView*)createThumbnail: (AndesThumbnailType) type hierarchy:(AndesThumbnailHierarchy) hierarchy thumbnailStatus:(AndesThumbnailState) status   {
	
	NSArray *colors = [NSArray arrayWithObjects:
					   AndesStyleSheetManager.styleSheet.feedbackColorPositive,
					   AndesStyleSheetManager.styleSheet.feedbackColorCaution,
					   AndesStyleSheetManager.styleSheet.feedbackColorNegative,
					   AndesStyleSheetManager.styleSheet.brandColor500, nil];
	
	
	UIStackView* iconStack  = [[UIStackView alloc] init];
	iconStack .axis = UILayoutConstraintAxisVertical;
	iconStack .alignment = UIStackViewAlignmentCenter;
	iconStack .distribution = UIStackViewDistributionFillProportionally;
	iconStack .spacing = 3.0;
	
	for (int i = 0; i < 8; i++)
	{
		AndesThumbnailSize size = (AndesThumbnailSize)i;
		AndesThumbnail *iconDefault = [[AndesThumbnail alloc] initWithHierarchy:hierarchy type:type size:size state:status image:[self getThumbnailImage:type] accentColor:colors[i % 4]];
		[iconStack addArrangedSubview:iconDefault];
	}
	
	return iconStack;
}

- (UIImage*) getThumbnailImage: (AndesThumbnailType) type {
	
	UIImage *thumbnailImage;
	switch (type) {
		case AndesThumbnailTypeIcon:
			thumbnailImage = [self getIcon];
			break;
		case AndesThumbnailTypeImageCircle:
		case AndesThumbnailTypeImageSquare:
			thumbnailImage = [self getImage];
		default:
			break;
	}
	return thumbnailImage;
}

- (UIImage *) getIcon {
	__block UIImage* iconImage;
	[AndesIconsProvider loadIconWithName:@"andes_navegacion_notificaciones_24" success:^(UIImage * icon) {
		iconImage = icon;
	}];
	
	return iconImage;
}

- (UIImage *) getImage {
	return [UIImage imageNamed:@"thumbnailImageVertical"];
}

@end
