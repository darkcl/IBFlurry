//
//  UITableViewCell+IBFlurry.h
//  Pods
//
//  Created by Yeung Yiu Hung on 19/4/2016.
//
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (IBFlurry)

@property (nonatomic, strong) NSDictionary *flurryParam;

@property (nonatomic, strong) NSString *flurryEventKey;

@end
