//
//  NSObject+Swizzle.m
//  UIThreadCheck
//
//  Created by fdd on 2018/1/18.
//  Copyright © 2018年 fdd. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzle)
+ (void)safe_swizzleMethod:(SEL)srcSel tarSel:(SEL)tarSel{
    Class clazz = [self class];
    [self safe_swizzleMethod:clazz srcSel:srcSel tarClass:clazz tarSel:tarSel];
}

+ (void)safe_swizzleMethod:(SEL)srcSel tarClass:(NSString *)tarClassName tarSel:(SEL)tarSel{
    if (!tarClassName) {
        return;
    }
    Class srcClass = [self class];
    Class tarClass = NSClassFromString(tarClassName);
    [self safe_swizzleMethod:srcClass srcSel:srcSel tarClass:tarClass tarSel:tarSel];
}

+ (void)safe_swizzleMethod:(Class)srcClass srcSel:(SEL)srcSel tarClass:(Class)tarClass tarSel:(SEL)tarSel{
    if (!srcClass) {
        return;
    }
    if (!srcSel) {
        return;
    }
    if (!tarClass) {
        return;
    }
    if (!tarSel) {
        return;
    }
    Method srcMethod = class_getInstanceMethod(srcClass,srcSel);
    Method tarMethod = class_getInstanceMethod(tarClass,tarSel);
    method_exchangeImplementations(srcMethod, tarMethod);
}
@end
