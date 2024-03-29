//
//  UIView+SDFrame.m
//  BruceGuo
//
//  Created by bruceGuo on 2018/8/20.
//  Copyright © 2018年 bruceGuo. All rights reserved.
//

#import "UIView+SDFrame.h"

@implementation UIView (SDFrame)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigan:(CGPoint)origan {
    CGRect frame = self.frame;
    frame.origin = origan;
    self.frame = frame;
}

- (CGPoint)origan {
    return self.frame.origin;
}

@end
