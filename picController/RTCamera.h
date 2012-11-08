//
//  Camera.h
//  CameraTest
//
//  Created by  rtsafe02 on 12-10-30.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//
//需要引入AVFoundation.framework,AssetsLibrary.framework,CoreGraphics.framework

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "RTImage.h"

@interface RTCamera:NSObject
{
    BOOL isCamera;
    UISegmentedControl *segmentVideoQuality;
    UIImageView *PreviewView;
    NSURL *targetURL;
    UIImagePickerController *camera;
}

-(void)OpenCamera:(id) viewController PreviewView:(UIImageView *)previewView;

@end
