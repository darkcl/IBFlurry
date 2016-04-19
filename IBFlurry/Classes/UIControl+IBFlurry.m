//
//  UIControl+IBFlurry.m
//  Pods
//
//  Created by Yeung Yiu Hung on 18/4/2016.
//
//

#import "UIControl+IBFlurry.h"
#import <objc/runtime.h>

#import <Flurry.h>

static void * IBFlurryUIControlEnableLogPropertKey = &IBFlurryUIControlEnableLogPropertKey;
static void * IBFlurryUIControlEventKeyPropertKey = &IBFlurryUIControlEventKeyPropertKey;
static void * IBFlurryUIControlFlurryKeyDict = &IBFlurryUIControlFlurryKeyDict;
static void * IBFlurryUIControlActionsDict = &IBFlurryUIControlActionsDict;
static void * IBFlurryUIControlFlurryParam = &IBFlurryUIControlFlurryParam;

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
        [self swizzleMethod:@selector(sendActionsForControlEvents:)
                   toMethod:@selector(ibflurry_sendActionsForControlEvents:)];
    });
}

- (void)setFlurryParam:(NSDictionary *)flurryParam{
    objc_setAssociatedObject(self, IBFlurryUIControlFlurryParam, flurryParam , OBJC_ASSOCIATION_RETAIN);
}

- (NSDictionary *)flurryParam{
    return objc_getAssociatedObject(self, IBFlurryUIControlFlurryParam);
}

- (void)setActionsDict:(NSDictionary *)actionsDict{
    objc_setAssociatedObject(self, IBFlurryUIControlActionsDict, actionsDict , OBJC_ASSOCIATION_RETAIN);
}

