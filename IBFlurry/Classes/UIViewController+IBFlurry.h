//
//  UIViewController+IBFlurry.h
//  Pods
//
//  Created by Yeung Yiu Hung on 18/4/2016.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (IBFlurry)

@property IBInspectable BOOL *enableTimedLog;

@property (nonatomic, strong) IBInspectable NSString *eventKey;

@end