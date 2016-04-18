//
//  UIViewController+IBFlurry.m
//  Pods
//
//  Created by Yeung Yiu Hung on 18/4/2016.
//
//

#import "UIViewController+IBFlurry.h"

#import <objc/runtime.h>

static void * IBFlurryUIViewControllerEnableTimedLogPropertKey = &IBFlurryUIViewControllerEnableTimedLogPropertKey;
static void * IBFlurryUIViewControllerEventKeyPropertKey = &IBFlurryUIViewControllerEventKeyPropertKey;

@implementation UIViewController (IBFlurry)

- (void)setEnableTimedLog:(BOOL *)enableTimedLog{
    NSNumber *number = [NSNumber numberWithBool: enableTimedLog];
    objc_setAssociatedObject(self, IBFlurryUIViewControllerEnableTimedLogPropertKey, number , OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isEnableTimedLog{
    NSNumber *number = objc_getAssociatedObject(self, IBFlurryUIViewControllerEnableTimedLogPropertKey);
    return [number boolValue];
}

- (void)setEventKey:(NSString *)eventKey{
    objc_setAssociatedObject(self, IBFlurryUIViewControllerEventKeyPropertKey, eventKey , OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)eventKey{
    return objc_getAssociatedObject(self, IBFlurryUIViewControllerEventKeyPropertKey);
}

@end
