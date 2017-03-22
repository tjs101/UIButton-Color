//
//  UIButton+Color.m
//  QBFramework
//
//  Created by quentin on 2017/3/22.
//  Copyright © 2017年 Quentin. All rights reserved.
//

#import "UIButton+Color.h"
#import <objc/runtime.h>

@implementation UIButton (Color)

static char normalBackgroundColorKey;
static char touchDownBackgroundColorKey;

- (UIColor *)normalBackgroundColor
{
    return objc_getAssociatedObject(self, &normalBackgroundColorKey);
}

- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor
{
    objc_setAssociatedObject(self, &normalBackgroundColorKey, normalBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)touchDownBackgroundColor
{
    return objc_getAssociatedObject(self, &touchDownBackgroundColorKey);
}

- (void)setTouchDownBackgroundColor:(UIColor *)touchDownBackgroundColor
{
    objc_setAssociatedObject(self, &touchDownBackgroundColorKey, touchDownBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sr_setTouchDownBackgroundColor:(UIColor *)touchDownBackgroundColor
{
    [self setTouchDownBackgroundColor:touchDownBackgroundColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self cancelBackgroundColor];
    
    if (self.touchDownBackgroundColor) {
        [self setNormalBackgroundColor:self.backgroundColor];
        self.backgroundColor = self.touchDownBackgroundColor;
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    [self performSelector:@selector(cancelBackgroundColor) withObject:nil afterDelay:0.2f];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [self performSelector:@selector(cancelBackgroundColor) withObject:nil afterDelay:0.2f];
}

- (void)cancelBackgroundColor
{
    [self cancelBackgrounColorPerform];
    self.backgroundColor = self.normalBackgroundColor;
}

- (void)cancelBackgrounColorPerform
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(cancelBackgroundColor) object:nil];
}

@end
