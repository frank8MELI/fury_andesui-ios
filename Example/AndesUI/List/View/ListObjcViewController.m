//
//  ListViewObjcViewController.m
//  AndesUI-demoapp
//
//  Created by Jonathan Alonso Pinto on 21/10/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

#import "ListObjcViewController.h"
#import <AndesUI-Swift.h>

@interface ListObjcViewController ()
@property (weak, nonatomic) IBOutlet AndesList *listView;

@end

@implementation ListObjcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.separatorStyle = AndesSeparatorStyleSingleLine;
    _listView.size = AndesListSizeLarge;
}

- (AndesListCell * _Nonnull)andesList:(AndesList * _Nonnull)tableView cellForRowAt:(NSIndexPath * _Nonnull)indexPath {
    
    AndesThumbnail *thumbnail = [[AndesThumbnail alloc]initWithHierarchy:AndesThumbnailHierarchyDefaultHierarchy
                                                                    type:AndesThumbnailTypeIcon
                                                                    size:AndesThumbnailSizeSize24
                                                                   state:AndesThumbnailStateEnabled
                                                                   image:[UIImage imageNamed:@"clip"]
                                                             accentColor:NULL];
    
    AndesSimpleCell *cell = [[AndesSimpleCell alloc]
                             initWithTitle:[NSString
                                            stringWithFormat:@"Lorem ipsum dolor sit amet title - %ld", (long)indexPath.row]
                             subtitle: @"Lorem ipsum dolor sit amet description"
                             thumbnail: thumbnail
                             numberOfLines: 2];


    
    
    return cell;
}

- (NSInteger)andesList:(AndesList * _Nonnull)listView numberOfRowsInSection:(NSInteger)section {
    return 100;
}


- (NSInteger)numberOfSections:(AndesList * _Nonnull)listView {
    return [self getRandomNumberBetween:500 to:1200];
}

-(int)getRandomNumberBetween:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}

@end
