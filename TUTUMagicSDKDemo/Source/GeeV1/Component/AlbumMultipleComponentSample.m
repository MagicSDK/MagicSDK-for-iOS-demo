//
//  AlbumMultipleComponentSample.m
//  TuSDKDemo
//
//  Created by Clear Hu on 15/4/24.
//  Copyright (c) 2015年 Lasque. All rights reserved.
//

#import "AlbumMultipleComponentSample.h"
/**
 *  Muti-Seleted Album
 */
@interface AlbumMultipleComponentSample ()
{
    // Muti-Seleted Album
    TuSDKCPAlbumMultipleComponent *_albumComponent;
}
@end

@implementation AlbumMultipleComponentSample
- (instancetype)init;
{
    self = [super initWithGroupId:ComponentSample title:NSLocalizedString(@"sample_AlbumMultipleComponent", @"多选相册组件")];
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

    lsqLDebug(@"albumComponentHandler");

    // Sample API Doc
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKCPAlbumMultipleComponent.html

    _albumComponent =
    [TuSDKGeeV1 albumMultipleCommponentWithController:controller
                           callbackBlock:^(TuSDKResult *result, NSError *error, UIViewController *controller)
     {
         // Error Information
         if (error) {
             lsqLError(@"album reader error: %@", error.userInfo);
             return;
         }
         
         // if (controller) [controller dismissModalViewControllerAnimated];
         [result logInfo];
     }
     maxSelectionNumber:9];
    
    // Configuration
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKCPAlbumMultipleOptions.html
    // _albumComponent.options
    
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFAlbumMultipleOptions.html
    // _albumComponent.options.albumOptions
    
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFCameraOptions.html
    // _albumComponent.options.cameraOptions
    
    // set parameter to close component after operation automaticly (Default:NO)
    _albumComponent.autoDismissWhenCompelted = YES;
    
    // set sortord of photo in Album（only support Multi-select Album and iOS 8 higher）
    // _albumComponent.options.albumOptions.photosSortKeyType = lsqAssetSortKeyCreateDate;
    
    // set parameter to limit the max seleted size of photo in Album, Default:8000*8000
    // _albumComponent.options.albumOptions.maxSelectionImageSize  = CGSizeMake(8000, 8000);
    
    [_albumComponent showComponent];
}
@end
