//
//  UITableViewCell+IBFlurry.m
//  Pods
//
//  Created by Yeung Yiu Hung on 19/4/2016.
//
//

#import "UITableViewCell+IBFlurry.h"

#import <objc/runtime.h>

static void * IBFlurryUITableViewCellFlurryParam = &IBFlurryUITableViewCellFlurryParam;
static void * IBFlurryUITableViewCellFlurryEventKey = &IBFlurryUITableViewCellFlurryEventKey;

@implementation UITableViewCell (IBFlurry)

- (void)setFlurryParam:(NSDictionary *)flurryParam{
    objc_setAssociatedObject(self, IBFlurryUITableViewCellFlurryParam, flurryParam, OBJC_ASSOCIATION_RETAIN);
}

- (NSDictionary *)flurryParam{
    objc_getAssociatedObject(self, IBFlurryUITableViewCellFlurryParam);
}

- (void)setFlurryEventKey:(NSString *)flurryEventKey{
    objc_setAssociatedObject(self, IBFlurryUITableViewCellFlurryEventKey, flurryEventKey, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)flurryEventKey{
    objc_getAssociatedObject(self, IBFlurryUITableViewCellFlurryEventKey);
}

@end
