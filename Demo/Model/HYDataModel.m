//
//  HYDataModel.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYDataModel.h"

#import "HYSittingHour.h"
#import "HYUser+Additions.h"

// Enums
typedef NS_ENUM(NSUInteger, HYDataModelMockUserType){
    HYDataModelMockUserType1,
    HYDataModelMockUserType2,
    HYDataModelMockUserType3,
    HYDataModelMockUserType4,
    HYDataModelMockUserType5,
    HYDataModelMockUserType6,
    HYDataModelMockUserType7,
    HYDataModelMockUserType8,
    HYDataModelMockUserType9,
    HYDataModelMockUserType10,
    HYDataModelMockUserTypeCount
};

// Numerics
NSUInteger static const kHYDataModelMonthsInYear = 12;
NSUInteger static const kHYDataModelDaysInYear = 365;
NSUInteger static const kHYDataModelMaxStep = 15000;
NSUInteger static const kHYDataModelMinStep = 3000;
static NSString *const kHYDataModelProfilePhotoMockUser = @"profile_photo_mock_user_%d.png";

@interface HYDataModel ()

@property (nonatomic, strong) NSArray *users;

// Random helpers
- (NSUInteger)randomStep;
- (NSDate *)randomCreateDate;

// Users helpers
- (HYUser *)generateMockUserType:(HYDataModelMockUserType)userType;

// Rangers

@end

@implementation HYDataModel

#pragma mark - Alloc/Init

+ (HYDataModel *)sharedInstance
{
    static dispatch_once_t pred;
    static HYDataModel *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - Getters

- (HYUser *)currentUser
{
    return [self.users firstObject];
}

- (NSArray *)users
{
    if (_users == nil)
    {
        NSMutableArray *mutableUsers = [NSMutableArray array];
        for (NSUInteger userIndex=0; userIndex<HYDataModelMockUserTypeCount; userIndex++)
        {
            HYUser *user = [self generateMockUserType:userIndex];
            
            NSMutableArray *mutableSteps = [NSMutableArray array];
            for (NSUInteger dayIndex=0; dayIndex<kHYDataModelMonthsInYear; dayIndex++)
            {
                HYSittingHour *sittingHour = [[HYSittingHour alloc] initWithValue:[self randomStep]];
                [mutableSteps addObject:sittingHour];
            }
            user.sittingHours = [NSArray arrayWithArray:mutableSteps];
            [mutableUsers addObject:user];
        }
        _users = [NSArray arrayWithArray:mutableUsers];
    }
    return _users;
}

#pragma mark - Random Helpers

- (NSUInteger)randomStep
{
    return ((arc4random() % (kHYDataModelMaxStep - kHYDataModelMinStep + 1)) + kHYDataModelMinStep);
}

- (NSDate *)randomCreateDate
{
    NSUInteger minimumDate = kHYDataModelDaysInYear;
    NSUInteger maximumDate = kHYDataModelDaysInYear * 3;
    u_int32_t randomDays = arc4random_uniform((u_int32_t)maximumDate - (u_int32_t)minimumDate + 1) + (u_int32_t)minimumDate;
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today];
    [dateComponents setDay:dateComponents.day - randomDays];
    return [calendar dateFromComponents:dateComponents];
}

- (HYUser *)generateMockUserType:(HYDataModelMockUserType)userType
{
    HYUser *mockUser = [[HYUser alloc] init];
    mockUser.createDate = [self randomCreateDate];
    mockUser.profileImage = [UIImage imageNamed:[NSString stringWithFormat:@"profile_photo_mock_user_%lu.png", userType + 1]];
    
    if (userType == HYDataModelMockUserType1)
    {
        mockUser.firstName = @"Hanton";
        mockUser.lastName = @"Yang";
        mockUser.gender = HYUserGenderMale;
    }
    else if (userType == HYDataModelMockUserType2)
    {
        mockUser.firstName = @"Dana";
        mockUser.lastName = @"Fletcher";
        mockUser.gender = HYUserGenderFemale;
    }
    else if (userType == HYDataModelMockUserType3)
    {
        mockUser.firstName = @"Ella";
        mockUser.lastName = @"Hudson";
        mockUser.gender = HYUserGenderFemale;
    }
    else if (userType == HYDataModelMockUserType4)
    {
        mockUser.firstName = @"Donald";
        mockUser.lastName = @"Miller";
        mockUser.gender = HYUserGenderMale;
    }
    else if (userType == HYDataModelMockUserType5)
    {
        mockUser.firstName = @"Albert";
        mockUser.lastName = @"Murray";
        mockUser.gender = HYUserGenderMale;
    }
    else if (userType == HYDataModelMockUserType6)
    {
        mockUser.firstName = @"Byron";
        mockUser.lastName = @"Davis";
        mockUser.gender = HYUserGenderMale;
    }
    else if (userType == HYDataModelMockUserType7)
    {
        mockUser.firstName = @"Olivia";
        mockUser.lastName = @"Woods";
        mockUser.gender = HYUserGenderFemale;
    }
    else if (userType == HYDataModelMockUserType8)
    {
        mockUser.firstName = @"Mason";
        mockUser.lastName = @"Webb";
        mockUser.gender = HYUserGenderMale;
    }
    else if (userType == HYDataModelMockUserType9)
    {
        mockUser.firstName = @"Jon";
        mockUser.lastName = @"Nelson";
        mockUser.gender = HYUserGenderMale;
    }
    else if (userType == HYDataModelMockUserType10)
    {
        mockUser.firstName = @"Hannah";
        mockUser.lastName = @"Neal";
        mockUser.gender = HYUserGenderFemale;
    }
    
    return mockUser;
}

#pragma mark - Metrics

- (CGFloat)maximumStepValue
{
    NSUInteger currentMaxStepValue = 0;
    for (HYUser *user in [self users])
    {
        for (HYSittingHour *sittingHour in user.sittingHours)
        {
            if (sittingHour.value > currentMaxStepValue)
            {
                currentMaxStepValue = sittingHour.value;
            }
        }
    }
    return currentMaxStepValue;
}

- (CGFloat)minimumStepValue
{
    NSUInteger currentMinStepValue = INT_MAX;
    for (HYUser *user in [self users])
    {
        for (HYSittingHour *sittingHour in user.sittingHours)
        {
            if (sittingHour.value < currentMinStepValue)
            {
                currentMinStepValue = sittingHour.value;
            }
        }
    }
    return currentMinStepValue;
}

- (CGFloat)averageStepValue
{
    NSUInteger totalStepValue = 0;
    NSUInteger totalStepCount = 0;
    for (HYUser *user in [self users])
    {
        for (HYSittingHour *sittingHour in user.sittingHours)
        {
            totalStepValue += sittingHour.value;
            totalStepCount++;
        }
    }
    return (CGFloat)totalStepValue / (CGFloat)totalStepCount;
}

@end

