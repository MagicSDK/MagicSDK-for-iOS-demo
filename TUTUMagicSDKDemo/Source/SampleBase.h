//
//  SampleBase.h
//  TuSDKDemo
//
//  Created by Clear Hu on 15/4/24.
//  Copyright (c) 2015年 tusdk.com. All rights reserved.
//

#import "TUTUMagicSDK.h"

typedef NS_ENUM(NSUInteger, SampleType)
{
    /**
     * RecommendSample
     */
    RecommendSample,
    /**
     * SuiteSample
     */
    SuiteSample,
    /**
     * ComponentSample
     */
    ComponentSample,
    /**
     * FeatureSample
     */
    FeatureSample,
    /**
     * UISample
     */
    UISample,
    /**
     * API Sample
     */
    APISample
};

#pragma mark - SampleBase
/**
 *  SampleBase
 */
@interface SampleBase : NSObject
/**
 *  GroupID
 */
@property (nonatomic) SampleType groupId;
/**
 *  Title
 */
@property (nonatomic, copy) NSString *title;

/**
 *  Controller
 */
@property (nonatomic, assign) UIViewController *controller;

/**
 *  ControllerClazz
 */
@property (nonatomic, assign) Class controllerClazz;

/**
 *  SampleBase
 *
 *  @return sample
 */
+ (instancetype)sample;

/**
 *  GroupID
 *
 *  @param groupId
 *  @param title
 *
 *  @return sample
 */
- (instancetype)initWithGroupId:(SampleType)groupId title:(NSString *)title;

/**
 *  Show Sample
 *
 *  @param controller
 */
- (void)showSampleWithController:(UIViewController *)controller;
@end

#pragma mark - GroupHeader
/**
 *  GroupHeader
 */
@interface GroupHeader : NSObject
/**
 *  GroupId
 */
@property (nonatomic) NSUInteger groupId;
/**
 *  Title
 */
@property (nonatomic, copy) NSString *title;

/**
 *  DataList
 */
@property (nonatomic, retain) NSMutableArray *datas;

/**
 *  GroupHeaderInfo
 *
 *  @param groupId
 *  @param title
 *
 *  @return sample
 */
+ (instancetype)headerWithGroupId:(NSUInteger)groupId title:(NSString *)title;
@end

#pragma mark - SampleGroup
/**
 *  SampleGroup
 */
@interface SampleGroup : NSObject
/**
 *  SampleGroupHeaderInfo
 */
@property (nonatomic, retain) NSArray *headers;

/**
 *  Group
 *
 *  @return group
 */
+ (instancetype)group;

/**
 *  Sample
 *
 *  @param simple
 */
- (void)appenWithSample:(SampleBase *)sample;

/**
 *  Sample
 *
 *  @param title
 *  @param type
 *  @param viewControllerClazz
 */
- (void)appenWithTitle:(NSString *)title group:(SampleType)type clazz:(Class)viewControllerClazz;

/**
 *  GroupHeaderIndex
 *
 *  @param index
 *
 *  @return groupHeaderIndex
 */
- (GroupHeader *)headerWithIndex:(NSUInteger)index;
@end
