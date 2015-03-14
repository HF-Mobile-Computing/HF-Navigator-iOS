//
//  NotificationDetailController.h
//  HF Navigator
//
//  Created by Ethan on 10/22/14.
//  Copyright (c) 2014 Ethan Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherDirectoryDetailController : UIViewController

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * position;
@property (strong, nonatomic) NSString * email;

@property (strong, nonatomic) UIColor * color;
@property (strong, nonatomic) UIImageView * teacherImageView;
@property (strong, nonatomic) UIImageView * emailImageView;

@property (strong, nonatomic) UILabel * nameLabel;
@property (strong, nonatomic) UILabel * positionLabel;
@property (strong, nonatomic) UILabel * emailLabel;
@property (strong, nonatomic) UILabel * emailStringLabel;
@property (strong, nonatomic) UIButton * backButton;

@property (strong, nonatomic) UIView * emailView;



-(IBAction)back;

@end
