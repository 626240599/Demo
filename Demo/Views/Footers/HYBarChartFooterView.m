//
//  HYChartFooterView.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYBarChartFooterView.h"

// Numerics
CGFloat const kHYBarChartFooterPolygonViewDefaultPadding = 4.0f;

// Colors
static UIColor *kHYBarChartFooterViewDefaultBackgroundColor = nil;

@interface HYBarChartFooterView ()

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation HYBarChartFooterView

#pragma mark - Alloc/Init

+ (void)initialize
{
	if (self == [HYBarChartFooterView class])
	{
		kHYBarChartFooterViewDefaultBackgroundColor = [UIColor colorWithRed:49.0/255.0 green:49.0/255.0 blue:49.0/255.0 alpha:1.0];
	}
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = kHYBarChartFooterViewDefaultBackgroundColor;
        
        _padding = kHYBarChartFooterPolygonViewDefaultPadding;
        
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.adjustsFontSizeToFitWidth = YES;
        _leftLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.shadowColor = [UIColor blackColor];
        _leftLabel.shadowOffset = CGSizeMake(0, 1);
        _leftLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_leftLabel];
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.adjustsFontSizeToFitWidth = YES;
        _rightLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.shadowColor = [UIColor blackColor];
        _rightLabel.shadowOffset = CGSizeMake(0, 1);
        _rightLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_rightLabel];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat xOffset = self.padding;
    CGFloat yOffset = 0;
    CGFloat width = ceil(self.bounds.size.width * 0.5) - self.padding;
    
    self.leftLabel.frame = CGRectMake(xOffset, yOffset, width, self.bounds.size.height);
    self.rightLabel.frame = CGRectMake(CGRectGetMaxX(_leftLabel.frame), yOffset, width, self.bounds.size.height);
}

@end
