//
//  HYDataPointHeaderView.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYDataPointHeaderView.h"
#import "HYConstants.h"

@interface HYDataPointHeaderView ()

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation HYDataPointHeaderView

#pragma mark - Alloc/Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.backgroundColor = [UIColor clearColor];
        _leftLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _leftLabel.textColor = kQAColorDetailHeaderTextColor;
        [self addSubview:_leftLabel];
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _rightLabel.textColor = kQAColorDetailHeaderTextColor;
        [self addSubview:_rightLabel];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.leftLabel.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, ceil(self.bounds.size.width * 0.5), self.bounds.size.height);
    self.rightLabel.frame = CGRectMake(ceil(self.bounds.size.width * 0.5), self.bounds.origin.y, ceil(self.bounds.size.width * 0.5), self.bounds.size.height);
}

@end
