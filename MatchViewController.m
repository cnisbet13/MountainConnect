//
//  MatchViewController.m
//  Powdr2
//
//  Created by Calvin Nisbet on 2014-11-21.
//  Copyright (c) 2014 Calvin Nisbet. All rights reserved.
//

#import "MatchViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "CCConstants.h"
#import <Parse/Parse.h>
#import <FacebookSDK.h>
#import "TestUser.h"
#import "ProfileViewController.h"
#import "SettingsViewController.h"

@interface MatchViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *matchedUserImageView;

@property (strong, nonatomic) IBOutlet UIImageView *currentUserImageView;

@property (strong, nonatomic) IBOutlet UIButton *viewMessagesButton;

@property (strong, nonatomic) IBOutlet UIButton *keepSearchingButton;

@end

@implementation MatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PFQuery *query = [PFQuery queryWithClassName:kCCPhotoClassKey];
    [query whereKey:kCCPhotoUserKey equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] > 0) {
            PFObject *photo = objects[0];
            PFFile *pictureFile = photo[kCCPhotoPictureKey];
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                self.currentUserImageView.image = [UIImage imageWithData:data];
                self.matchedUserImageView.image = self.matchedUserImage;
            }];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - IBActions

- (IBAction)viewChatsButtonPressed:(UIButton *)sender
{
    [self.delegate presentMatchesViewController];

}


- (IBAction)keepSearchingButtonPressed:(UIButton *)sender
{

    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
