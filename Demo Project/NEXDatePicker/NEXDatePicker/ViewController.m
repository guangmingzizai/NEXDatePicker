//
//  ViewController.m
//  NEXDatePicker
//
//  Created by Michael Rebello on 4/14/15.
//  Copyright (c) 2015 NEXMachine, LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//Callback when the date picker selects a new date
-(void)nexDatePicker:(NEXDatePicker *)picker selectedDate:(NSDate *)date string:(NSString *)stringValue {
    
    NSLog(@"Selected: %@ (%@)", stringValue, date);
    
    NSLog(@"We could also get the date like this: %@", pickerView.date);
    
    infoL.text = [NSString stringWithFormat:@"Date Selected:\n%@\n(%@)", stringValue, date];
}

-(void)resetPickerFrame {
    
    [pickerView setFrame:CGRectMake(0, self.view.frame.size.height - pickerView.frame.size.height, self.view.frame.size.width, pickerView.frame.size.height)];
}

-(IBAction)changePickerState:(UIButton *)sender {
    
    if (pickerView == nil) {
        
        //Set up the date picker with the date format we want to use (such wow, much customize!)
        pickerView = [[NEXDatePicker alloc] initWithDateFormat:@"EEE, MMMM d, yyyy" pickerDelegate:self];
        
        //Add the picker
        [self.view addSubview:pickerView];
        [pickerView setCenter:CGPointMake(self.view.center.x, self.view.frame.size.height + pickerView.frame.size.height)];
        [UIView animateWithDuration:0.3 animations:^{
            [self resetPickerFrame];
        }];
        
        [sender setTitle:@"Hide Picker" forState:UIControlStateNormal];
        
    } else {
        
        [UIView animateWithDuration:0.3 animations:^{
            [pickerView setCenter:CGPointMake(self.view.center.x, self.view.frame.size.height + pickerView.frame.size.height)];
        } completion:^(BOOL finished) {
            [pickerView removeFromSuperview];
            pickerView = nil;
        }];
        
        [sender setTitle:@"Show Picker" forState:UIControlStateNormal];
    }
}

-(IBAction)goToToday {
    
    [pickerView selectDate:[NSDate date] animated:TRUE];
}

#pragma mark - Irrelevant code for managing general interface

-(void)deviceOrientationDidChange:(NSNotification *)notification {
    
    //Resize the picker view so it looks correct when the screen rotates
    [self resetPickerFrame];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

@end
