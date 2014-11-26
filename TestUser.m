//
//  TestUser.m
//  Powdr2
//
//  Created by Calvin Nisbet on 2014-11-20.
//  Copyright (c) 2014 Calvin Nisbet. All rights reserved.
//

#import "TestUser.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "CCConstants.h"
#import <Parse/Parse.h>
#import <FacebookSDK.h>

@implementation TestUser

+ (void)saveTestUserToParse
{
    
    PFUser *newUser = [PFUser user];
    newUser.username = @"ricky";
    newUser.password = @"rickross";
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
        NSDictionary *profile = @{@"age" : @28, @"birthday" : @"12/22/1985", @"firstName" : @"Ricky", @"gender" : @"male", @"location" : @"Whistler, British Columbia", @"name" : @"Ricky Cross"};
            [newUser setObject:profile forKey:@"profile"];
            [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                UIImage *profileImage = [UIImage imageNamed:@"pic.jpg"];
                NSData *imageData = UIImageJPEGRepresentation(profileImage, 0.8);
                PFFile *photoFile = [PFFile fileWithData:imageData];
                [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        PFObject *photo = [PFObject objectWithClassName:kCCPhotoClassKey];
                        [photo setObject:newUser forKey:kCCPhotoUserKey];
                        [photo setObject:photoFile forKey:kCCPhotoPictureKey];
                        [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            NSLog(@"Photo Saved Successfully!");
                        }];
                    }
                }];
            }];
        }
    }];
    
    
    PFUser *newUser1 = [PFUser user];
    newUser1.username = @"sarah";
    newUser1.password = @"sarah12";
    
    [newUser1 signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSDictionary *profile = @{@"age" : @22, @"birthday" : @"12/22/1991", @"firstName" : @"Sarah", @"gender" : @"female", @"location" : @"Colorado Springs, Colorado", @"name" : @"Sarah Murphy"};
            [newUser1 setObject:profile forKey:@"profile"];
            [newUser1 saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                UIImage *profileImage = [UIImage imageNamed:@"pic2.jpg"];
                NSData *imageData = UIImageJPEGRepresentation(profileImage, 0.8);
                PFFile *photoFile = [PFFile fileWithData:imageData];
                [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        PFObject *photo = [PFObject objectWithClassName:kCCPhotoClassKey];
                        [photo setObject:newUser1 forKey:kCCPhotoUserKey];
                        [photo setObject:photoFile forKey:kCCPhotoPictureKey];
                        [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            NSLog(@"Photo Saved Successfully!");
                        }];
                    }
                }];
            }];
        }
    }];
    
    
    PFUser *newUser2 = [PFUser user];
    newUser2.username = @"megan";
    newUser2.password = @"megan12";
    
    [newUser2 signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSDictionary *profile = @{@"age" : @26, @"birthday" : @"12/12/1987", @"firstName" : @"Megan", @"gender" : @"female", @"location" : @"Mont Tremblant, Quebec", @"name" : @"Megan Something"};
            [newUser2 setObject:profile forKey:@"profile"];
            [newUser2 saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                UIImage *profileImage = [UIImage imageNamed:@"DSCF0136.jpeg"];
                NSData *imageData = UIImageJPEGRepresentation(profileImage, 0.8);
                PFFile *photoFile = [PFFile fileWithData:imageData];
                [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        PFObject *photo = [PFObject objectWithClassName:kCCPhotoClassKey];
                        [photo setObject:newUser2 forKey:kCCPhotoUserKey];
                        [photo setObject:photoFile forKey:kCCPhotoPictureKey];
                        [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            NSLog(@"Photo Saved Successfully!");
                        }];
                    }
                }];
            }];
        }
    }];
    
    PFUser *newUser3 = [PFUser user];
    newUser3.username = @"mike";
    newUser3.password = @"mike12";
    
    [newUser3 signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSDictionary *profile = @{@"age" : @25, @"birthday" : @"12/22/1988", @"firstName" : @"Mike", @"gender" : @"male", @"location" : @"Blue Mountain, Ontario", @"name" : @"Mike Brown"};
            [newUser3 setObject:profile forKey:@"profile"];
            [newUser3 saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                UIImage *profileImage = [UIImage imageNamed:@"DSC_0557.jpg"];
                NSData *imageData = UIImageJPEGRepresentation(profileImage, 0.8);
                PFFile *photoFile = [PFFile fileWithData:imageData];
                [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        PFObject *photo = [PFObject objectWithClassName:kCCPhotoClassKey];
                        [photo setObject:newUser3 forKey:kCCPhotoUserKey];
                        [photo setObject:photoFile forKey:kCCPhotoPictureKey];
                        [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            NSLog(@"Photo Saved Successfully!");
                        }];
                    }
                }];
            }];
        }
    }];
    
    
    
    
    
}


@end
