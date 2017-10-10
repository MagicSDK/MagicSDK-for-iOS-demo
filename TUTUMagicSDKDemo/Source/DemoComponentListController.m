//
//  DemoComponentListController.m
//  TuSDKDemo
//
//  Created by Yanlin on 12/17/15.
//  Copyright © 2015 tusdk.com. All rights reserved.
//

#import "DemoComponentListController.h"
#import "DemoRootView.h"

//Samples

#import "CameraComponentSample.h"
#import "EditMultipleComponentSample.h"

#import "AlbumComponentSample.h"
#import "AlbumMultipleComponentSample.h"

#pragma mark - DemoComponentListController
@interface DemoComponentListController ()<DemoRootViewDelegate>
@property (nonatomic, retain) DemoRootView *view;
@property (nonatomic, retain) UIScreenEdgePanGestureRecognizer *screenEdgePanGesture;
@property (nonatomic, retain) UISwipeGestureRecognizer *swipeGesture;
@end

@implementation DemoComponentListController
@dynamic view;

- (void)loadView;
{
    [super loadView];
    
    // Set StatusBar be hidden for IOS6
    self.wantsFullScreenLayout = YES;
    [self setNavigationBarHidden:NO animated:NO];
    [self setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];

    CGFloat autoHeightForComponentList = ([UIDevice lsqSystemFloatVersion] < 7.f) ? [UIScreen height] - lsq_NAV_BAR_HEIGHT : [UIScreen height];
    self.view = [DemoRootView initWithFrame:CGRectMake(0, 0, lsqScreenWidth, autoHeightForComponentList)];
    self.view.backgroundColor = lsqRGB(255, 255, 255);
    self.view.delegate = self;
    
    // UIScreenEdgePanGestureRecognizer
    if ([UIDevice lsqSystemFloatVersion] < 7.0f) {
        _swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onSwipeGesture:)];
        _swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:_swipeGesture];
    }else if ([UIDevice lsqSystemFloatVersion] > 7.0f) {
        _screenEdgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(onScreenEdgePanGesture:)];
        _screenEdgePanGesture.edges = UIRectEdgeLeft;
        [self.view addGestureRecognizer:_screenEdgePanGesture];
    }
}

// UIScreenEdgePanGestureRecognizer Event
-(void)onSwipeGesture:(UISwipeGestureRecognizer *)recognizer;
{
    [self popViewControllerAnimated:YES];

    [self.view removeGestureRecognizer:_swipeGesture];
}

-(void)onScreenEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer;
{
    [self popViewControllerAnimated:YES];

    [self.view removeGestureRecognizer:_screenEdgePanGesture];
}

// Set StatusBar be hidden for IOS7
- (BOOL)prefersStatusBarHidden;
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Just for demo，please do not add to your project
    [TuSDKTKStatistics appendWithComponentIdt:tkc_sdkComponent];
    
    self.title = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"app_name", @"TuSDK 涂图"), lsqSDKVersion ];
    
    [self navLeftButtonWithTitle:NSLocalizedString(@"back", @"back") action:@selector(backActionHadAnimated)];
    
    /**
     * ！！！！！！！！！！！！！！！！！！！！！！！！！Attention ！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
     * Developer can know all the component by checking [group appenWithSimple:] class file
     * - (void)showSampleWithController:(UIViewController *)controller;
     *
     */
    // SampleGroup
    SampleGroup *group = [SampleGroup group];
    
    // CameraComponentSample
    [group appenWithSample:[CameraComponentSample sample]];
    // EditMultipleComponentSample（Photo Editor Component）
    [group appenWithSample:[EditMultipleComponentSample sample]];
    
    // AlbumComponentSample(Single-seleted Album)
    [group appenWithSample:[AlbumComponentSample sample]];
    // AlbumMultipleComponentSample (Muti-seleted Album)
    [group appenWithSample:[AlbumMultipleComponentSample sample]];
        
    self.view.group = group;
}

#pragma mark - DemoRootViewDelegate
/**
 *  Choose sample
 *
 *  @param view
 *  @param sample
 *  @param action 
 */
- (void)demoRootView:(DemoRootView *)view
      selectedSample:(SampleBase *)sample
          withAction:(demoListItemAction)action;
{
    if (!sample) return;
    switch (action) {
        case demoListItemActionSelected:
            
            if (sample.controllerClazz)
            {
                UIViewController *controller = [[sample.controllerClazz alloc] init];
                [self pushViewController:controller animated:YES];
            }
            else
            {
                [sample showSampleWithController:self];
            }
            break;
        default:
            break;
    }
}
@end
