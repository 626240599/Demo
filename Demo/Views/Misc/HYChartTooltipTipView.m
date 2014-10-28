//
//  HYChartTooltipTipView.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYChartTooltipTipView.h"


// Numerics
CGFloat const kHYChartTooltipTipViewDefaultWidth = 8.0f;
CGFloat const kHYChartTooltipTipViewDefaultHeight = 5.0f;

@implementation HYChartTooltipTipView

#pragma mark - Alloc/Init

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, kHYChartTooltipTipViewDefaultWidth, kHYChartTooltipTipViewDefaultHeight)];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor clearColor] set];
    CGContextFillRect(context, rect);
    
    CGContextSaveGState(context);
    {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, CGRectGetMidX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextClosePath(context);
        CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:1.0 alpha:0.9].CGColor);
        CGContextFillPath(context);
    }
    CGContextRestoreGState(context);
}

@end
