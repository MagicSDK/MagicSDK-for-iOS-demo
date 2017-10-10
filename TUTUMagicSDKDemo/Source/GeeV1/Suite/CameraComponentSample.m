//
//  CameraComponentSample.m
//  TuSDKDemo
//
//  Created by Clear Hu on 15/4/24.
//  Copyright (c) 2015年 tusdk.com. All rights reserved.
//

#import "CameraComponentSample.h"

/**
 *  CameraComponent
 */
@interface CameraComponentSample()<TuSDKPFCameraDelegate>

@end

@implementation CameraComponentSample
- (instancetype)init;
{
    self = [super initWithGroupId:SuiteSample title:NSLocalizedString(@"sample_CameraComponent", @"相机组件")];
    return self;
}

/**
 *  Show Sample
 *
 *  @param controller
 */
- (void)showSampleWithController:(UIViewController *)controller;
{
    
    // 组件使用文档教程
    // @see-https://tusdk.com/docs/ios/camera-usage
    
    if (!controller) return;
    self.controller = controller;
    
    // Request Camera Permission
    [TuSDKTSDeviceSettings checkAllowWithController:self.controller
                                               type:lsqDeviceSettingsCamera
                                          completed:^(lsqDeviceSettingsType type, BOOL openSetting)
     {
         if (openSetting) {
             lsqLError(@"Can not open camera");
             return;
         }
         [self showCameraController];
     }];
}

#pragma mark - cameraComponentHandler TuSDKPFCameraDelegate
- (void)showCameraController;
{
    
    // Configuration
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFCameraOptions.html
    TuSDKPFCameraOptions *opt = [TuSDKPFCameraOptions build];
    
    // default camera view class，need to inherit MagicSDKPFCameraView ,modify the default method，set the new class
    // opt.viewClazz = [TuSDKPFCameraView class];
    
    // default camera top bar view class，need to inherit MagicSDKPFCameraConfigView ,modify the default method，set the new class
    // opt.configBarViewClazz = [TuSDKPFCameraConfigView class];
    
    // default camera bottom bar view class，need to inherit MagicSDKPFCameraBottomView ,modify the default method，set the new class
    // opt.bottomBarViewClazz = [TuSDKPFCameraBottomView class];
    
    // default camera flash view class，need to inherit MagicSDKPFCameraFlashView ,modify the default method，set the new class
    // opt.flashViewClazz = [TuSDKPFCameraFlashView class];
    
    // default camera flter group view class，need to inherit MagicSDKPFCameraFilterGroupView ,modify the default method，set the new class
    // opt.filterViewClazz = [TuSDKPFCameraFilterGroupView class];
    
    // default camera focus touch view class，need to inherit MagicSDKCPFocusTouchView ,modify the default method，set the new class
    // opt.focusTouchViewClazz = [TuSDKCPFocusTouchView class];
    
    // camera position，default ：back camera position
    // opt.cameraPostion = [AVCaptureDevice lsqFirstBackCameraPosition];
    
    // AVCaptureSession，default：AVCaptureSessionPresetHigh，reference AVCaptureSession.h
    // opt.sessionPreset = AVCaptureSessionPresetHigh;
    
    // Camera flash mode,default:AVCaptureFlashModeOff
    // opt.cameraDefaultFlashMode = AVCaptureFlashModeOff;
    
    // Enable filter module
    // Camera will start with filter module when it turn on
    opt.enableFilters = YES;
    
    // Enable default filter
    // Both ` enableFilters` and `showFilterDefault` must turn on
    opt.showFilterDefault = YES;
    
    // Enable filter history record
    // opt.enableFilterHistory = YES;
    
    // Enable filter title view
    // There will be a title view with filter name when changing filters
    opt.displayFilterSubtitles = YES;
    
    // Width of filter bar Cell
    // opt.filterBarCellWidth = 60;
    
    // Height of filter bar
    // opt.filterBarHeight = 80;
    
    // default camera filter group cell view class，need to inherit MagicSDKCPGroupFilterGroupCell ,modify the default method，set the new class
    // opt.filterBarGroupCellClazz = [TuSDKCPGroupFilterGroupCell class];
    
    // default camera filter group item cell view class，need to inherit MagicSDKCPGroupFilterItemCell ,modify the default method，set the new class
    // opt.filterBarTableCellClazz = [TuSDKCPGroupFilterItemCell class];
    
    // Filter Group：fill the array with filter code
    // MagicSDK.bundle/others/lsq_MagicSDK_configs.json
    // filter name:lsq_filter_Brilliant
    // filter code:Brilliant
    // opt.filterGroup = @[@"SkinNature", @"SkinPink", @"SkinJelly", @"SkinNoir", @"SkinRuddy", @"SkinPowder", @"SkinSugar"];
    
    // Save last used filter
    opt.saveLastFilter = YES;
    
    // Enable filter parameter configuration
    opt.enableFilterConfig = YES;
    
    // Enable Capture Preview (Default: NO)
    opt.enablePreview = YES;
    
    // Camera view ratio
    // set the parameter ：0，camera view will be full screen
    // 0 <= cameraViewRatio <= 1
    // set the parameter，the parameter `ratioType` will not work
    // opt.cameraViewRatio = 0.75f;
    
    // camera view ratiotype
    // opt.ratioType = lsqRatioDefault;
    
    // Long press capture setting(Default:NO)
    // Camera will enable long time touch to capture picture when it turn on
    opt.enableLongTouchCapture = YES;
    
    // Focus setting(Default:NO)
    // Camera will continue focusing when it turn on
    // opt.disableContinueFoucs = YES;
    
    // Focus setting
    // Camera will focus every 5 seconds
    // opt.autoFoucsDelay = 5;
    
    // Long press capture setting
    // Camera will capture picture after long pressing screen for 1.2 second
    // opt.longTouchDelay = 1.2;
    
    // Save picture to album (Default:NO)
    opt.saveToAlbum = YES;
    
    // Creat a file path (Default:NO)
    // opt.saveToTemp = NO;
    
    // Save picture to album with custom name
    // opt.saveToAlbumName = @"TuSdk";
    
    // Image output compression
    // set parameter 1，the image file type will be jpeg
    // set parameter 0，the image file type will be png
    // opt.outputCompress = 0.95f;
    
    // Camera view region color ,default： [UIColor clearColor]
    // Set parameter as @"#FF5534" ,use the color object of the hexadecimal string
    opt.regionViewColor = [UIColor lsqClorWithHex:@"#403e43"];
    
    // Image output size
    // set the parameter，the parameter `ratioType` will not work
    // opt.outputSize = CGSizeMake(1440, 1920);
    
    // 禁用前置摄像头自动水平镜像 (默认: NO，前置摄像头拍摄结果自动进行水平镜像)
    // opt.disableMirrorFrontFacing = YES;
    
    // horizontal mirror image
    opt.displayGuideLine = false;
    
    // Enable Face Detection
    opt.enableFaceDetection = YES;
    
    // WaterMark (Default:nil)
    // opt.waterMarkOption = [self waterMarkOption];
    
    // Enable Capture With VolumeKeys (Default:NO)
    opt.enableCaptureWithVolumeKeys = YES;

    // Enable Focal Distance Configuration,
    opt.enableFocalDistance = YES;
    
    // Focal Distance Scale (Default: 1，minimum is 1)
    opt.focalDistanceScale = 1.0;

    
    TuSDKPFCameraViewController *controller = opt.viewController;
    controller.delegate = self;
    [self.controller presentModalNavigationController:controller animated:YES];
    

}

