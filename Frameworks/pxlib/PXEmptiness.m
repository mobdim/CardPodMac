#import "PXEmptiness.h"

BOOL PXIsEmpty(id obj) {
    return obj == nil || obj == [NSNull null] || ([obj respondsToSelector:@selector(length)] && [(NSData *) obj length] == 0) || ([obj respondsToSelector:@selector(count)] && [obj count] == 0);
}

BOOL PXIsEmptyString(NSString *obj) {
    return obj == nil || (id) obj == (id)[NSNull null] || [obj length] == 0;
}

BOOL PXIsNotEmpty(id obj) {
    return !(PXIsEmpty(obj));
}

BOOL PXIsNotEmptyString(NSString *obj) {
    return !(PXIsEmptyString(obj));
}
