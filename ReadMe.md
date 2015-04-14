# Summary

NEXDatePicker is an Objective-C library designed as a highly customizable `UIDatePicker` (though it inherits from `UIPickerView`) for iOS. As the normal date picker doesn't allow you to select specific date formats (most annoyingly, excluding the weekday from `UIDatePickerModeDate`), we decided to build a highly versatile picker that lets you *choose* a date format to display.

For example, you can pass in `EEE, MMMM d, yyyy` as a format, NEXDatePicker will display dates like this: `Sun, January 5, 2015`.

# Usage

#### Setup

`-(id)initWithDateFormat:(NSString *)dateFormat pickerDelegate:(id<NEXDatePickerDelegate>)del`

Initializes an instance of `NEXDatePicker` and sets the date format for displaying dates, as well as the `pickerDelegate` for date selection callbacks.

***
#### Changing data

`-(void)selectDate:(NSDate *)date animated:(BOOL)animated`

This function should be used for selecting a given date on the date picker.

***
#### Delegation

`-(void)nexDatePicker:(NEXDatePicker *)picker selectedDate:(NSDate *)date string:(NSString *)stringValue`

Called when the date picker's selected date changes. This is also called after calling `selectDate:animated:`. This returns the currently selected date, as well as the string value of the date (formatted with the previously set format).

***
#### Customization

`NEXDatePicker` supports any date format for displaying dates. The format you'd like to use should be specified when initializing the date picker.

***

![Screenshot](https://github.com/nexmachine/NEXDatePicker/blob/master/Screenshot.png "Screenshot")

***
####Feedback

Feel free to send pull requests or to email us at [feedback@nexmachine.com](mailto:feedback@nexmachine.com).