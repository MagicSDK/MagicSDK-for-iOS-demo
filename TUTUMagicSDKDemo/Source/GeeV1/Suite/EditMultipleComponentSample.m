//
//  EditMultipleComponentSample.m
//  TuSDKDemo
//
//  Created by Clear Hu on 15/4/24.
//  Copyright (c) 2015年 tusdk.com. All rights reserved.
//


#import "EditMultipleComponentSample.h"

/**
 *  Photo Editor Component
 */
@interface EditMultipleComponentSample ()
{
    // Single-Seleted Album
    TuSDKCPAlbumComponent *_albumComponent;
    // Photo Editor Component
    TuSDKCPPhotoEditMultipleComponent *_photoEditMultipleComponent;
}
@end

@implementation EditMultipleComponentSample
- (instancetype)init;
{
    self = [super initWithGroupId:SuiteSample title:NSLocalizedString(@"sample_EditMultipleComponent", @"照片美化")];
    return self;
}

/**
 *  Show Sample
 *
 *  @param controller
 */
- (void)showSampleWithController:(UIViewController *)controller;
{
    if (!controller) return;
    self.controller = controller;
    
    lsqLDebug(@"editAdvancedComponentHandler");
    
    _albumComponent =
    [TuSDKGeeV1 albumCommponentWithController:controller
                           callbackBlock:^(TuSDKResult *result, NSError *error, UIViewController *controller)
     {
         // 获取图片错误
         if (error) {
             lsqLError(@"album reader error: %@", error.userInfo);
             return;
         }
         [self openEditMultipleWithController:controller result:result];
     }];
    
    [_albumComponent showComponent];
}

/**
 *  Start Photo Editor Component
 *
 *  @param controller Source Controller
 *  @param result     Edited Result
 */
