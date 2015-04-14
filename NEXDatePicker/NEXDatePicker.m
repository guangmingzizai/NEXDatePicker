//
//  NEXDatePicker.m
//  NEXDatePicker
//
//  Created by Michael Rebello on 4/14/15.
//  Copyright (c) 2015 NEXMachine, LLC. All rights reserved.
//

#import "NEXDatePicker.h"

@implementation NEXDatePicker

#define NEX_TODAY [NSDate date]
#define UTC_TIME_ZONE [NSTimeZone timeZoneWithAbbreviation:@"UTC"]
#define ROW_COUNT INT16_MAX

#pragma mark - Initialization

-(id)initWithDateFormat:(NSString *)dateFormat pickerDelegate:(id<NEXDatePickerDelegate>)del {
    
    self = [super init];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.pickerDelegate = del;
        
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:dateFormat];
        [dateFormatter setTimeZone:UTC_TIME_ZONE];
        
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        self.date = NEX_TODAY;
        
        [self selectRow:(ROW_COUNT / 2) inComponent:0 animated:FALSE]; //Go to the middle of the list
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
    
    //Scroll to the appropriate date
    NSTimeInterval timeToDate = [date timeIntervalSinceDate:NEX_TODAY];
    NSInteger daysToDate = timeToDate / 60 / 60 / 24;
    NSInteger row = ((ROW_COUNT / 2) + daysToDate);
    [self selectRow:row inComponent:0 animated:animated];
    [self pickerView:self didSelectRow:row inComponent:0]; //Since the method won't be called automatically
}

-(NSDate *)dateForRow:(NSInteger)row {
    
    //Convert to get to the actual date
    NSInteger todayIdx = ROW_COUNT / 2;
    NSInteger dayOffset = row - todayIdx;
    
    //Add the appropriate number of days
    return [NEX_TODAY dateByAddingTimeInterval:(60 * 60 * 24 * dayOffset)];
}

#pragma mark - Data source

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return ROW_COUNT; //Essentially infinite
}

#pragma mark - Delegation

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return self.frame.size.width;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (row == ROW_COUNT / 2) {
        
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
