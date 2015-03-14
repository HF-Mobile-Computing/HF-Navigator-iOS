//
//  NotificationsController.h
//  HF Navigator
//
//  Created by Ethan on 10/22/14.
//  Copyright (c) 2014 Ethan Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLARingSpinnerView.h"

@interface NotificationsController  : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) NSArray * notificationList;
@property (strong, nonatomic) NSArray * finished;
@property (strong, nonatomic) NSString * day;
@property (strong, nonatomic) LLARingSpinnerView * spinnerView;

-(void)LoadData;
-(void)LoadDay;

@end