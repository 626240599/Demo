//
//  HYChartInformationView.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYChartInformationView.h"

// Numerics
CGFloat const kHYChartValueViewPadding = 10.0f;
CGFloat const kHYChartValueViewSeparatorSize = 0.5f;
CGFloat const kHYChartValueViewTitleHeight = 50.0f;
CGFloat const kHYChartValueViewTitleWidth = 75.0f;
CGFloat const kHYChartValueViewDefaultAnimationDuration = 0.25f;

// Colors (HYChartInformationView)
static UIColor *kHYChartViewSeparatorColor = nil;
static UIColor *kHYChartViewTitleColor = nil;
static UIColor *kHYChartViewShadowColor = nil;

// Colors (HYChartInformationView)
static UIColor *kHYChartInformationViewValueColor = nil;
static UIColor *kHYChartInformationViewUnitColor = nil;
static UIColor *kHYChartInformationViewShadowColor = nil;

@interface HYChartValueView : UIView

@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UILabel *unitLabel;

@end

@interface HYChartInformationView ()

@property (nonatomic, strong) HYChartValueView *valueView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *separatorView;

// Position
- (CGRect)valueViewRect;
- (CGRect)titleViewRectForHidden:(BOOL)hidden;
- (CGRect)separatorViewRectForHidden:(BOOL)hidden;

@end

@implementation HYChartInformationView

#pragma mark - Alloc/Init

+ (void)initialize
{
	if (self == [HYChartInformationView class])
	{
		kHYChartViewSeparatorColor = [UIColor whiteColor];
        kHYChartViewTitleColor = [UIColor whiteColor];
        kHYChartViewShadowColor = [UIColor blackColor];
	}
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.clipsToBounds = YES;

        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        _titleLabel.numberOfLines = 1;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = kHYChartViewTitleColor;
        _titleLabel.shadowColor = kHYChartViewShadowColor;
        _titleLabel.shadowOffset = CGSizeMake(0, 1);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];

        _separatorView = [[UIView alloc] init];
        _separatorView.backgroundColor = kHYChartViewSeparatorColor;
        [self addSubview:_separatorView];

        _valueView = [[HYChartValueView alloc] initWithFrame:[self valueViewRect]];
        [self addSubview:_valueView];
        
        [self setHidden:YES animated:NO];
    }
    return self;
}

#pragma mark - Position

- (CGRect)valueViewRect
{
    CGRect valueRect = CGRectZero;
    valueRect.origin.x = kHYChartValueViewPadding;
    valueRect.origin.y = kHYChartValueViewPadding + kHYChartValueViewTitleHeight;
    valueRect.size.width = self.bounds.size.width - (kHYChartValueViewPadding * 2);
    valueRect.size.height = self.bounds.size.height - valueRect.origin.y - kHYChartValueViewPadding;
    return valueRect;
}

- (CGRect)titleViewRectForHidden:(BOOL)hidden
{
    CGRect titleRect = CGRectZero;
    titleRect.origin.x = kHYChartValueViewPadding;
    titleRect.origin.y = hidden ? -kHYChartValueViewTitleHeight : kHYChartValueViewPadding;
    titleRect.size.width = self.bounds.size.width - (kHYChartValueViewPadding * 2);
    titleRect.size.height = kHYChartValueViewTitleHeight;
    return titleRect;
}

- (CGRect)separatorViewRectForHidden:(BOOL)hidden
{
    CGRect separatorRect = CGRectZero;
    separatorRect.origin.x = kHYChartValueViewPadding;
    separatorRect.origin.y = kHYChartValueViewTitleHeight;
    separatorRect.size.width = self.bounds.size.width - (kHYChartValueViewPadding * 2);
    separatorRect.size.height = kHYChartValueViewSeparatorSize;
    if (hidden)
    {
        separatorRect.origin.x -= self.bounds.size.width;
    }
    return separatorRect;
}

#pragma mark - Setters

- (void)setTitleText:(NSString *)titleText
{
    self.titleLabel.text = titleText;
    self.separatorView.hidden = !(titleText != nil);
}

- (void)setValueText:(NSString *)valueText unitText:(NSString *)unitText
{
    self.valueView.valueLabel.text = valueText;
    self.valueView.unitLabel.text = unitText;
    [self.valueView setNeedsLayout];
}

- (void)setTitleTextColor:(UIColor *)titleTextColor
{
    self.titleLabel.textColor = titleTextColor;
    [self.valueView setNeedsDisplay];
}

- (void)setValueAndUnitTextColor:(UIColor *)valueAndUnitColor
{
    self.valueView.valueLabel.textColor = valueAndUnitColor;
    self.valueView.unitLabel.textColor = valueAndUnitColor;
    [self.valueView setNeedsDisplay];
}

