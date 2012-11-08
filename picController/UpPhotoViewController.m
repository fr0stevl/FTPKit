//
//  UpPhotoViewController.m
//  picController
//
//  Created by telsafe-macpc1 on 12-11-6.
//  Copyright (c) 2012年 telsafe-macpc1. All rights reserved.
//

#import "UpPhotoViewController.h"
#import "PhotoView.h"
@interface UpPhotoViewController ()

@end

@implementation UpPhotoViewController
@synthesize mScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       // self.view.backgroundColor = [UIColor underPageBackgroundColor];
        mPhotoArray = [[NSMutableArray alloc]initWithObjects: nil];
        mChosePhotoArray = [[NSMutableArray alloc]initWithObjects: nil];
        targetURL = [[NSURL alloc]init];
        camera = [[RTCamera alloc] init];
        ImagePreview = [[UIImageView alloc]init];
        //mNavigation = [[UINavigationController alloc]initWithRootViewController:mCameraViewController];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    number = 0;
    x = 0;
    // Do any additional setup after loading the view from its nib.
   
}

-(void)addView{
    
    if (x > self.mScrollView.contentSize.width) {
        [self.mScrollView setContentSize:CGSizeMake(self.mScrollView.contentSize.width+1024, 256)];
    }
    UIImage *image = [mPhotoArray objectAtIndex:number];
    PhotoView *aview = [[PhotoView alloc]autorelease];
    [aview setPhotoName:[mPhotoArray objectAtIndex:number]];
    [aview setHandle:self];
    [aview initWithFrame:CGRectMake(x, 0,  256*image.size.width/image.size.height, 256)];
    x = x + 256*image.size.width/image.size.height +5;
    [mScrollView addSubview:aview];
    number++;
   // [mScrollView reloadInputViews];
}

-(void)setRemovePhotoName : (UIImage*)name{
    [mChosePhotoArray removeObject:name];
}

-(void)setAddPhotoName : (UIImage*)name{
    [mChosePhotoArray addObject:name];
}

-(IBAction)UpPhotoaction:(id)sender{
    NSLog(@"mChosePhotoArray %@  mChosePhotoArray.count %d",mChosePhotoArray,mChosePhotoArray.count);
    for (int i = 0; i<mChosePhotoArray.count; i++) {
//        if (targetURL == NULL) {
        NSData *dataImg = UIImagePNGRepresentation([mChosePhotoArray objectAtIndex:i]);
         //   NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
        NSString *imageName = [[NSString alloc] initWithString:(NSString*)[self timeStampAsString]];
        [self sendFileByData:dataImg fileName:imageName];
        NSLog(@"imageName %@",imageName);
//        }else{
//            [self sendFileByPath:targetURL];
//        }
    }
}

-(void)sendFileByPath:(NSURL *)filePath
{
	NSLog(@"sendFileByPath Func");
    [self ftpSetting];
	[FTPHelper upload:filePath];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
	//[picker dismissModalViewControllerAnimated:YES];
    
    //NSLog(@"info = %@",info);
    
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
	
	if([mediaType isEqualToString:@"public.movie"])			//被选中的是视频
	{
		NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
		targetURL = url;		//视频的储存路径
		
		if (isCamera)
		{
			//保存视频到相册
			ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
			[library writeVideoAtPathToSavedPhotosAlbum:url completionBlock:nil];
		}
		
		//获取视频的某一帧作为预览
        [self getPreViewImg:url];
	}
	else if([mediaType isEqualToString:@"public.image"])	//被选中的是图片
	{
        //获取照片实例
		UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
		
        //        NSString *fileName = [[NSString alloc] init];
        //
        //        if ([info objectForKey:UIImagePickerControllerReferenceURL]) {
        //            fileName = [[info objectForKey:UIImagePickerControllerReferenceURL] absoluteString];
        //            //ReferenceURL的类型为NSURL 无法直接使用  必须用absoluteString 转换，照相机返回的没有UIImagePickerControllerReferenceURL，会报错
        //            fileName = [self getFileName:fileName];
        //        }
        //        else
        //        {
        //            fileName = [self timeStampAsString];
        //        }
        //
        //        NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
        //
        //        [myDefault setValue:fileName forKey:@"fileName"];
		if (isCamera) //判定，避免重复保存
		{
			//保存到相册
			ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
			[library writeImageToSavedPhotosAlbum:[image CGImage]
									  orientation:(ALAssetOrientation)[image imageOrientation]
								  completionBlock:nil];
		}
		
		[self performSelector:@selector(saveImg:) withObject:image afterDelay:0.0];
	}
	else
	{
		NSLog(@"Error media type");
		return;
	}
	isCamera = FALSE;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	NSLog(@"Cancle it");
	isCamera = FALSE;
	//[picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

-(void)getPreViewImg:(NSURL *)url
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    [self performSelector:@selector(saveImg:) withObject:img afterDelay:0.1];
}

-(NSString *)timeStampAsString
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"EEE-MMM-dd-hh-mm-ss"];
    NSString *locationString = [@"RT" stringByAppendingString:[df stringFromDate:nowDate]];
    return [locationString stringByAppendingFormat:@".png"];
}

-(void)saveImg:(UIImage *) image
{
	NSLog(@"Review Image");
	//ImagePreview.image = image;
    
    UIImage *theImage = [RTImage ImageWithImageSimple:image scaledToSize:CGSizeMake(image.size.width*0.2, image.size.height*0.2)];
    //    UIImage *midImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(210.0, 210.0)];
    UIImage *bigImage = [RTImage ImageWithImageSimple:image scaledToSize:image.size];
    
    [RTImage SaveImage:theImage WithName:[self timeStampAsString]];
    //    [self saveImage:midImage WithName:@"salesImageMid.jpg"];
    [RTImage SaveImage:bigImage WithName:[@"Big" stringByAppendingString:[self timeStampAsString]]];
    [mPhotoArray addObject:image];
    NSLog(@"mPhotoArray %@",mPhotoArray);
    [self addView];
}

-(IBAction)Photoaction:(id)sender{
  // [self presentModalViewController:mNavigation animated:YES];
    [camera OpenCamera:self PreviewView:ImagePreview];
}

-(void)ftpSetting
{
    [FTPHelper sharedInstance].delegate = self;
	
	//最好改用Preference Setting
	[FTPHelper sharedInstance].uname = @"admin";
	[FTPHelper sharedInstance].pword = @"Abcd1234";
	[FTPHelper sharedInstance].urlString = @"ftp://192.168.1.218:21";

}

-(void)sendFileByData:(NSData *)fileData fileName:(NSString *)name{
    [self ftpSetting];
	[FTPHelper uploadByData:fileData fileName:name];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return ((interfaceOrientation ==UIDeviceOrientationLandscapeLeft)||(interfaceOrientation ==UIDeviceOrientationLandscapeRight));
}

-(void)dealloc{
    [ImagePreview release];
    [targetURL release];
    [mPhotoArray release];
    [mChosePhotoArray release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
