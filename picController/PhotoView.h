//
//  PhotoView.h
//  picController
//
//  Created by telsafe-macpc1 on 12-11-6.
//  Copyright (c) 2012年 telsafe-macpc1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoView : UIView<UIGestureRecognizerDelegate>{
    UIImage *mPhotoview;
    UIImage *mChoseView;
    //NSString * mPhotoName;
    Boolean chose;
    UIViewController* mParent;
}
-(Boolean)getChose;
-(void) setPhotoName : (UIImage*)name;
//-(NSString*) getPhotoName;
-(void)addView;
-(void)setHandle:(UIViewController*)controller;
@end
