//
//  HYChartFooterView.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYChartFooterView.h"
#import "HYConstants.h"

// Numerics
CGFloat const kHYChartFooterViewSeparatorWidth = 0.5f;
CGFloat const kSFChartFooterViewSeparatorHeight = 3.0f;
CGFloat const kSFChartFooterViewSeparatorSectionPadding = 1.0f;

@interface HYChartFooterView ()

@property (nonatomic, strong) UIView *topSeparatorView;

// Getters
- (UILabel *)footerLabel;

@end

@implementation HYChartFooterView

#pragma mark - Alloc/Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _topSeparatorView = [[UIView alloc] init];
        _topSeparatorView.backgroundColor = kHYColorChartFooterSeparatorColor;
        [self addSubview:_topSeparatorView];
        
        _leftLabel = [self footerLabel];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.textColor = kHYColorChartFooterSideTextColor;
        [self addSubview:_leftLabel];

        _centerLabel = [self footerLabel];
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        _centerLabel.textColor = kHYColorChartFooterCenterTextColor;
        [self addSubview:_centerLabel];

        _rightLabel = [self footerLabel];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.textColor = kHYColorChartFooterSideTextColor;
        [self addSubview:_rightLabel];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, kHYColorChartFooterSeparatorColor.CGColor);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetShouldAntialias(context, YES);
    
    CGFloat xOffset = 0;
    CGFloat yOffset = kHYChartFooterViewSeparatorWidth;
    CGFloat stepLength = ceil((self.bounds.size.width) / (self.sectionCount - 1));
    
    for (int i=0; i<self.sectionCount; i++)
    {
        CGContextSaveGState(context);
        {
            CGContextMoveToPoint(context, xOffset + (kHYChartFooterViewSeparatorWidth * 0.5), yOffset);
            CGContextAddLineToPoint(context, xOffset + (kHYChartFooterViewSeparatorWidth * 0.5), yOffset + kSFChartFooterViewSeparatorHeight);
            CGContextStrokePath(context);
            xOffset += stepLength;
        }
        CGContextRestoreGState(context);
    }
    
    if (self.sectionCount > 1)
    {
        CGContextSaveGState(context);
        {
            CGContextMoveToPoint(context, self.bounds.size.width - (kHYChartFooterViewSeparatorWidth * 0.5), yOffset);
            CGContextAddLineToPoint(context, self.bounds.size.width - (kHYChartFooterViewSeparatorWidth * 0.5), yOffset + kSFChartFooterViewSeparatorHeight);
            CGContextStrokePath(context);
        }
        CGContextRestoreGState(context);
    }
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _topSeparatorView.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, kHYChartFooterViewSeparatorWidth);
    
    CGFloat xOffset = 0;
    CGFloat yOffset = kSFChartFooterViewSeparatorSectionPadding;
    CGFloat width = self.bounds.size.width;
    
    self.leftLabel.frame = CGRectMake(xOffset, yOffset, width, self.bounds.size.height);
    self.centerLabel.frame = CGRectMake(xOffset, yOffset, width, self.bounds.size.height);
    self.rightLabel.frame = CGRectMake(xOffset, yOffset, width, self.bounds.size.height);
}

#pragma mark - Setters

- (void)setSectionCount:(NSInteger)sectionCount
{
    _sectionCount = sectionCount;
    [self setNeedsDisplay];
}

#pragma mark - Getters

- (UILabel *)footerLabel
{
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.adjustsFontSizeToFitWidth = YES;
    footerLabel.font = kHYFontFooterViewLabel;
    footerLabel.backgroundColor = [UIColor clearColor];
    footerLabel.shadowColor = [UIColor whiteColor];
    footerLabel.shadowOffset = CGSizeMake(0, 1);
    return footerLabel;
}

@end
