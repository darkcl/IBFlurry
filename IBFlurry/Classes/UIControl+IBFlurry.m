//
//  UIControl+IBFlurry.m
//  Pods
//
//  Created by Yeung Yiu Hung on 18/4/2016.
//
//

#import "UIControl+IBFlurry.h"
#import <objc/runtime.h>

static void * IBFlurryUIControlEnableLogPropertKey = &IBFlurryUIControlEnableLogPropertKey;
static void * IBFlurryUIControlEventKeyPropertKey = &IBFlurryUIControlEventKeyPropertKey;
static void * IBFlurryUIControlFlurryKeyDict = &IBFlurryUIControlFlurryKeyDict;

@implementation UIControl (IBFlurry)

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
        [self swizzleMethod:@selector(sendAction:to:forEvent:)
                   toMethod:@selector(ibflurry_sendAction:to:forEvent:)];
        [self swizzleMethod:@selector(addTarget:action:forControlEvents:)
                   toMethod:@selector(ibflurry_addTarget:action:forControlEvents:)];
    });
}

- (void)setEnableLog:(BOOL) property{
    NSNumber *number = [NSNumber numberWithBool: property];
    objc_setAssociatedObject(self, IBFlurryUIControlEnableLogPropertKey, number , OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)enableLog{
    NSNumber *number = objc_getAssociatedObject(self, IBFlurryUIControlEnableLogPropertKey);
    return [number boolValue];
}

- (void)setFlurryEventsDict:(NSDictionary *)flurryEventsDict{
    objc_setAssociatedObject(self, IBFlurryUIControlFlurryKeyDict, flurryEventsDict , OBJC_ASSOCIATION_RETAIN);
}

- (NSDictionary *)flurryEventsDict{
    return objc_getAssociatedObject(self, IBFlurryUIControlFlurryKeyDict);
}

- (void)setEventKey:(NSString *)eventKey{
    objc_setAssociatedObject(self, IBFlurryUIControlEventKeyPropertKey, eventKey , OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)eventKey{
    return objc_getAssociatedObject(self, IBFlurryUIControlEventKeyPropertKey);
}

- (void)ibflurry_sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event{
    NSLog(@"Custom sendAction");
    
    if (self.enableLog) {
        NSLog(@"Enable Flurry log");
    }
    
    [self ibflurry_sendAction:action to:target forEvent:event];
}

- (void)ibflurry_addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    NSLog(@"Custom addTarget");
    
    if (self.enableLog) {
        
    }
    
    [self ibflurry_addTarget:target action:action forControlEvents:controlEvents];
}

@end
