//
//  ChatViewController.h
//  Powdr2
//
//  Created by Calvin Nisbet on 2014-11-25.
//  Copyright (c) 2014 Calvin Nisbet. All rights reserved.
//

#import "JSMessagesViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "CCConstants.h"
#import <Parse/Parse.h>
#import <FacebookSDK.h>
#import "TestUser.h"
#import "ProfileViewController.h"
#import "SettingsViewController.h"
#import "MatchViewController.h"

@interface ChatViewController : JSMessagesViewController<JSMessagesViewDataSource, JSMessagesViewDelegate>

@property (strong, nonatomic) PFObject *chatRoom;

@end
