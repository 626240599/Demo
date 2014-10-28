//
//  HYSittingHour.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYSittingHour.h"

@interface HYSittingHour ()

@property (nonatomic, assign) NSUInteger value;

@end

@implementation HYSittingHour

#pragma mark - Alloc/Init

- (id)initWithValue:(NSUInteger)value
{
    self = [super init];
    if (self)
    {
        _value = value;
    }
    return self;
}

@end
