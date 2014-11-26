//
//  ProfileViewController.m
//  Powdr2
//
//  Created by Calvin Nisbet on 2014-11-19.
//  Copyright (c) 2014 Calvin Nisbet. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()


@property (strong, nonatomic) IBOutlet UIImageView *profilePictureImageView;

@property (strong, nonatomic) IBOutlet UILabel *locationLabel;

@property (strong, nonatomic) IBOutlet UILabel *ageLabel;

@property (strong, nonatomic) IBOutlet UILabel *skillLabel;

@property (strong, nonatomic) IBOutlet UILabel *taglineLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PFFile *pictureFile = self.photo[kCCPhotoPictureKey];
    [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        self.profilePictureImageView.image = [UIImage imageWithData:data];
    }];
    
    PFUser *user = self.photo[kCCPhotoUserKey];
    self.locationLabel.text = user[kCCUserProfileKey][kCCUserProfileLocationKey];
    self.ageLabel.text = [NSString stringWithFormat:@"%@", user[kCCUserProfileKey][kCCUserProfileAge]];
    self.taglineLabel.text = user[kCCUserTagLineKey];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.title = user[kCCUserProfileKey][kCCUserProfileFirstNameKey];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions


- (IBAction)likeButtonPressed:(UIButton *)sender
{
    [self.delegate didPressLike];
}


- (IBAction)dislikeButtonPressed:(UIButton *)sender
{
    [self.delegate didPressDisLike];
}


@end
