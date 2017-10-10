//
//  DemoRootView.h
//  TuSDKDemo
//
//  Created by Clear Hu on 15/4/24.
//  Copyright (c) 2015年 tusdk.com. All rights reserved.
//

#import "TUTUMagicSDK.h"
#import "SampleBase.h"

/**
 *  Sample Seleted Action
 */
typedef NS_ENUM(NSInteger, demoListItemAction)
{
    /**
     * Seleted
     */
    demoListItemActionSelected,
    /**
     * Configuration
     */
    demoListItemActionConfig,
};

@class DemoRootView;

/**
 *  Sample List Choose Delegate
 */
@protocol DemoRootViewDelegate <NSObject>
/**
 *  Choose Sample
 *
 *  @param view
 *  @param simple
 *  @param action
 */
- (void)demoRootView:(DemoRootView *)view
      selectedSample:(SampleBase *)simple
          withAction:(demoListItemAction)action;
@end


#pragma mark - DemoRootView
/**
 *  RootView
 */
@interface DemoRootView : UIView
/**
 *  Sample List Choose Delegate
 */
@property (nonatomic, weak) id<DemoRootViewDelegate> delegate;

/**
 *  Sample Group
 */
@property (nonatomic, retain) SampleGroup *group;
@end