- (void)openEditMultipleWithController:(UIViewController *)controller
                                result:(TuSDKResult *)result;
{
    // 组件使用文档教程
    // @see-https://tusdk.com/docs/ios/editor-usage
    
    if (!controller || !result) return;
    
    // 组件选项配置
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKCPPhotoEditMultipleComponent.html
    _photoEditMultipleComponent =
    [TuSDKGeeV1 photoEditMultipleWithController:controller
                               callbackBlock:^(TuSDKResult *result, NSError *error, UIViewController *controller)
     {
         
         // 如果以 pushViewController 方式打开编辑器, autoDismissWhenCompelted参数将无效, 请使用以下方法关闭
         //if (_photoEditMultipleComponent.autoDismissWhenCompelted && controller) {
         //    [controller popViewControllerAnimated:YES];
         //}
         
         // Error  Information
         if (error) {
             lsqLError(@"editMultiple error: %@", error.userInfo);
             return;
         }
         [result logInfo];
         
         //
         // 可在此添加自定义方法，在编辑完成时进行页面跳转操，例如 ：
         // If _photoEditMultipleComponent.autoDismissWhenCompelted = NO
         // Use following code can jump to another controller after operation
         // [controller presentViewController:[[UIViewController alloc] init] animated:YES completion:nil];
         
         // MagicSDKResult *result contains ：
         // result.image :UIImage
         // result.imagePath :NSString
         // result.imageAsset :MagicSDKTSAssetInterface
         
         // 用户在获取到 result.image 结果并跳转到其他页面进行操作的时候可能会出现无法持有对象的情况
         // If result couldn't display on another view normally，please reference the following code:
         // NSData *imageData = UIImageJPEGRepresentation(result.image, 1.0);
         // ViewController *viewController = [[ViewController alloc]init];
         // [self.controller pushViewController:viewController animated:YES];
         // viewController.currentImage = [UIImage imageWithData:imageData];
         
         // set parameters in  `_photoEditMultipleComponent.options.editMultipleOptions` to get kinds of result
     }];
    
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKCPPhotoEditMultipleOptions.html
    // _photoEditMultipleComponent.options
    
    //    // Photo Editor Configuration
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFEditMultipleOptions.html
    // _photoEditMultipleComponent.options.editMultipleOptions
    //    // Use following code to disable module (Default: Load All Module)
    //    [_photoEditMultipleComponent.options.editMultipleOptions disableModule:lsqTuSDKCPEditActionCuter];
    //    // Set limit to the photo edit result image
    //    _photoEditMultipleComponent.options.editMultipleOptions.limitSideSize = NSUIntegerMax;
    //    // Save to Album
    //    _photoEditMultipleComponent.options.editMultipleOptions.saveToAlbum = YES;
    //    // Enable delete temp file automaticly after component close
    //    _photoEditMultipleComponent.options.editMultipleOptions.isAutoRemoveTemp = YES;
    //    // WaterMark (Default:nil)
    //    _photoEditMultipleComponent.options.editMultipleOptions.waterMarkOption = [self waterMarkOption];
    //
    //    // Filter Module Configuration
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFEditFilterOptions.html
    // _photoEditMultipleComponent.options.editFilterOptions
    //    // Enable filter parameter configuration
    //    _photoEditMultipleComponent.options.editFilterOptions.enableFilterConfig = YES;
    //    // Creat a temp file path
    //    _photoEditMultipleComponent.options.editFilterOptions.saveToTemp = YES;
    //    // Image output compression
    //    // set parameter 1，the image file type will be jpeg
    //    // set parameter 0，the image file type will be png
    //    _photoEditMultipleComponent.options.editFilterOptions.outputCompress = 0.95f;
    //    // Width of filter bar cell
    //    _photoEditMultipleComponent.options.editFilterOptions.filterBarCellWidth = 75;
    //    // Height of filterBar
    //    _photoEditMultipleComponent.options.editFilterOptions.filterBarHeight = 100;
    //    // Enable to record filter history
    //    _photoEditMultipleComponent.options.editFilterOptions.enableFilterHistory = YES;
    //    // Display the filter title view when changing the filter
    //    _photoEditMultipleComponent.options.editFilterOptions.displayFilterSubtitles = YES;
    //
    //    // Crop Module Configuration
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFEditCuterOptions.html
    // _photoEditMultipleComponent.options.editCuterOptions
    //    // Enable image rotation
    //    _photoEditMultipleComponent.options.editCuterOptions.enableTrun = YES;
    //    // Enable image horizontal rotation
    //    _photoEditMultipleComponent.options.editCuterOptions.enableMirror = YES;
    //    // Ratio type (Default:lsqRatioDefault)
    //    _photoEditMultipleComponent.options.editCuterOptions.ratioType = lsqRatioDefault;
    //    // Custom Ratio Type，if set `ratioTypeList`,`ratioType` will not work (Example：@[@(lsqRatioOrgin), @(lsqRatio_1_1), @(lsqRatio_2_3), @(lsqRatio_3_4)])
    //    _photoEditMultipleComponent.options.editCuterOptions.ratioTypeList = @[@(lsqRatioOrgin), @(lsqRatio_1_1), @(lsqRatio_2_3)];
    //    // creat a temp file path
    //    _photoEditMultipleComponent.options.editCuterOptions.saveToTemp = YES;
    //    // Image Compression
    //    _photoEditMultipleComponent.options.editCuterOptions.outputCompress = 0.95f;
    //
    //    // Sticker Module Configuration
    // _photoEditMultipleComponent.options.editStickerOptions
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFEditStickerOptions.html
    //
    //    // Adjust Module Configuration
    // _photoEditMultipleComponent.options.editAdjustOptions
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFEditAdjustOptions.html
    //
    //    // Sharpness Module Configuration
    // _photoEditMultipleComponent.options.editSharpnessOptions
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFEditSharpnessOptions.html
    //
    //    // Aperture Module Configuration
    // _photoEditMultipleComponent.options.editApertureOptions
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFEditApertureOptions.html
    //
    //    // Vignette Module Configuration
    // _photoEditMultipleComponent.options.editVignetteOptions
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFEditVignetteOptions.html
    //
    //    // Smudge Module Configuration
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFEditSmudgeOptions.html
    // _photoEditMultipleComponent.options.editSmudgeOptions
    //
    //    // Blur Module Configuration
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFEditWipeAndFilterOptions.html
    // _photoEditMultipleComponent.options.editWipeAndFilterOptions
    //
    
    //
    // Start Editor Component with three kinds of input
    //
    // UIImage
    _photoEditMultipleComponent.inputImage = result.image;
    // NSString,file path
    _photoEditMultipleComponent.inputTempFilePath = result.imagePath;
    // MagicSDKTSAssetInterface ,need Album Component
    _photoEditMultipleComponent.inputAsset = result.imageAsset;
    // set parameter to close component after operation automaticly
    _photoEditMultipleComponent.autoDismissWhenCompelted = YES;
    // 当上一个页面是NavigationController时,是否通过 pushViewController 方式打开编辑器视图 (默认：NO，默认以 presentViewController 方式打开）
    // SDK 内部组件采用了一致的界面设计，会通过 push 方式打开视图。如果用户开启了该选项，在调用时可能会遇到布局不兼容问题，请谨慎处理。
    // 这句不会翻译
    _photoEditMultipleComponent.autoPushViewController = YES;
    [_photoEditMultipleComponent showComponent];
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

@end
