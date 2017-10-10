//
//  SampleBase.m
//  TuSDKDemo
//
//  Created by Clear Hu on 15/4/24.
//  Copyright (c) 2015年 tusdk.com. All rights reserved.
//

#import "SampleBase.h"

#pragma mark - SampleBase
/**
 *  SampleBase
 */
@implementation SampleBase
/**
 *  SampleBase
 *
 *  @return sampleBase
 */
+ (instancetype)sample;
{
    return [[self alloc]init];
}

/**
 *  SampleBase
 *
 *  @param groupId
 *  @param title
 *
 *  @return sampleBase
 */
- (instancetype)initWithGroupId:(SampleType)groupId title:(NSString *)title;
{
    self = [super init];
    if (self) {
        _groupId = groupId;
        _title = title;
    }
    return self;
}

/**
 *  ShowSample
 *
 *  @param controller
 */
- (void)showSampleWithController:(UIViewController *)controller;
{
    lsqLDebug(@"You need rewrite the %@ func: - (void)showSampleWithController:(UIViewController *)controller;", [self class]);
}
@end


#pragma mark - GroupHeader
/**
 *  GroupHeader
 */
@implementation GroupHeader : NSObject
/**
 *  GroupHeaderInfo
 *
 *  @param groupId
 *  @param title
 *
 *  @return GroupHeader
 */
+ (instancetype)headerWithGroupId:(NSUInteger)groupId title:(NSString *)title;
{
    return [[self alloc]initWithGroupId:groupId title:title];
}

- (instancetype)initWithGroupId:(NSUInteger)groupId title:(NSString *)title;
{
    self = [super init];
    if (self) {
        _groupId = groupId;
        _title = title;
        _datas = [NSMutableArray array];
    }
    return self;
}
@end

#pragma mark - SampleGroup
/**
 *  SampleGroup
 */
@implementation SampleGroup : NSObject
/**
 *  SampleGroup
 *
 *  @return sampleGroup
 */
+ (instancetype)group;
{
    return [[self alloc]init];
}

- (instancetype)init;
{
    self = [super init];
    if (self) {
        self.headers = @[
                         [GroupHeader headerWithGroupId:SuiteSample title:NSLocalizedString(@"sample_group_suite", @"功能套件")],
                         [GroupHeader headerWithGroupId:ComponentSample title:NSLocalizedString(@"sample_group_comp", @"常用组件")],
                         ];
    }
    return self;
}


/**
 *  AppenWithSample
 *
 *  @param simple
 */
- (void)appenWithSample:(SampleBase *)sample;
{
    if (!sample) return;
    
    for (GroupHeader *header in self.headers) {
        if (header.groupId == sample.groupId) {
            [header.datas addObject:sample];
        }
    }
}

/**
 *  AppenWithSample
 *
 *  @param title
 *  @param type
 *  @param viewControllerClazz
 */
- (void)appenWithTitle:(NSString *)title group:(SampleType)type clazz:(Class)viewControllerClazz;
{
    SampleBase *sample = [SampleBase new];
    sample.title = title;
    sample.groupId = type;
    sample.controllerClazz = viewControllerClazz;
    
    [self appenWithSample:sample];
}

/**
 *  GroupHeaderInfo
 *
 *  @param index
 *
 *  @return GroupHeaderInfo
 */
- (GroupHeader *)headerWithIndex:(NSUInteger)index;
{
    if (!self.headers || self.headers.count <= index) return nil;
    return [self.headers objectAtIndex:index];
}
@end
