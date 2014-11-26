//
//  CCHomeViewController.m
//  Powdr2
//
//  Created by Calvin Nisbet on 2014-11-19.
//  Copyright (c) 2014 Calvin Nisbet. All rights reserved.
//

#import "CCHomeViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "CCConstants.h"
#import <Parse/Parse.h>
#import <FacebookSDK.h>
#import "TestUser.h"
#import "ProfileViewController.h"
#import "SettingsViewController.h"
#import "MatchViewController.h"

@interface CCHomeViewController () <MatchViewControllerDelegate, ProfileViewControllerDelegate>


@property (strong, nonatomic) IBOutlet UIView *buttonContainerView;

@property (strong, nonatomic) IBOutlet UIView *labelContainerView;



@property (strong, nonatomic) IBOutlet UIBarButtonItem *chatBarButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *settingsBarButtonItem;
@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UIButton *dislikeButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;

@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) PFObject *photo;
@property (strong, nonatomic) NSMutableArray *activities;

@property (nonatomic) int currentPhotoIndex;
@property (nonatomic) BOOL isLikedByCurrentUser;
@property (nonatomic) BOOL isDislikedByCurrentUser;

@end


@implementation CCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //[TestUser saveTestUserToParse];
    
    self.likeButton.enabled = NO;
    self.dislikeButton.enabled = NO;
    self.infoButton.enabled = NO;
    self.currentPhotoIndex = 0;
    
    PFQuery *query = [PFQuery queryWithClassName:kCCPhotoClassKey];
    [query whereKey:kCCPhotoUserKey notEqualTo:[PFUser currentUser]];
    [query includeKey:kCCPhotoUserKey];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            self.photos = objects;
            [self queryForCurrentPhotoIndex];
        } else {
            //Could write an alertview for the error, instead.
            NSLog(@"%@", error);
        }
    }];
    
    [self setupViews];
    
}


-(void)setupViews
{
    [self addShadowForView:self.buttonContainerView];
    [self addShadowForView:self.labelContainerView];
    self.photoImageView.layer.masksToBounds = YES;
}

-(void)addShadowForView:(UIView *)view
{
    view.layer.masksToBounds = NO;
    view.layer.cornerRadius = 4;
    view.layer.shadowRadius = 1;
    view.layer.shadowOffset = CGSizeMake(0,1);
    view.layer.shadowOpacity = 1.0;
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if([segue.identifier isEqualToString:@"homeToProfileSegue"]){

        ProfileViewController *profileVC = segue.destinationViewController;
        profileVC.photo = self.photo;
        profileVC.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"homeToMatchSegue"]){
        MatchViewController *matchVC = segue.destinationViewController;
        matchVC.matchedUserImage = self.photoImageView.image;
        matchVC.delegate = self;
    }
 
}


#pragma mark - IBActions

- (IBAction)dislikeButtonPressed:(UIButton *)sender {

    [self checkDislike];
    
}


- (IBAction)likeButtonPressed:(UIButton *)sender {

    [self checkLike];
}


- (IBAction)infoButtonPressed:(UIButton *)sender {

    [self performSegueWithIdentifier:@"homeToProfileSegue" sender:nil];
}



//- (IBAction)settingsBarButtonItemPressed:(UIBarButtonItem *)sender {
// //  [self performSegueWithIdentifier:@"homeToSettingsSegue" sender:nil];
//    
//}

- (IBAction)chatBarButtonItemPressed:(UIBarButtonItem *)sender {
    
    
}

#pragma mark - Helper Methods