/**
 *  Watermark
 *
 *  @return
 */
- (TuSDKWaterMarkOption *)waterMarkOption;
{
    TuSDKWaterMarkOption *option = [[TuSDKWaterMarkOption alloc] init];
    
    // set watermark text or watermark image
    // Watermark Text
    option.markText = @"";
    
    // Watermark Text Color
    option.markTextColor = [UIColor whiteColor];
    
    // Watermark Text Size (Default: 24 SP)
    option.markTextSize = 24;
    
    // Watermark Text Shadow color (默认:[UIColor grayColor])
    option.markTextShadowColor = [UIColor grayColor];
    
    // Watermark image
    option.markImage = [UIImage imageNamed:@"sample_watermark.png"];
    
    // Position of text and image (Both exist，default: lsqMarkTextPositionRight)
    option.markTextPosition = lsqMarkTextPositionRight;

    // Position of Watermark (Default: lsqWaterMarkBottomRight)
    option.markPosition = lsqWaterMarkBottomRight;
    
    // Watermark Margin (Default: 6dp)
    option.markMargin = 6;
    
    // Distance between text and image(Both exist,default: 2dp)
    option.markTextPadding = 5;
    
    return option;
}

/**
 *  Capture Result
 *
 *  @param controller
 *  @param result     
 */
- (void)onTuSDKPFCamera:(TuSDKPFCameraViewController *)controller captureResult:(TuSDKResult *)result;
{
    [controller dismissModalViewControllerAnimated:YES];
    lsqLDebug(@"onTuSDKPFCamera: %@", result);
}

#pragma mark - TuSDKCPComponentErrorDelegate
/**
 *  Error Information
 *
 *  @param controller
 *  @param result
 *  @param error      
 */
- (void)onComponent:(TuSDKCPViewController *)controller result:(TuSDKResult *)result error:(NSError *)error;
{
    lsqLDebug(@"onComponent: controller - %@, result - %@, error - %@", controller, result, error);
}
@end
