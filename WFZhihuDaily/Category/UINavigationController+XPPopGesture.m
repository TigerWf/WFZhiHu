//
//  UINavigationController+XPPopGesture.m
//  Test
//
//  Created by xiupintech on 15/7/24.
//  Copyright (c) 2015年 L. All rights reserved.
//


#import "UINavigationController+XPPopGesture.h"
#import <objc/runtime.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

//add by tiger -
@interface NSString (__XP_String)

- (NSString *)__xpEncryptString;
- (NSString *)__xpDecryptString;

@end

@implementation NSString (__XP_String)

- (NSString *)__mlRot13{
    
    const char *source = [self cStringUsingEncoding:NSASCIIStringEncoding];
    char *dest = (char *)malloc((self.length + 1) * sizeof(char));
    if (!dest) {
        return nil;
    }
    
    NSUInteger i = 0;
    for ( ; i < self.length; i++) {
        char c = source[i];
        if (c >= 'A' && c <= 'Z') {
            c = (c - 'A' + 13) % 26 + 'A';
        }
        else if (c >= 'a' && c <= 'z') {
            c = (c - 'a' + 13) % 26 + 'a';
        }
        dest[i] = c;
    }
    dest[i] = '\0';
    
    NSString *result = [[NSString alloc] initWithCString:dest encoding:NSASCIIStringEncoding];
    free(dest);

    return result;
}

- (NSString *)__xpEncryptString{
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64 = [data base64EncodedStringWithOptions:0];
    return [base64 __mlRot13];
}

- (NSString *)__xpDecryptString{
    
    NSString *rot13 = [self __mlRot13];
    NSData *data = [[NSData alloc] initWithBase64EncodedString:rot13 options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end

@implementation XPPanGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    /**
     *  将触摸事件传给pan手势 目的是解决侧滑与scrollview的手势冲突
     */
    self.event = event;
    [super touchesBegan:touches withEvent:event];
}

@end
// end add


@interface XPPopGestureRecognizerDelegate : NSObject <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UINavigationController *navigationController;

@end

@implementation XPPopGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    
    UIViewController *topViewController = self.navigationController.viewControllers.lastObject;
    if (topViewController.xp_interactivePopDisabled) {
        return NO;
    }
    
    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGFloat maxAllowedInitialDistance = topViewController.xp_interactivePopMaxAllowedInitialDistanceToLeftEdge;
    if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
        return NO;
    }

    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
   
    return YES;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    if (gestureRecognizer != self.navigationController.xp_fullscreenPopGestureRecognizer) return NO;
    
    if (self.navigationController.xp_fullscreenPopGestureRecognizer.state != UIGestureRecognizerStateBegan) return NO;
    
    if (otherGestureRecognizer.state != UIGestureRecognizerStateBegan) {
        return YES;
    }

    //add by tiger - 如果是scrollview 判断scrollview contentOffset 是否为0，是 cancel scrollview 的手势，否cancel自己
    if ([[otherGestureRecognizer view] isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)[otherGestureRecognizer view];
        
        if (scrollView.contentOffset.x <= 0) {
            [self cancelOtherGestureRecognizer:otherGestureRecognizer];
            return YES;
        }
    }
    //end add
 
    return NO;

}


//add by tiger - 取消othergesture手势
- (void)cancelOtherGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    NSSet *touchs = [self.navigationController.xp_fullscreenPopGestureRecognizer.event touchesForGestureRecognizer:otherGestureRecognizer];
    
    [otherGestureRecognizer touchesCancelled:touchs withEvent:self.navigationController.xp_fullscreenPopGestureRecognizer.event];
}
//end add
@end

typedef void (^XPViewControllerWillAppearInjectBlock)(UIViewController *viewController, BOOL animated);

@interface UIViewController (XPPopGesturePrivate)

@property (nonatomic, copy) XPViewControllerWillAppearInjectBlock xp_willAppearInjectBlock;

@end

@implementation UIViewController (XPPopGesturePrivate)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(xp_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)xp_viewWillAppear:(BOOL)animated{
    
    [self xp_viewWillAppear:animated];
    
    if (self.xp_willAppearInjectBlock) {
        self.xp_willAppearInjectBlock(self, animated);
    }
}

