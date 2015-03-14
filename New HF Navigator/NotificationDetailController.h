//
//  NotificationDetailController.h
//  HF Navigator
//
//  Created by Ethan on 10/22/14.
//  Copyright (c) 2014 Obsidian Developers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationDetailController : UIViewController

@property (strong, nonatomic) NSString * time;
@property (strong, nonatomic) NSString * detail;
@property (weak, nonatomic) IBOutlet UILabel * content;
@property (weak, nonatomic) IBOutlet UILabel * timeLabel;



@end
