//
//  UIViewController+IBFlurry.h
//  Pods
//
//  Created by Yeung Yiu Hung on 18/4/2016.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (IBFlurry) <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property IBInspectable BOOL *enableTimedLog;

@property (nonatomic, strong) IBInspectable NSString *eventKey;

@property (nonatomic, strong) NSDictionary *tableViewFlurryParams;

@end
