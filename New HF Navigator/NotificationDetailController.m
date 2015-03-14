//
//  NotificationDetailController.m
//  HF Navigator
//
//  Created by Ethan on 10/22/14.
//  Copyright (c) 2014 Obsidian Developers. All rights reserved.
//

#import "NotificationDetailController.h"

@implementation NotificationDetailController

@synthesize time;
@synthesize detail;

@synthesize content;
@synthesize timeLabel;



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
    
    [super viewDidLoad];
    
    content.text = detail;
    timeLabel.text = time;

}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
