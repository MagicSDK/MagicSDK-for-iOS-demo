//
//  AlbumComponentSample.m
//  TuSDKDemo
//
//  Created by Clear Hu on 15/4/24.
//  Copyright (c) 2015年 tusdk.com. All rights reserved.
//

#import "AlbumComponentSample.h"
/**
 *  Single-Seleted Album
 */
@interface AlbumComponentSample ()
{
    // Single-Seleted Album
    TuSDKCPAlbumComponent *_albumComponent;
}
@end

@implementation AlbumComponentSample
- (instancetype)init;
{
    self = [super initWithGroupId:ComponentSample title:NSLocalizedString(@"sample_AlbumComponent", @"相册组件")];
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
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKCPAlbumComponent.html

    _albumComponent =
    [TuSDKGeeV1 albumCommponentWithController:controller
                           callbackBlock:^(TuSDKResult *result, NSError *error, UIViewController *controller)
     {
         // Error Information
         if (error) {
             lsqLError(@"album reader error: %@", error.userInfo);
             return;
         }
         
         // if (controller) [controller dismissModalViewControllerAnimated];
         [result logInfo];
     }];
    
    // Configuration
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKCPAlbumComponent.html
    // _albumComponent.options
    
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFAlbumOptions.html
    // _albumComponent.options.albumOptions
    
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFPhotosOptions.html
    // _albumComponent.options.photosOptions
    
    // set parameter to close component after operation automaticly (Default:NO)
    _albumComponent.autoDismissWhenCompelted = YES;
    
    // set parameter to limit the max seleted size of photo in Album, Default:8000*8000
    //  _albumComponent.options.photosOptions.maxSelectionImageSize  = CGSizeMake(8000, 8000);

    
    [_albumComponent showComponent];
}
@end
