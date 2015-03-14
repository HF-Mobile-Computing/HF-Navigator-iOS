//
//  NotificationDetailController.m
//  HF Navigator
//
//  Created by Ethan on 10/22/14.
//  Copyright (c) 2014 Ethan Thomas. All rights reserved.
//

#import "TeacherDirectoryDetailController.h"
#import "UIColor+Hexadecimal.h"
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MFMailComposeViewController.h>

@implementation TeacherDirectoryDetailController

@synthesize name;
@synthesize position;
@synthesize email;

@synthesize color;

@synthesize teacherImageView;

@synthesize nameLabel;
@synthesize positionLabel;
@synthesize emailLabel;

@synthesize backButton;

@synthesize emailView;

@synthesize emailImageView;
@synthesize emailStringLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [self initializeViews];

    [super viewDidLoad];
}

-(void)back:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)initializeViews{
    
    teacherImageView = [[UIImageView alloc]
                        initWithFrame:CGRectMake(0, 0, 250, 200)];
    
    teacherImageView.image = [UIImage imageNamed:@"teacher_profile.png"];
    
    teacherImageView.frame = CGRectMake((self.view.frame.size.width / 2) - (teacherImageView.frame.size.width / 2), 70, 250, 250);
    teacherImageView.backgroundColor = color;
    
    nameLabel = [[UILabel alloc]
                 initWithFrame:CGRectMake(20, (teacherImageView.frame.size.height + teacherImageView.frame.origin.y) / 1.05, self.view.frame.size.width - 20, 40)];
    nameLabel.text = name;
    nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
    nameLabel.textColor = [UIColor colorWithHexString:@"#f0f0f0"];
    
    positionLabel = [[UILabel alloc]
                 initWithFrame:CGRectMake(20, (nameLabel.frame.size.height + nameLabel.frame.origin.y) / 1.04, self.view.frame.size.width, 40)];
    
    positionLabel.text = position;
    positionLabel.textColor = [UIColor colorWithHexString:@"#f0f0f0"];
    
    backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 35, 30, 30)];
    UIImage *btnImage = [UIImage imageNamed:@"ic_ab_up_white.png"];
    [backButton setImage:btnImage forState:UIControlStateNormal];
    
    UIView * colorView = [[UIView alloc]
                          initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, positionLabel.frame.origin.y + positionLabel.frame.size.height)];
    
    colorView.backgroundColor = [UIColor colorWithHexString:@"#3399FF"];
    
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    emailView = [[UIView alloc]
                 initWithFrame:CGRectMake(15, (colorView.frame.origin.y + colorView.frame.size.height) / .96, self.view.frame.size.width - 30, 70)];
    
    emailView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    
    // border radius
    [emailView.layer setCornerRadius:3.0f];
    
    // drop shadow
    [emailView.layer setShadowColor:[UIColor blackColor].CGColor];
    [emailView.layer setShadowOpacity:0.5];
    [emailView.layer setShadowRadius:2.0];
    [emailView.layer setShadowOffset:CGSizeMake(0, 2)];
    
    emailImageView = [[UIImageView alloc]
                      initWithFrame:CGRectMake(emailView.frame.origin.x + 10, emailView.frame.origin.y + 7.5, 55, 55)];
    
    emailImageView.image = [UIImage imageNamed:@"email.png"];
    
    emailLabel = [[UILabel alloc]
                  initWithFrame:CGRectMake(emailImageView.frame.origin.x + emailImageView.frame.size.width + 10, emailImageView.frame.origin.y - 5, emailView.frame.size.width - 80, 40)];
    emailLabel.text = email;
    emailLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15];
    
    emailStringLabel = [[UILabel alloc]
                  initWithFrame:CGRectMake(emailImageView.frame.origin.x + emailImageView.frame.size.width + 10, emailLabel.frame.origin.y + emailLabel.frame.size.height - 20, emailLabel.frame.size.width - 80, 40)];
    emailStringLabel.text = @"Email";
    emailStringLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:14];
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openEmail)];
    singleTap1.numberOfTapsRequired = 1;
    
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openEmail)];
    singleTap2.numberOfTapsRequired = 1;
    
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openEmail)];
    singleTap3.numberOfTapsRequired = 1;
    
    UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openEmail)];
    singleTap4.numberOfTapsRequired = 1;
    
    [emailImageView setUserInteractionEnabled:YES];
    [emailImageView addGestureRecognizer:singleTap1];
    [emailLabel setUserInteractionEnabled:YES];
    [emailLabel addGestureRecognizer:singleTap2];
    [emailStringLabel setUserInteractionEnabled:YES];
    [emailStringLabel addGestureRecognizer:singleTap3];
    [emailView setUserInteractionEnabled:YES];
    [emailView addGestureRecognizer:singleTap4];

    [self.view addSubview:colorView];
    [self.view addSubview:teacherImageView];
    [self.view addSubview:nameLabel];
    [self.view addSubview:positionLabel];
    [self.view addSubview:backButton];
    [self.view addSubview:emailView];
    [self.view addSubview:emailLabel];
    [self.view addSubview:emailImageView];
    [self.view addSubview:emailStringLabel];

}

- (void)openEmail{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"mailto:" stringByAppendingString:email]]];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
