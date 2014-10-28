//
//  HYChartHeaderView.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYChartHeaderView.h"
#import "HYConstants.h"

@interface HYChartHeaderView ()

@property (nonatomic, strong) UIView *underlineView;

@end

@implementation HYChartHeaderView

#pragma mark - Alloc/Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = kHYFontHeaderViewTitle;
        _titleLabel.textColor = kHYColorChartHeaderTextColor;
        [self addSubview:_titleLabel];
        
        _underlineView = [[UIView alloc] init];
        _underlineView.backgroundColor = kHYColorChartHeaderUnderlineColor;
        [self addSubview:_underlineView];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize titleLabelSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    self.titleLabel.frame = CGRectMake(ceil(self.bounds.size.width * 0.5) - ceil(titleLabelSize.width * 0.5), self.bounds.origin.y, titleLabelSize.width, titleLabelSize.height);
    self.underlineView.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame), titleLabelSize.width, 0.5f);
}

@end
