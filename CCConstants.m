//
//  CCConstants.m
//  Powdr2
//
//  Created by Calvin Nisbet on 2014-11-18.
//  Copyright (c) 2014 Calvin Nisbet. All rights reserved.
//

#import "CCConstants.h"

@implementation CCConstants


#pragma mark - User Class

NSString *const kCCUserTagLineKey               = @"tagLine";

NSString *const kCCUserProfileKey               = @"profile";
NSString *const kCCUserProfileNameKey           = @"name";
NSString *const kCCUserProfileFirstNameKey      = @"firstName";
NSString *const kCCUserProfileLocationKey       = @"location";
NSString *const kCCUserProfileGenderKey         = @"gender";
NSString *const kCCUserProfileBirthdayKey       = @"birthday";
NSString *const kCCUserProfileInterestedInKey   = @"interestedIn";
NSString *const kCCUserProfilePictureURL        = @"pictureURL";
NSString *const kCCUserProfileAge               = @"age";

#pragma mark - Photo Class

NSString *const kCCPhotoUserKey                 = @"user";
NSString *const kCCPhotoClassKey                = @"Photo";
NSString *const kCCPhotoPictureKey              = @"image";


#pragma mark - Setings

NSString *const kCCMenEnabledKey                = @"men";
NSString *const kCCWomenEnabledKey              = @"women";
NSString *const kCCAgeMaxKey                    = @"agemax";
//Need to add constants for: 

#pragma mark - Activity Class

NSString *const kCCActivityClassKey             = @"Activity";
NSString *const kCCActivityTypeKey              = @"type";
NSString *const kCCActivityFromUserKey          = @"fromUser";
NSString *const kCCActivityToUserKey            = @"toUser";
NSString *const kCCActivityPhotoKey             = @"photo";
NSString *const kCCActivityTypeLikeKey          = @"like";
NSString *const kCCActivityTypeDislikeKey       = @"dislike";



@end
