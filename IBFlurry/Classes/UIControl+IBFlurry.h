//
//  UIControl+IBFlurry.h
//  Pods
//
//  Created by Yeung Yiu Hung on 18/4/2016.
//
//

#import <UIKit/UIKit.h>

@interface UIControl (IBFlurry)

@property IBInspectable BOOL enableLog;

@property (nonatomic, strong) IBInspectable NSString *eventKey;

@property (nonatomic, strong) NSDictionary *flurryEventsDict;

@end
