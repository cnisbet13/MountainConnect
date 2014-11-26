//
//  SettingsViewController.m
//  Powdr2
//
//  Created by Calvin Nisbet on 2014-11-19.
//  Copyright (c) 2014 Calvin Nisbet. All rights reserved.
//

#import "SettingsViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <FacebookSDK/FacebookSDK.h>
#import "CCConstants.h"
#import <Parse/Parse.h>
#import "CCHomeViewController.h"

@interface SettingsViewController ()

@property (strong, nonatomic) IBOutlet UISlider *ageSlider;
@property (strong, nonatomic) IBOutlet UISlider *skillSlider;

@property (strong, nonatomic) IBOutlet UISwitch *maleSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *femaleSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *snowboarderSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *skierSwitch;

@property (strong, nonatomic) IBOutlet UIButton *editProfileButton;
@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;

@end


@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.ageSlider.value = [[NSUserDefaults standardUserDefaults] integerForKey:kCCAgeMaxKey];
    self.maleSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kCCMenEnabledKey];
    self.femaleSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kCCWomenEnabledKey];
    //self.snowboarderSwitch.on
    //self.skierSwitch.on = [NSUserDefaults standardUserDefaults]
    
    
    [self.ageSlider addTarget:self
                    action:@selector(valueChanged:)
                    forControlEvents:UIControlEventValueChanged];
    
    
    [self.maleSwitch addTarget:self
                     action:@selector(valueChanged:)
                     forControlEvents:UIControlEventValueChanged];
    
    
    [self.femaleSwitch addTarget:self
                       action:@selector(valueChanged:)
                       forControlEvents:UIControlEventValueChanged];
    
    self.ageLabel.text = [NSString stringWithFormat:@"%i",(int)self.ageSlider.value];
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

- (IBAction)editProfileButtonPressed:(UIButton *)sender {
    
    
    
}

- (IBAction)logoutButtonPressed:(UIButton *)sender {
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


-(void)valueChanged:(id)sender
{
    if (sender == self.ageSlider) {
        [[NSUserDefaults standardUserDefaults] setInteger:(int)self.ageSlider.value forKey:kCCAgeMaxKey];
        self.ageLabel.text = [NSString stringWithFormat:@"%i", (int)self.ageSlider.value];
    } else if (sender == self.maleSwitch) {
        [[NSUserDefaults standardUserDefaults] setBool:self.maleSwitch.isOn forKey:kCCMenEnabledKey];
    } else if (sender == self.femaleSwitch) {
        [[NSUserDefaults standardUserDefaults] setBool:self.femaleSwitch.isOn forKey:kCCWomenEnabledKey];
     }
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
