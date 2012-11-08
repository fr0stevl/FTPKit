//
//  AppDelegate.h
//  picController
//
//  Created by telsafe-macpc1 on 12-11-6.
//  Copyright (c) 2012年 telsafe-macpc1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpPhotoViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UpPhotoViewController * mViewController;
}
@property (strong, nonatomic) UIWindow *window;

@end
