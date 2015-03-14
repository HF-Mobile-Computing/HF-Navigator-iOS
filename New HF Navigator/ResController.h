//
//  AKNavTabController.h
//  AKNavTab
//
//  Created by Terence Adrien Zama on 11/12/14.
//  Copyright (c) 2014 Terence Adrien Zama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface ResController : UIViewController
@property (nonatomic,strong) NSArray *viewControllersId;
@property (nonatomic,strong) NSArray *titles;

- (IBAction)showMenu;

@end
