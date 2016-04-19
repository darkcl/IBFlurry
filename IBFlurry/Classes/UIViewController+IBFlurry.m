//
//  UIViewController+IBFlurry.m
//  Pods
//
//  Created by Yeung Yiu Hung on 18/4/2016.
//
//

#import "UIViewController+IBFlurry.h"

#import "UITableView+IBFlurry.h"
#import "UITableViewCell+IBFlurry.h"
#import <objc/runtime.h>
#import <Flurry.h>

static void * IBFlurryUIViewControllerEnableTimedLogPropertKey = &IBFlurryUIViewControllerEnableTimedLogPropertKey;
static void * IBFlurryUIViewControllerEventKeyPropertKey = &IBFlurryUIViewControllerEventKeyPropertKey;
static void * IBFlurryUITableViewFlurryParams = &IBFlurryUITableViewFlurryParams;

@implementation UIViewController (IBFlurry)

+ (void)swizzleMethod:(SEL)originalSelector
             toMethod:(SEL)swizzledSelector{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(tableView:didSelectRowAtIndexPath:)
                   toMethod:@selector(ibflurry_tableView:didSelectRowAtIndexPath:)];
        [self swizzleMethod:@selector(tableView:cellForRowAtIndexPath:)
                   toMethod:@selector(ibflurry_tableView:cellForRowAtIndexPath:)];
    });
}

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

- (void)setTableViewFlurryParams:(NSDictionary *)tableViewFlurryParams{
    objc_setAssociatedObject(self, IBFlurryUITableViewFlurryParams, tableViewFlurryParams , OBJC_ASSOCIATION_RETAIN);
}

- (NSDictionary *)tableViewFlurryParams{
    return objc_getAssociatedObject(self, IBFlurryUITableViewFlurryParams);
}

#pragma mark - Proxies

- (void)ibflurry_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableViewFlurryParams != nil) {
        NSString *key = [NSString stringWithFormat:@"%li,%li", (long)indexPath.section, (long)indexPath.row];
        NSDictionary *flurryInfo = self.tableViewFlurryParams[key];
        if (flurryInfo != nil) {
            NSDictionary *flurryParam = flurryInfo[@"Param"];
            NSString *flurryKey = flurryInfo[@"Key"];
            
            if (![flurryKey isKindOfClass:[NSNull class]]) {
                if (![flurryParam isKindOfClass:[NSNull class]]) {
                    [Flurry logEvent:flurryKey
                      withParameters:flurryParam];
                }else{
                    [Flurry logEvent:flurryKey];
                }
            }
        }
    }
    [self ibflurry_tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (UITableViewCell *)ibflurry_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self ibflurry_tableView:tableView cellForRowAtIndexPath:indexPath];
    NSMutableDictionary *aDict = [NSMutableDictionary dictionaryWithDictionary:self.tableViewFlurryParams ? self.tableViewFlurryParams : [NSDictionary dictionary]];
    if (cell.flurryEventKey == nil) {
        cell.flurryEventKey = tableView.flurryEventKey;
    }
    
    if (cell.flurryEventKey != nil) {
        [aDict setValue:@{@"Param": cell.flurryParam ? cell.flurryParam : [NSNull null],
                          @"Key": cell.flurryEventKey ? cell.flurryEventKey : [NSNull null]}
                 forKey:[NSString stringWithFormat:@"%li,%li", (long)indexPath.section, (long)indexPath.row]];
    }
    
    self.tableViewFlurryParams = [NSDictionary dictionaryWithDictionary:aDict];
    
    
    return cell;
}


@end