- (void)queryForCurrentPhotoIndex
{

    if ([self.photos count] > 0) {
        self.photo = self.photos[self.currentPhotoIndex];
        PFFile *file = self.photo[kCCPhotoPictureKey];
        [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            self.photoImageView.image = image;
                [self updateView];
            }
            else NSLog(@"%@", error);
        }];
        
        //Query for Likes
        PFQuery *queryForLike = [PFQuery queryWithClassName:kCCActivityClassKey];
        [queryForLike whereKey:kCCActivityTypeKey equalTo:kCCActivityTypeLikeKey];
        [queryForLike whereKey:kCCActivityPhotoKey equalTo:self.photo];
        [queryForLike whereKey:kCCActivityFromUserKey equalTo:[PFUser currentUser]];
        
        //Query for Dislikes
        
        PFQuery *queryForDislike = [PFQuery queryWithClassName:kCCActivityClassKey];
        [queryForDislike whereKey:kCCActivityTypeKey equalTo:kCCActivityTypeDislikeKey];
        [queryForDislike whereKey:kCCActivityPhotoKey equalTo:self.photo];
        [queryForDislike whereKey:kCCActivityFromUserKey equalTo:[PFUser currentUser]];
        
        //Joining Queries
        
        PFQuery *likeAndDislikeQuery = [PFQuery orQueryWithSubqueries:@[queryForLike, queryForDislike]];
         [likeAndDislikeQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
             if (!error) {
                 self.activities = [objects mutableCopy];
                 if ([self.activities count] == 0) {
                     self.isLikedByCurrentUser = NO;
                     self.isDislikedByCurrentUser = NO;
                 } else {
                     PFObject *activity = self.activities[0];
                     if ([activity[kCCActivityTypeKey] isEqualToString:kCCActivityTypeLikeKey]) {
                         self.isLikedByCurrentUser = YES;
                         self.isDislikedByCurrentUser = NO;
                     }
                     else if ([activity[kCCActivityTypeKey] isEqualToString:kCCActivityTypeDislikeKey]) {
                         self.isLikedByCurrentUser = NO;
                         self.isDislikedByCurrentUser = YES;
                     } else {
                      //some other activity - nothing really to define at the moment.
                     
                     }
                 }
                 self.likeButton.enabled = YES;
                 self.dislikeButton.enabled = YES;
                 self.infoButton.enabled = YES;
             }
             }];
    }
}





-(void) updateView
{
    self.firstNameLabel.text = self.photo[kCCPhotoUserKey][kCCUserProfileKey][kCCUserProfileFirstNameKey];
    self.ageLabel.text = [NSString stringWithFormat:@"%@", self.photo[kCCPhotoUserKey][kCCUserProfileKey][kCCUserProfileAge]];
    self.locationLabel.text = self.photo[kCCPhotoUserKey][kCCUserProfileKey][kCCUserProfileLocationKey];
}

-(void)setupNextPhoto
{
    if (self.currentPhotoIndex + 1 <self.photos.count)  {
        self.currentPhotoIndex ++;
        if ([self allowPhoto]) {
            [self setupNextPhoto];
        }
        [self queryForCurrentPhotoIndex];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No More Users to View" message:@"Check Back Later" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    
}


-(BOOL)allowPhoto
{
    int maxAge = [[NSUserDefaults standardUserDefaults] integerForKey:kCCAgeMaxKey];
    BOOL men = [[NSUserDefaults standardUserDefaults] boolForKey:kCCMenEnabledKey];
    BOOL women = [[NSUserDefaults standardUserDefaults] boolForKey:kCCWomenEnabledKey];
    
    PFObject *photo = self.photos[self.currentPhotoIndex];
    PFUser *user = photo[kCCPhotoUserKey];
    
    int userAge = [user[kCCUserProfileKey][kCCUserProfileAge] intValue];
    NSString *gender = user[kCCUserProfileKey][kCCUserProfileGenderKey];
    
    
    if (userAge > maxAge) {
        return NO;
    }
    else if (men == NO && [gender isEqualToString:@"male"]){
    return NO;
    }
    else if (women == NO && [gender isEqualToString:@"female"]) {
        return NO;
    }
    else {
        return YES;
    }
}

- (void)saveLike {
    PFObject *likeActivity = [PFObject objectWithClassName:kCCActivityClassKey];
    [likeActivity setObject:kCCActivityTypeLikeKey forKey:kCCActivityTypeKey];
    [likeActivity setObject:[PFUser currentUser] forKey:kCCActivityFromUserKey];
    [likeActivity setObject:[self.photo objectForKey:kCCPhotoUserKey] forKey:kCCActivityToUserKey];
    [likeActivity setObject:self.photo forKey:kCCActivityPhotoKey];
    [likeActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        self.isLikedByCurrentUser = YES;
        self.isDislikedByCurrentUser = NO;
        [self.activities addObject:likeActivity];
        [self checkForUserPhotoLikes];
        [self setupNextPhoto];
    }];
}

