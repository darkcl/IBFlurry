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

@property (nonatomic, strong) IBInspectable NSString *touchDownKey;

@property (nonatomic, strong) IBInspectable NSString *touchDownRepeatKey;

@property (nonatomic, strong) IBInspectable NSString *touchDragInsideKey;

@property (nonatomic, strong) IBInspectable NSString *touchDragOutsideKey;

@property (nonatomic, strong) IBInspectable NSString *touchDragEnterKey;

@property (nonatomic, strong) IBInspectable NSString *touchDragExitKey;

@property (nonatomic, strong) IBInspectable NSString *touchUpInsideKey;

@property (nonatomic, strong) IBInspectable NSString *touchUpOutsideKey;

@property (nonatomic, strong) IBInspectable NSString *touchCancelKey;

@property (nonatomic, strong) IBInspectable NSString *valueChangeKey;

@property (nonatomic, strong) IBInspectable NSString *editingBeginKey;

@property (nonatomic, strong) IBInspectable NSString *editingChangedKey;

@property (nonatomic, strong) IBInspectable NSString *editingEndKey;

@property (nonatomic, strong) NSDictionary *flurryEventsDict;

@property (nonatomic, strong) NSDictionary *actionsDict;

@end
