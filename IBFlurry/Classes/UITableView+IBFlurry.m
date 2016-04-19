//
//  UITableView+IBFlurry.m
//  Pods
//
//  Created by Yeung Yiu Hung on 19/4/2016.
//
//

#import "UITableView+IBFlurry.h"

#import <objc/runtime.h>

static void * IBFlurryUITableViewFlurryEventKey = &IBFlurryUITableViewFlurryEventKey;

@implementation UITableView (IBFlurry)

- (void)setFlurryEventKey:(NSString *)flurryEventKey{
    objc_setAssociatedObject(self, IBFlurryUITableViewFlurryEventKey, flurryEventKey, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)flurryEventKey{
    objc_getAssociatedObject(self, IBFlurryUITableViewFlurryEventKey);
}

@end
