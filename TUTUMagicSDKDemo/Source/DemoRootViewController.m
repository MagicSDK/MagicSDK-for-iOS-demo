//
//  DemoRootViewController.m
//  TuSDKDemo
//
//  Created by Clear Hu on 14/10/28.
//  Copyright (c) 2014年 tusdk.com. All rights reserved.
//

#import "DemoRootViewController.h"

//Samples
#import "CameraComponentSample.h"
#import "EditMultipleComponentSample.h"
#import "DemoComponentListController.h"

#pragma mark - DemoRootViewController
@interface DemoRootViewController ()<TuSDKFilterManagerDelegate>
{
    CameraComponentSample *cameraComponentSample;
    EditMultipleComponentSample *editMultipleComponentSample;
}
@end

@implementation DemoRootViewController

- (void)loadView;
{
    [super loadView];
    
    // Set StatusBar be hidden for IOS6
    self.wantsFullScreenLayout = YES;
    [self setNavigationBarHidden:YES animated:NO];
    [self setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

// Set StatusBar be hidden for IOS7
- (BOOL)prefersStatusBarHidden;
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self lsqInitView];
    // Location Initialization (when in use)
    [[TuSDKTKLocation shared] requireAuthorWithController:self];
    
    /**
     * ！！！！！！！！！！！！！！！！！！！！！！！！！Attention ！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
     * About File Size（increase the size of ipa about 2M）：
     * 1,If no need of Sticker Module，please delete /app/TuSDK.bundle/stickers，and disable module in EditMultipleComponentSample
     * 2,If no need of Filter Module，please delete /app/TuSDK.bundle/textures，and disable module in CameraComponentSample and EditMultipleComponentSample
     *
     * iOS Framework：
     * TuSDK support arm64,armv7 and armv7s;
     * Every CPU compiling result contains two modes : Debug and Realse；
     *
     * Docs:http://tusdk.com/doc
     */
    
    [self showHubWithStatus:LSQString(@"lsq_initing", @"Initializing...")];
    
    // Asynchronous initialization
    
    [TuSDK checkManagerWithDelegate:self];
    
    NSLog(@"MagicSDK.framework Version : %@",lsqSDKVersion);
    
    NSLog(@"MagicSDKGeeV1.framework Version : %@",lsqGeeVersion);
}

- (void)lsqInitView
{
    CGRect rect = self.view.bounds;
    
    // BackgroundImage
    UIImageView *backgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, 1334.0/750.0*rect.size.width)];
    backgroundImage.center = self.view.center;
    backgroundImage.image = [UIImage imageNamed:@"bg"];
    backgroundImage.userInteractionEnabled = YES;
    [self.view addSubview:backgroundImage];
    
    CGFloat centerX = self.view.frame.size.width/2;
    CGFloat centerY = self.view.frame.size.height/3;
    CGFloat buttonWidth = 113;
    CGFloat labelHeight = 28;
    
    // CameraButton
    UIButton *cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, buttonWidth, buttonWidth)];
    cameraButton.center = CGPointMake(centerX, centerY - 5);
    [cameraButton setImage:[UIImage imageNamed:@"camera_icon"] forState:UIControlStateNormal];
    [cameraButton addTouchUpInsideTarget:self action:@selector(openEffectCamera)];
    cameraButton.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:cameraButton];

    UILabel *cameraButtonText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 28)];
    cameraButtonText.center = CGPointMake(centerX, cameraButton.frame.origin.y + buttonWidth + labelHeight/2 + 5);
    cameraButtonText.text = NSLocalizedString(@"demo_component_camera", @"Camera");
    cameraButtonText.textColor = [UIColor lsqClorWithHex:@"#FFFFFF"];
    cameraButtonText.textAlignment = NSTextAlignmentCenter;
    cameraButtonText.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:cameraButtonText];
    
    // Photo Editor Button
    UIButton *editorButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, buttonWidth, buttonWidth)];
    editorButton.center = CGPointMake(centerX, centerY*2 - 20);
    [editorButton setImage:[UIImage imageNamed:@"edit_icon"] forState:UIControlStateNormal];
    editorButton.adjustsImageWhenHighlighted = NO;
    [editorButton addTouchUpInsideTarget:self action:@selector(openImageEditor)];
    editorButton.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:editorButton];
    
    UILabel *editorButtonText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 28)];
    editorButtonText.center = CGPointMake(centerX, centerY*2 + buttonWidth/2 );
    editorButtonText.text = NSLocalizedString(@"demo_component_editor" , @"Edit");
    editorButtonText.textColor = [UIColor lsqClorWithHex:@"#FFFFFF"];
    editorButtonText.textAlignment = NSTextAlignmentCenter;
    editorButtonText.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:editorButtonText];
    
}

#pragma mark - Click Event
-(void)openEffectCamera;
{
    if (cameraComponentSample == nil)
    {
        cameraComponentSample = [CameraComponentSample sample];
    }
    [cameraComponentSample showSampleWithController:self];
}

-(void)openImageEditor;
{
    if (editMultipleComponentSample == nil)
    {
        editMultipleComponentSample = [EditMultipleComponentSample sample];
    }
    [editMultipleComponentSample showSampleWithController:self];
}



#pragma mark - TuSDKFilterManagerDelegate
/**
 * Filter Manager Examination
 *
 * @param manager filter manager
 *
 */
- (void)onTuSDKFilterManagerInited:(TuSDKFilterManager *)manager;
{
    [self showHubSuccessWithStatus:LSQString(@"lsq_inited", @"Initialized")];
}
@end
