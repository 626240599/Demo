//
//  HYStringContants.h
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#define localize(key, default) NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle], default, nil)

#pragma mark - Labels

#define kHYStringLabelProfile localize(@"label.profile", @"Contacts")
#define kHYStringLabelYou localize(@"label.you", @"You")
#define kHYStringLabelFriends localize(@"label.friends", @"Friends")
#define kHYStringLabelClose localize(@"label.close", @"Close")
#define kHYStringLabelJan localize(@"label.jan", @"Jan")
#define kHYStringLabelDec localize(@"label.dec", @"Dec")
#define kHYStringLabel2013 localize(@"label.2013", @"2013")
#define kHYStringLabelMemberSince localize(@"label.member.since", @"Member since %@")
#define kHYStringLabelAnnualStepData localize(@"label.annual.step.data", @"Sitting Hours")

#define kHYStringLabelXAxis localize(@"label.x.axis", @"Day")
#define kHYStringLabelYAxis localize(@"label.y.axis", @"Hour")
#define kHYStringLabelChart localize(@"label.chart", @"Week %d")
#define kHYStringLabelAnscombeQuartet localize(@"label.anscombe.quartet", @"Anscombe’s Quartet")
#define kHYStringLabelChartDetails localize(@"label.chart.details", @"Week %d Details")
#define kHYStringLabelClose localize(@"label.close", @"Close")
#define kHYStringLabelX localize(@"label.x", @"Day")
#define kHYStringLabelY localize(@"label.y", @"Hour(s)")
