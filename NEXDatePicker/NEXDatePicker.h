//
//  NEXDatePicker.h
//  NEXDatePicker
//
//  Created by Michael Rebello on 4/14/15.
//  Copyright (c) 2015 NEXMachine, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NEXDatePickerDelegate;

//Picker allowing for custom date format displays. This should NOT be used for time/datetime selection
@interface NEXDatePicker : UIPickerView <UIPickerViewDataSource, UIPickerViewDelegate> {
    
    NSDateFormatter *dateFormatter;
    
    NSCalendar *calendar;
}

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, weak) id<NEXDatePickerDelegate> pickerDelegate;

///Initializes the date picker with a particular date formatter for displaying and a callback delegate
-(id)initWithDateFormat:(NSString *)dateFormat pickerDelegate:(id<NEXDatePickerDelegate>)del;

///Selects a new date on the date picker
-(void)selectDate:(NSDate *)date animated:(BOOL)animated;

@end

//Protocol for this picker
@protocol NEXDatePickerDelegate <NSObject>
@optional
///Called when the user selects a date. Returns the NSDate and formatted string
-(void)nexDatePicker:(NEXDatePicker *)picker selectedDate:(NSDate *)date string:(NSString *)stringValue;
@end