//
//  UpPhotoViewController.h
//  picController
//
//  Created by telsafe-macpc1 on 12-11-6.
//  Copyright (c) 2012年 telsafe-macpc1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTPHelper.h"
#import "RTCamera.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface UpPhotoViewController : UIViewController<UIScrollViewDelegate,FTPHelperDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIScrollView *mScrollView;
    UIButton *mUpButton;
    NSMutableArray * mPhotoArray;
    NSMutableArray * mChosePhotoArray;
    NSURL *targetURL;
    RTCamera *camera;
    UIImageView * ImagePreview;
    BOOL isCamera;
    int number;
    int x ;
   // UINavigationController * mNavigation;
}
@property(nonatomic,retain)IBOutlet UIScrollView *mScrollView;
-(IBAction)UpPhotoaction:(id)sender;
-(IBAction)Photoaction:(id)sender;
-(void)setRemovePhotoName : (UIImage*)name;
-(void)setAddPhotoName : (UIImage*)name;
-(void)sendFileByPath:(NSURL *)filePath;
-(void)sendFileByData:(NSData *)fileData fileName:(NSString *)name;
-(void)ftpSetting;
@end
