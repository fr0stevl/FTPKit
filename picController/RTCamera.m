//
//  Camera.m
//  CameraTest
//
//  Created by  rtsafe02 on 12-10-30.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import "RTCamera.h"

@implementation RTCamera



-(void)OpenCamera:(id) viewController PreviewView:(UIImageView *)previewView;
{
    PreviewView = previewView;
    camera = [[UIImagePickerController alloc] init];
	camera.delegate = viewController;
	camera.allowsEditing = YES;
	isCamera = TRUE;
	
	//检查摄像头是否支持摄像机模式
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		camera.sourceType = UIImagePickerControllerSourceTypeCamera;
		camera.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
	}
	else
	{
		NSLog(@"Camera not exist");
		return;
	}
	
    //仅对视频拍摄有效
	switch (segmentVideoQuality.selectedSegmentIndex) {
		case 0:
			camera.videoQuality = UIImagePickerControllerQualityTypeHigh;
			break;
		case 1:
			camera.videoQuality = UIImagePickerControllerQualityType640x480;
			break;
		case 2:
			camera.videoQuality = UIImagePickerControllerQualityTypeMedium;
			break;
		case 3:
			camera.videoQuality = UIImagePickerControllerQualityTypeLow;
			break;
		default:
			camera.videoQuality = UIImagePickerControllerQualityTypeMedium;
			break;
	}
	[viewController presentViewController:camera animated:YES completion:^{}];
    //[viewController presentModalViewController:camera animated:YES];
}

#pragma mark - 使用样例
//#pragma mark ImagePickerControllerDelegate
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [picker dismissViewControllerAnimated:YES completion:^{}];
//
//	//[picker dismissModalViewControllerAnimated:YES];
//    
//    //NSLog(@"info = %@",info);
//    
//	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
//	
//	if([mediaType isEqualToString:@"public.movie"])			//被选中的是视频
//	{
//		NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
//		targetURL = url;		//视频的储存路径
//		
//		if (isCamera)
//		{
//			//保存视频到相册
//			ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//			[library writeVideoAtPathToSavedPhotosAlbum:url completionBlock:nil];
//		}
//		
//		//获取视频的某一帧作为预览
//        [self getPreViewImg:url];
//	}
//	else if([mediaType isEqualToString:@"public.image"])	//被选中的是图片
//	{
//        //获取照片实例
//		UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//		
////        NSString *fileName = [[NSString alloc] init];
////        
////        if ([info objectForKey:UIImagePickerControllerReferenceURL]) {
////            fileName = [[info objectForKey:UIImagePickerControllerReferenceURL] absoluteString];
////            //ReferenceURL的类型为NSURL 无法直接使用  必须用absoluteString 转换，照相机返回的没有UIImagePickerControllerReferenceURL，会报错
////            fileName = [self getFileName:fileName];
////        }
////        else
////        {
////            fileName = [self timeStampAsString];
////        }
////		
////        NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
////        
////        [myDefault setValue:fileName forKey:@"fileName"];
//		if (isCamera) //判定，避免重复保存
//		{
//			//保存到相册
//			ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//			[library writeImageToSavedPhotosAlbum:[image CGImage]
//									  orientation:(ALAssetOrientation)[image imageOrientation]
//								  completionBlock:nil];
//		}
//		
//		[self performSelector:@selector(saveImg:) withObject:image afterDelay:0.0];
//	}
//	else
//	{
//		NSLog(@"Error media type");
//		return;
//	}
//	isCamera = FALSE;
//}
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//	NSLog(@"Cancle it");
//	isCamera = FALSE;
//	//[picker dismissModalViewControllerAnimated:YES];
//    [picker dismissViewControllerAnimated:YES completion:^{}];
//}

//-(NSString *)timeStampAsString
//{
//    NSDate *nowDate = [NSDate date];
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"EEE-MMM-d"];
//    NSString *locationString = [df stringFromDate:nowDate];
//    return [locationString stringByAppendingFormat:@".png"];
//}

//-(void)getPreViewImg:(NSURL *)url
//{
//    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
//    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
//    gen.appliesPreferredTrackTransform = YES;
//    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
//    NSError *error = nil;
//    CMTime actualTime;
//    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
//    UIImage *img = [[UIImage alloc] initWithCGImage:image];
//    CGImageRelease(image);
//    [self performSelector:@selector(saveImg:) withObject:img afterDelay:0.1];
//}

//-(NSString *)getFileName:(NSString *)fileName
//{
//	NSArray *temp = [fileName componentsSeparatedByString:@"&ext="];
//	NSString *suffix = [temp lastObject];
//	
//	temp = [[temp objectAtIndex:0] componentsSeparatedByString:@"?id="];
//	
//	NSString *name = [temp lastObject];
//	
//	name = [name stringByAppendingFormat:@".%@",suffix];
//	return name;
//}

//-(void)saveImg:(UIImage *) image
//{
//	NSLog(@"Review Image");
//	PreviewView.image = image;
//    
//    UIImage *theImage = [RTImage ImageWithImageSimple:image scaledToSize:CGSizeMake(image.size.width*0.2, image.size.height*0.2)];
////    UIImage *midImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(210.0, 210.0)];
//    UIImage *bigImage = [RTImage ImageWithImageSimple:image scaledToSize:image.size];
//
//    [RTImage SaveImage:theImage WithName:@"salesImageSmall.jpg"];
////    [self saveImage:midImage WithName:@"salesImageMid.jpg"];
//    [RTImage SaveImage:bigImage WithName:@"salesImageBig.jpg"];
//}


//压缩图片



@end