- (void)setTextShadowColor:(UIColor *)shadowColor
{
    self.valueView.valueLabel.shadowColor = shadowColor;
    self.valueView.unitLabel.shadowColor = shadowColor;
    self.titleLabel.shadowColor = shadowColor;
    [self.valueView setNeedsDisplay];
}

- (void)setSeparatorColor:(UIColor *)separatorColor
{
    self.separatorView.backgroundColor = separatorColor;
    [self setNeedsDisplay];
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated
{
    if (animated)
    {
        if (hidden)
        {
            [UIView animateWithDuration:kHYChartValueViewDefaultAnimationDuration * 0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.titleLabel.alpha = 0.0;
                self.separatorView.alpha = 0.0;
                self.valueView.valueLabel.alpha = 0.0;
                self.valueView.unitLabel.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.titleLabel.frame = [self titleViewRectForHidden:YES];
                self.separatorView.frame = [self separatorViewRectForHidden:YES];
            }];
        }
        else
        {
            [UIView animateWithDuration:kHYChartValueViewDefaultAnimationDuration delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.titleLabel.frame = [self titleViewRectForHidden:NO];
                self.titleLabel.alpha = 1.0;
                self.valueView.valueLabel.alpha = 1.0;
                self.valueView.unitLabel.alpha = 1.0;
                self.separatorView.frame = [self separatorViewRectForHidden:NO];
                self.separatorView.alpha = 1.0;
            } completion:nil];
        }
    }
    else
    {
        self.titleLabel.frame = [self titleViewRectForHidden:hidden];
        self.titleLabel.alpha = hidden ? 0.0 : 1.0;
        self.separatorView.frame = [self separatorViewRectForHidden:hidden];
        self.separatorView.alpha = hidden ? 0.0 : 1.0;
        self.valueView.valueLabel.alpha = hidden ? 0.0 : 1.0;
        self.valueView.unitLabel.alpha = hidden ? 0.0 : 1.0;
    }
}

- (void)setHidden:(BOOL)hidden
{
    [self setHidden:hidden animated:NO];
}

@end

@implementation HYChartValueView

#pragma mark - Alloc/Init

+ (void)initialize
{
	if (self == [HYChartValueView class])
	{
		kHYChartInformationViewValueColor = [UIColor whiteColor];
        kHYChartInformationViewUnitColor = [UIColor whiteColor];
        kHYChartInformationViewShadowColor = [UIColor blackColor];
	}
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:60];
        _valueLabel.textColor = kHYChartInformationViewValueColor;
        _valueLabel.shadowColor = kHYChartInformationViewShadowColor;
        _valueLabel.shadowOffset = CGSizeMake(0, 1);
        _valueLabel.backgroundColor = [UIColor clearColor];
        _valueLabel.textAlignment = NSTextAlignmentRight;
        _valueLabel.adjustsFontSizeToFitWidth = YES;
        _valueLabel.numberOfLines = 1;
        [self addSubview:_valueLabel];
        
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:60];
        _unitLabel.textColor = kHYChartInformationViewUnitColor;
        _unitLabel.shadowColor = kHYChartInformationViewShadowColor;
        _unitLabel.shadowOffset = CGSizeMake(0, 1);
        _unitLabel.backgroundColor = [UIColor clearColor];
        _unitLabel.textAlignment = NSTextAlignmentLeft;
        _unitLabel.adjustsFontSizeToFitWidth = YES;
        _unitLabel.numberOfLines = 1;
        [self addSubview:_unitLabel];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    CGSize valueLabelSize = CGSizeZero;
//    if ([self.valueLabel.text respondsToSelector:@selector(sizeWithAttributes:)])
//    {
        valueLabelSize = [self.valueLabel.text sizeWithAttributes:@{NSFontAttributeName:self.valueLabel.font}];
//    }
//    else
//    {
//        valueLabelSize = [self.valueLabel.text sizeWithFont:self.valueLabel.font];
//    }

    CGSize unitLabelSize = CGSizeZero;
//    if ([self.unitLabel.text respondsToSelector:@selector(sizeWithAttributes:)])
//    {
        unitLabelSize = [self.unitLabel.text sizeWithAttributes:@{NSFontAttributeName:self.unitLabel.font}];
//    }
//    else
//    {
//        unitLabelSize = [self.unitLabel.text sizeWithFont:self.unitLabel.font];
//    }
    
    CGFloat xOffset = ceil((self.bounds.size.width - (valueLabelSize.width + unitLabelSize.width)) * 0.5);

    self.valueLabel.frame = CGRectMake(xOffset, ceil(self.bounds.size.height * 0.5) - ceil(valueLabelSize.height * 0.5), valueLabelSize.width, valueLabelSize.height);
    self.unitLabel.frame = CGRectMake(CGRectGetMaxX(self.valueLabel.frame), ceil(self.bounds.size.height * 0.5) - ceil(unitLabelSize.height * 0.5) + kHYChartValueViewPadding + 3, unitLabelSize.width, unitLabelSize.height);
}

@end
