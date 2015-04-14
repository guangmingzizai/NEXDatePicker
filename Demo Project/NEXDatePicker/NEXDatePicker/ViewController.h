//
//  ViewController.h
//  NEXDatePicker
//
//  Created by Michael Rebello on 4/14/15.
//  Copyright (c) 2015 NEXMachine, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NEXDatePicker.h"

@interface ViewController : UIViewController <NEXDatePickerDelegate> {
    
    NEXDatePicker *pickerView;
    
    __weak IBOutlet UILabel *infoL;
}

-(IBAction)changePickerState:(UIButton *)sender;
-(IBAction)goToToday;

-(void)nexDatePicker:(NEXDatePicker *)picker selectedDate:(NSDate *)date string:(NSString *)stringValue;

@end

