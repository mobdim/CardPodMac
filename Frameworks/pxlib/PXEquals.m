#import "PXEquals.h"

BOOL PXIsEqualString(NSString *firstString, NSString *secondString) {

    if (secondString == nil) {
        if (firstString != nil) {
            return NO;
        } else {
            return YES;
        }
    }

    if ((firstString != secondString) && ![firstString isEqualToString:secondString]) {
        return NO;
    }

    return YES;
}

BOOL PXIsEqualNumber(NSNumber *firstNumber, NSNumber *secondNumber) {
    if (secondNumber == nil) {
        if (firstNumber != nil) {
            return NO;
        } else {
            return YES;
        }
    }

    if ((firstNumber != secondNumber) && ![firstNumber isEqualToNumber:secondNumber]) {
        return NO;
    }

    return YES;
}

BOOL PXIsEqualDate(NSDate *firstDate, NSDate *secondDate) {
    if (secondDate == nil) {
        if (firstDate != nil) {
            return NO;
        } else {
            return YES;
        }
    }

    if ((firstDate != secondDate) && ![firstDate isEqualToDate:secondDate]) {
        return NO;
    }

    return YES;
}