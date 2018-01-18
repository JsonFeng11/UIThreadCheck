//
//  UIView+ThreadCheck.m
//  UIThreadCheck
//
//  Created by fdd on 2018/1/18.
//  Copyright © 2018年 fdd. All rights reserved.
//

#import "UIView+ThreadCheck.h"
#import "NSObject+Swizzle.h"


@implementation UIView (ThreadCheck)
- (void)safe_setNeedsLayout {
    if (![NSThread isMainThread]) {//非主线程
#ifdef DEBUG //debug模式下找出堆栈
        NSCAssert(NO, @"uview操作需要在主线程");
#endif
    }
}
- (void)safe_setNeedsDisplay {
    if (![NSThread isMainThread]) {//非主线程
#ifdef DEBUG //debug模式下找出堆栈
        NSCAssert(NO, @"uview操作需要在主线程");
#endif
    }
}
- (void)safe_setNeedsDisplayInRect:(CGRect)rect {
    if (![NSThread isMainThread]) {//非主线程
#ifdef DEBUG //debug模式下找出堆栈
        NSCAssert(NO, @"uview操作需要在主线程");
#endif
    }
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] safe_swizzleMethod:@selector(safe_setNeedsLayout) tarClass:NSStringFromClass([UIView class]) tarSel:@selector(setNeedsLayout)];
        [[self class] safe_swizzleMethod:@selector(safe_setNeedsDisplay) tarClass:NSStringFromClass([UIView class]) tarSel:@selector(setNeedsDisplay)];
        [[self class] safe_swizzleMethod:@selector(safe_setNeedsDisplayInRect:) tarClass:NSStringFromClass([UIView class]) tarSel:@selector(setNeedsDisplayInRect:)];
    });
}
@end
