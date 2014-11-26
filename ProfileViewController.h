//
//  ProfileViewController.h
//  Powdr2
//
//  Created by Calvin Nisbet on 2014-11-19.
//  Copyright (c) 2014 Calvin Nisbet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <FacebookSDK/FacebookSDK.h>
#import "CCConstants.h"
#import <Parse/Parse.h>


@protocol ProfileViewControllerDelegate <NSObject>

-(void)didPressLike;
-(void)didPressDisLike;

@end

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) PFObject *photo;
@property (weak, nonatomic) id <ProfileViewControllerDelegate> delegate;

@end