- (NSDictionary *)actionsDict{
    return objc_getAssociatedObject(self, IBFlurryUIControlActionsDict);
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

- (void)setTouchDownKey:(NSString *)touchDownKey{
    NSMutableDictionary *aDict = [[NSMutableDictionary alloc] initWithDictionary:self.flurryEventsDict ? self.flurryEventsDict : [NSDictionary dictionary]];
    [aDict setValue:touchDownKey forKey:@"touchDownKey"];
    self.flurryEventsDict = [NSDictionary dictionaryWithDictionary:aDict];
}

- (NSString *)touchDownKey{
    return self.flurryEventsDict[@"touchDownKey"];
}

- (void)setTouchDownRepeatKey:(NSString *)touchDownRepeatKey{
    NSMutableDictionary *aDict = [[NSMutableDictionary alloc] initWithDictionary:self.flurryEventsDict ? self.flurryEventsDict : [NSDictionary dictionary]];
    [aDict setValue:touchDownRepeatKey forKey:@"touchDownRepeatKey"];
    self.flurryEventsDict = [NSDictionary dictionaryWithDictionary:aDict];
}

- (NSString *)touchDownRepeatKey{
    return self.flurryEventsDict[@"touchDownRepeatKey"];
}

- (void)setTouchDragInsideKey:(NSString *)touchDragInsideKey{
    NSMutableDictionary *aDict = [[NSMutableDictionary alloc] initWithDictionary:self.flurryEventsDict ? self.flurryEventsDict : [NSDictionary dictionary]];
    [aDict setValue:touchDragInsideKey forKey:@"touchDragInsideKey"];
    self.flurryEventsDict = [NSDictionary dictionaryWithDictionary:aDict];
}

- (NSString *)touchDragInsideKey{
    return self.flurryEventsDict[@"touchDragInsideKey"];
}

- (void)setTouchDragOutsideKey:(NSString *)touchDragOutsideKey{
    NSMutableDictionary *aDict = [[NSMutableDictionary alloc] initWithDictionary:self.flurryEventsDict ? self.flurryEventsDict : [NSDictionary dictionary]];
    [aDict setValue:touchDragOutsideKey forKey:@"touchDragOutsideKey"];
    self.flurryEventsDict = [NSDictionary dictionaryWithDictionary:aDict];
}

- (NSString *)touchDragOutsideKey{
    return self.flurryEventsDict[@"touchDragOutsideKey"];
}

- (void)setTouchDragEnterKey:(NSString *)touchDragEnterKey{
    NSMutableDictionary *aDict = [[NSMutableDictionary alloc] initWithDictionary:self.flurryEventsDict ? self.flurryEventsDict : [NSDictionary dictionary]];
    [aDict setValue:touchDragEnterKey forKey:@"touchDragEnterKey"];
    self.flurryEventsDict = [NSDictionary dictionaryWithDictionary:aDict];
}

- (NSString *)touchDragEnterKey{
    return self.flurryEventsDict[@"touchDragEnterKey"];
}

- (void)setTouchDragExitKey:(NSString *)touchDragExitKey{
    NSMutableDictionary *aDict = [[NSMutableDictionary alloc] initWithDictionary:self.flurryEventsDict ? self.flurryEventsDict : [NSDictionary dictionary]];
    [aDict setValue:touchDragExitKey forKey:@"touchDragExitKey"];
    self.flurryEventsDict = [NSDictionary dictionaryWithDictionary:aDict];
}

- (NSString *)touchDragExitKey{
    return self.flurryEventsDict[@"touchDragExitKey"];
}

- (void)setTouchUpInsideKey:(NSString *)touchUpInsideKey{
    NSMutableDictionary *aDict = [[NSMutableDictionary alloc] initWithDictionary:self.flurryEventsDict ? self.flurryEventsDict : [NSDictionary dictionary]];
    [aDict setValue:touchUpInsideKey forKey:@"touchUpInsideKey"];
    self.flurryEventsDict = [NSDictionary dictionaryWithDictionary:aDict];
}

- (NSString *)touchUpInsideKey{
    return self.flurryEventsDict[@"touchUpInsideKey"];
}

- (void)setTouchUpOutsideKey:(NSString *)touchUpOutsideKey{
    NSMutableDictionary *aDict = [[NSMutableDictionary alloc] initWithDictionary:self.flurryEventsDict ? self.flurryEventsDict : [NSDictionary dictionary]];
    [aDict setValue:touchUpOutsideKey forKey:@"touchUpOutsideKey"];
    self.flurryEventsDict = [NSDictionary dictionaryWithDictionary:aDict];
}

- (NSString *)touchUpOutsideKey{
    return self.flurryEventsDict[@"touchUpOutsideKey"];
}

- (void)setTouchCancelKey:(NSString *)touchCancelKey{
    NSMutableDictionary *aDict = [[NSMutableDictionary alloc] initWithDictionary:self.flurryEventsDict ? self.flurryEventsDict : [NSDictionary dictionary]];
    [aDict setValue:touchCancelKey forKey:@"touchCancelKey"];
    self.flurryEventsDict = [NSDictionary dictionaryWithDictionary:aDict];
}

- (NSString *)touchCancelKey{
    return self.flurryEventsDict[@"touchCancelKey"];
}

- (void)setValueChangeKey:(NSString *)valueChangeKey{
    NSMutableDictionary *aDict = [[NSMutableDictionary alloc] initWithDictionary:self.flurryEventsDict ? self.flurryEventsDict : [NSDictionary dictionary]];
    [aDict setValue:valueChangeKey forKey:@"valueChangeKey"];
    self.flurryEventsDict = [NSDictionary dictionaryWithDictionary:aDict];
}

- (NSString *)valueChangeKey{
    return self.flurryEventsDict[@"valueChangeKey"];
}

- (void)setEditingEndKey:(NSString *)editingEndKey{
    NSMutableDictionary *aDict = [[NSMutableDictionary alloc] initWithDictionary:self.flurryEventsDict ? self.flurryEventsDict : [NSDictionary dictionary]];
    [aDict setValue:editingEndKey forKey:@"editingEndKey"];
    self.flurryEventsDict = [NSDictionary dictionaryWithDictionary:aDict];
}

- (NSString *)editingEndKey{
    return self.flurryEventsDict[@"editingEndKey"];
}

- (void)setEditingBeginKey:(NSString *)editingBeginKey{
    NSMutableDictionary *aDict = [[NSMutableDictionary alloc] initWithDictionary:self.flurryEventsDict ? self.flurryEventsDict : [NSDictionary dictionary]];
    [aDict setValue:editingBeginKey forKey:@"editingBeginKey"];
    self.flurryEventsDict = [NSDictionary dictionaryWithDictionary:aDict];
}

- (NSString *)editingBeginKey{
    return self.flurryEventsDict[@"editingBeginKey"];
}

- (void)setEditingChangedKey:(NSString *)editingChangedKey{
    NSMutableDictionary *aDict = [[NSMutableDictionary alloc] initWithDictionary:self.flurryEventsDict ? self.flurryEventsDict : [NSDictionary dictionary]];
    [aDict setValue:editingChangedKey forKey:@"editingChangedKey"];
    self.flurryEventsDict = [NSDictionary dictionaryWithDictionary:aDict];
}

- (NSString *)editingChangedKey{
    return self.flurryEventsDict[@"editingChangedKey"];
}

#pragma mark - Helpers

- (NSArray <NSString *> *)keysFromControlEvents:(UIControlEvents)controlEvents{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    if (controlEvents & UIControlEventTouchDown) {
        [result addObject:@"touchDownKey"];
    }
    
    if (controlEvents & UIControlEventTouchDownRepeat) {
        [result addObject:@"touchDownRepeatKey"];
    }
    
    if (controlEvents & UIControlEventTouchDragInside) {
        [result addObject:@"touchDragInsideKey"];
    }
    
    if (controlEvents & UIControlEventTouchDragOutside) {
        [result addObject:@"touchDragOutsideKey"];
    }
    
    if (controlEvents & UIControlEventTouchDragEnter) {
        [result addObject:@"touchDragEnterKey"];
    }
    
    if (controlEvents & UIControlEventTouchDragExit) {
        [result addObject:@"touchDragExitKey"];
    }
    
    if (controlEvents & UIControlEventTouchUpInside) {
        [result addObject:@"touchUpInsideKey"];
    }
    
    if (controlEvents & UIControlEventTouchUpOutside) {
        [result addObject:@"touchUpOutsideKey"];
    }
    
    if (controlEvents & UIControlEventTouchCancel) {
        [result addObject:@"touchCancelKey"];
    }
    
    if (controlEvents & UIControlEventValueChanged) {
        [result addObject:@"valueChangeKey"];
    }
    
    if (controlEvents & UIControlEventEditingDidBegin) {
        [result addObject:@"editingBeginKey"];
    }
    
    if (controlEvents & UIControlEventEditingChanged) {
        [result addObject:@"editingChangedKey"];
    }
    
    if (controlEvents & UIControlEventEditingDidEnd) {
        [result addObject:@"editingEndKey"];
    }
    
    return result;
}

#pragma mark - Proxies

- (void)ibflurry_sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event{
    NSLog(@"Custom sendAction");
    [self ibflurry_sendAction:action to:target forEvent:event];
    
    if (self.enableLog) {
        NSLog(@"Enable Flurry log");
        
        for (NSString *key in self.actionsDict.allKeys) {
            NSDictionary *actionForEvent = self.actionsDict[key];
            if ([actionForEvent[@"TargetClass"] isEqualToString:NSStringFromClass([target class])] &&
                [actionForEvent[@"Action"] isEqualToString:NSStringFromSelector(action)] &&
                self.flurryEventsDict[key] != nil) {
                NSLog(@"Flurry log: %@", self.flurryEventsDict[key]);
                
                if (self.flurryParam != nil) {
                    [Flurry logEvent:self.flurryEventsDict[key] withParameters:self.flurryParam];
                }else{
                    [Flurry logEvent:self.flurryEventsDict[key]];
                }
                
            }
        }
        
    }
}

- (void)ibflurry_addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    NSLog(@"Custom addTarget");
    
    if (self.enableLog) {
        NSMutableDictionary *aDict = [[NSMutableDictionary alloc] initWithDictionary:self.actionsDict ? self.actionsDict :[NSDictionary dictionary]];
        
        NSArray *keys = [self keysFromControlEvents:controlEvents];
        
        for (NSString *key in keys) {
            NSDictionary *actionForEvent = @{@"TargetClass": NSStringFromClass([target class]),
                                             @"Action": NSStringFromSelector(action)};
            [aDict setValue:actionForEvent forKey:key];
        }
        
        self.actionsDict = [NSDictionary dictionaryWithDictionary:aDict];
    }
    
    [self ibflurry_addTarget:target action:action forControlEvents:controlEvents];
}

- (void)ibflurry_sendActionsForControlEvents:(UIControlEvents)controlEvents{
    NSLog(@"Custom sendActionsForControlEvents");
    
    [self ibflurry_sendActionsForControlEvents:controlEvents];
}

@end
