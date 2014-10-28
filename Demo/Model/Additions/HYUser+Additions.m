//
//  HYUser+Additions.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYUser+Additions.h"
#import "HYDataModel.h"
#import "HYSittingHour.h"

@interface HYDataModel (Private)

- (NSArray *)users;

@end

@implementation HYUser (Additions)

#pragma mark - Getters

- (NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (NSArray *)friends
{
    NSArray *masterUserUsers = [[HYDataModel sharedInstance] users];
    NSArray *friends = [masterUserUsers subarrayWithRange:NSMakeRange(1, [masterUserUsers count] - 1)];
    return friends;
}

@end
