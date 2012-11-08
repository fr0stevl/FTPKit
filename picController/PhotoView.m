//
//  PhotoView.m
//  picController
//
//  Created by telsafe-macpc1 on 12-11-6.
//  Copyright (c) 2012年 telsafe-macpc1. All rights reserved.
//

#import "PhotoView.h"
#import "UpPhotoViewController.h"

@implementation PhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        chose = NO;
        UITapGestureRecognizer *aclick=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(action:)];
        [aclick setNumberOfTapsRequired:1];
        [self addGestureRecognizer:aclick];
        mChoseView = [UIImage imageNamed:@"right.png"];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    //mPhotoview = [UIImage imageNamed:mPhotoName];
    [mPhotoview drawInRect:CGRectMake(0, 0, 256*mPhotoview.size.width/mPhotoview.size.height, 256)];
    if (chose == YES) {
        [mChoseView drawInRect:CGRectMake(0, 0, 50, 50)];
    }
}

-(void)setHandle:(UIViewController*)controller{
    mParent = controller;
}

- (void)action:(UITapGestureRecognizer *)sender {
    if (chose == YES) {
        chose = NO;
        [(UpPhotoViewController*)mParent setRemovePhotoName:mPhotoview];
    }else{
        chose = YES;
        [(UpPhotoViewController*)mParent setAddPhotoName:mPhotoview];
    }
    [self addView];
}

-(Boolean)getChose{
    return chose;
}

-(void) setPhotoName : (UIImage*)name{
    mPhotoview = name;
}

//-(NSString*) getPhotoName{
//    return mPhotoName;
//}

-(void)addView{
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
