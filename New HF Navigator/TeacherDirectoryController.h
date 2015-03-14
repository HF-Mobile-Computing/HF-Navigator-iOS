//
//  NotificationsController.h
//  HF Navigator
//
//  Created by Ethan on 10/22/14.
//  Copyright (c) 2014 Ethan Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "LLARingSpinnerView.h"

@interface TeacherDirectoryController  : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) NSArray * teacherList;
@property (strong, nonatomic) NSArray * finished;
@property (strong, nonatomic) NSArray * colorArray;
@property (strong, nonatomic) NSMutableArray * colorList;
@property (strong, nonatomic) UIView *circleView;
@property (strong, nonatomic) LLARingSpinnerView * spinnerView;


-(void)LoadData;
-(void)showMenu;

@end