//
//  HYChartTooltipView.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYChartTooltipView.h"

// Drawing
#import <QuartzCore/QuartzCore.h>

// Numerics
CGFloat static const kHYChartTooltipViewCornerRadius = 5.0;
CGFloat const kHYChartTooltipViewDefaultWidth = 50.0f;
CGFloat const kHYChartTooltipViewDefaultHeight = 25.0f;

@interface HYChartTooltipView ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation HYChartTooltipView

#pragma mark - Alloc/Init

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, kHYChartTooltipViewDefaultWidth, kHYChartTooltipViewDefaultHeight)];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
        self.layer.cornerRadius = kHYChartTooltipViewCornerRadius;
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = [UIColor colorWithRed:49.0/255.0 green:49.0/255.0 blue:49.0/255.0 alpha:1.0];;
        _textLabel.adjustsFontSizeToFitWidth = YES;
        _textLabel.numberOfLines = 1;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
    }
    return self;
}

#pragma mark - Setters

- (void)setText:(NSString *)text
{
    self.textLabel.text = text;
    [self setNeedsLayout];
}

- (void)setTooltipColor:(UIColor *)tooltipColor
{
    self.backgroundColor = tooltipColor;
    [self setNeedsDisplay];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    _textLabel.frame = self.bounds;
}

@end