- (XPViewControllerWillAppearInjectBlock)xp_willAppearInjectBlock{
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setXp_willAppearInjectBlock:(XPViewControllerWillAppearInjectBlock)block{
    
    objc_setAssociatedObject(self, @selector(xp_willAppearInjectBlock), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

@implementation UINavigationController (XPPopGesture)

+ (void)load{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
//add by tiger -
#define kHandleNavigationPopKey [@"nTShMTkyGzS2nJquqTyioyElLJ5mnKEco246" __xpDecryptString]
//end add
        
        SEL originalSelector = @selector(pushViewController:animated:);
        SEL swizzledSelector = @selector(xp_pushViewController:animated:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)xp_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.xp_fullscreenPopGestureRecognizer]) {
        

        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.xp_fullscreenPopGestureRecognizer];

        NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(kHandleNavigationPopKey);
        self.xp_fullscreenPopGestureRecognizer.delegate = self.xp_popGestureRecognizerDelegate;
        [self.xp_fullscreenPopGestureRecognizer addTarget:internalTarget action:internalAction];

        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
  
    [self xp_setupViewControllerBasedNavigationBarAppearanceIfNeeded:viewController];
    

    if (![self.viewControllers containsObject:viewController]) {
        [self xp_pushViewController:viewController animated:animated];
    }
}

- (void)xp_setupViewControllerBasedNavigationBarAppearanceIfNeeded:(UIViewController *)appearingViewController{
    if (!self.xp_viewControllerBasedNavigationBarAppearanceEnabled) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    XPViewControllerWillAppearInjectBlock block = ^(UIViewController *viewController, BOOL animated) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf setNavigationBarHidden:viewController.xp_prefersNavigationBarHidden animated:animated];
        }
    };
    

    appearingViewController.xp_willAppearInjectBlock = block;
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    if (disappearingViewController && !disappearingViewController.xp_willAppearInjectBlock) {
        disappearingViewController.xp_willAppearInjectBlock = block;
    }
}

- (XPPopGestureRecognizerDelegate *)xp_popGestureRecognizerDelegate{
    
    XPPopGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);

    if (!delegate) {
        delegate = [[XPPopGestureRecognizerDelegate alloc] init];
        delegate.navigationController = self;
        
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}

- (XPPanGestureRecognizer *)xp_fullscreenPopGestureRecognizer{
    
    XPPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);

    if (!panGestureRecognizer) {
        panGestureRecognizer = [[XPPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}

- (BOOL)xp_viewControllerBasedNavigationBarAppearanceEnabled{
    
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) {
        return number.boolValue;
    }
    self.xp_viewControllerBasedNavigationBarAppearanceEnabled = YES;
    return YES;
}

- (void)setXp_viewControllerBasedNavigationBarAppearanceEnabled:(BOOL)enabled{
    
    SEL key = @selector(xp_viewControllerBasedNavigationBarAppearanceEnabled);
    objc_setAssociatedObject(self, key, @(enabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

@implementation UIViewController (XPPopGesture)

- (NSString *)classMark{
    
    NSString *mark = objc_getAssociatedObject(self, _cmd);
    mark = NSStringFromClass([self class]);
    if ([self isKindOfClass:[UINavigationController class]]) {
        mark = NSStringFromClass([[(UINavigationController *)self topViewController] class]);
    }
    return mark;
}

- (void)setClassMark:(NSString *)classMark{

    SEL key = @selector(classMark);
    objc_setAssociatedObject(self, key, classMark, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

- (BOOL)xp_interactivePopDisabled{
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setXp_interactivePopDisabled:(BOOL)disabled{
    
    objc_setAssociatedObject(self, @selector(xp_interactivePopDisabled), @(disabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)xp_prefersNavigationBarHidden{
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setXp_prefersNavigationBarHidden:(BOOL)hidden{
    
    objc_setAssociatedObject(self, @selector(xp_prefersNavigationBarHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGFloat)xp_interactivePopMaxAllowedInitialDistanceToLeftEdge{
    
#if CGFLOAT_IS_DOUBLE
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
#else
    return [objc_getAssociatedObject(self, _cmd) floatValue];
#endif
}

- (void)setXp_interactivePopMaxAllowedInitialDistanceToLeftEdge:(CGFloat)distance{
    
    SEL key = @selector(xp_interactivePopMaxAllowedInitialDistanceToLeftEdge);
    objc_setAssociatedObject(self, key, @(MAX(0, distance)), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//add by tiger
- (BOOL)showFlag{
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
    
}

- (void)setShowFlag:(BOOL)show{
    
   objc_setAssociatedObject(self, @selector(showFlag), @(show), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