-(void)saveDislike {
    PFObject *dislikeActivity = [PFObject objectWithClassName:kCCActivityClassKey];
    [dislikeActivity setObject:kCCActivityTypeDislikeKey forKey:kCCActivityTypeKey];
    [dislikeActivity setObject:[PFUser currentUser] forKey:kCCActivityFromUserKey];
    [dislikeActivity setObject:[self.photo objectForKey:kCCPhotoUserKey] forKey:kCCActivityToUserKey];
    [dislikeActivity setObject:self.photo forKey:kCCActivityPhotoKey];
    [dislikeActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        self.isLikedByCurrentUser = NO;
        self.isDislikedByCurrentUser = YES;
        [self.activities addObject:dislikeActivity];
        [self setupNextPhoto];
        
    }];
}


-(void)checkLike {


    if (self.isLikedByCurrentUser) {
        [self setupNextPhoto];
        [self saveLike];
    } else if (self.isDislikedByCurrentUser){
        for (PFObject *activity in self.activities) {
            [activity deleteInBackground];
        }
        [self.activities removeLastObject];
    }
}


-(void)checkDislike {


    if (self.isDislikedByCurrentUser) {
        [self setupNextPhoto];
     return;
    } else if (self.isLikedByCurrentUser) {
    
        for (PFObject *activity in self.activities) {
            [activity deleteInBackground];
        }
        [self.activities removeLastObject];
        [self saveDislike];
    } else {
        [self saveDislike];
    }
    
    
}

-(void)checkForUserPhotoLikes
{
    PFQuery *query = [PFQuery queryWithClassName:kCCActivityClassKey];
    [query whereKey:kCCActivityFromUserKey equalTo:self.photo[kCCPhotoUserKey]];
    [query whereKey:kCCActivityToUserKey equalTo:[PFUser currentUser]];
    [query whereKey:kCCActivityTypeKey equalTo:kCCActivityTypeLikeKey];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] > 0) {
            [self createChatRoom];
        }else{
            NSLog(@"in else");
        }
    }];
}

-(void)createChatRoom
{
    PFQuery *queryForChatRoom = [PFQuery queryWithClassName:@"ChatRoom"];
    [queryForChatRoom whereKey:@"user1" equalTo:[PFUser currentUser]];
    [queryForChatRoom whereKey:@"user2" equalTo:self.photo[kCCPhotoUserKey]];
    
    PFQuery *queryForChatRoomInverse = [PFQuery queryWithClassName:@"ChatRoom"];
    [queryForChatRoomInverse whereKey:@"user1" equalTo:self.photo[kCCPhotoUserKey]];
    [queryForChatRoomInverse whereKey:@"user2" equalTo:[PFUser currentUser]];
    
    PFQuery *combinedQuery = [PFQuery orQueryWithSubqueries:@[queryForChatRoomInverse, queryForChatRoom]];
    [combinedQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] == 0) {
            PFObject *chatroom = [PFObject objectWithClassName:@"ChatRoom"];
            [chatroom setObject:[PFUser currentUser] forKey:@"user1"];
            [chatroom setObject:self.photo[kCCPhotoUserKey] forKey:@"user2"];
            [chatroom saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [self performSegueWithIdentifier:@"homeToMatchSegue" sender:nil];
            }];
        }
    }];
}


#pragma mark - MatchViewController Delegate

-(void)presentMatchesViewController
{
    [self dismissViewControllerAnimated:NO completion:^{
        [self performSegueWithIdentifier:@"homeToMatchesSegue" sender:nil];
    }];
}


#pragma mark - ProfileView Controller Delegate

-(void)didPressLike
{
    [self.navigationController popViewControllerAnimated:NO];
    [self checkLike];
}

-(void)didPressDisLike
{
    [self.navigationController popViewControllerAnimated:NO];
    [self checkDislike];
}



@end