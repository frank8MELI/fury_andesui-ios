//
//  DatePickerObjCViewController.m
//  AndesUI-demoapp
//
//  Created by Ândriu Felipe Coelho on 17/11/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

#import "DatePickerObjCViewController.h"

@interface DatePickerObjCViewController ()

@property (weak, nonatomic) IBOutlet AndesDatePicker *datePickerView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation DatePickerObjCViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDatePicker];
}

- (void)setupDatePicker {
    [self.datePickerView setDatePickerDateWithMaxDate:nil callback:^(NSDate * selectedDate, BOOL isConfirmed) {
        if (isConfirmed) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd/MM/yyyy"];
            NSString *newDate = [dateFormatter stringFromDate:selectedDate];
            
            self.dateLabel.text = newDate;
        }
    }];
}

@end
