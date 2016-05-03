//
//  NEXDatePicker.m
//  NEXDatePicker
//
//  Created by Michael Rebello on 4/14/15.
//  Copyright (c) 2016 NEXMachine, LLC. All rights reserved.
//

#import "NEXDatePicker.h"

@implementation NEXDatePicker

#define NEX_NOW [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]]
#define NEX_DAY_IN_SECS (60 * 60 * 24)
#define NEX_LOCAL_ZONE [NSTimeZone localTimeZone]
#define NEX_ROW_COUNT INT16_MAX

#pragma mark - Initialization

-(id)initWithDateFormat:(NSString *)dateFormat pickerDelegate:(id<NEXDatePickerDelegate>)del {
    
    self = [super init];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.pickerDelegate = del;
        
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:dateFormat];
        [dateFormatter setTimeZone:NEX_LOCAL_ZONE];
        
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        self.date = NEX_NOW;
        
        [self selectRow:(NEX_ROW_COUNT / 2) inComponent:0 animated:FALSE]; //Go to the middle of the list
    }
    return self;
}

-(id)init {
    
    return [self initWithDateFormat:@"EEE, MMMM d, yyyy" pickerDelegate:nil]; //ie, Sun, January 5, 2015
}

-(void)dealloc {
    
    self.delegate = nil;
    self.dataSource = nil;
    
    dateFormatter = nil;
    calendar = nil;
    self.date = nil;
    
    self.pickerDelegate = nil;
}

#pragma mark - Custom functions

-(void)selectDate:(NSDate *)date animated:(BOOL)animated {
    
    //Convert to absolute time
    NSTimeInterval time = [date timeIntervalSince1970];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970] + [NEX_LOCAL_ZONE secondsFromGMT];
    
    //Grab the days since 1970, ignoring time differences
    int daysSince1970 = floor(time / NEX_DAY_IN_SECS);
    int nowSince1970 = floor(now / NEX_DAY_IN_SECS);
    
    //Scroll to the appropriate date
    NSInteger row = (NEX_ROW_COUNT / 2) + (daysSince1970 - nowSince1970);
    [self selectRow:row inComponent:0 animated:animated];
    [self pickerView:self didSelectRow:row inComponent:0]; //Since the method won't be called automatically
}

-(NSDate *)dateForRow:(NSInteger)row {
    
    //Convert to get to the actual date
    NSInteger todayIdx = NEX_ROW_COUNT / 2;
    NSInteger dayOffset = row - todayIdx;
    
    //Add the appropriate number of days
    return [NEX_NOW dateByAddingTimeInterval:(NEX_DAY_IN_SECS * dayOffset)];
}

#pragma mark - Data source

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return NEX_ROW_COUNT; //Essentially infinite
}

#pragma mark - Delegation

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return self.frame.size.width;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (row == NEX_ROW_COUNT / 2) {
        
        return @"Today";
        
    } else {
     
        NSDate *dateSelected = [self dateForRow:row];
        return [dateFormatter stringFromDate:dateSelected];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.date = [self dateForRow:row];
    
    if ([self.pickerDelegate respondsToSelector:@selector(nexDatePicker:selectedDate:string:)]) {
        [self.pickerDelegate nexDatePicker:self selectedDate:self.date string:[dateFormatter stringFromDate:self.date]];
    }
}

@end
