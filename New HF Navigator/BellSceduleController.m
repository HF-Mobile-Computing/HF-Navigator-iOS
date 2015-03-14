//
//  BellSceduleController.m
//  HF Navigator
//
//  Created by Ethan on 11/12/14.
//  Copyright (c) 2014 Ethan Thomas. All rights reserved.
//

#import "BellSceduleController.h"

@implementation BellSceduleController

@synthesize imageView;



- (void)viewDidLoad{
    

    [super viewDidLoad];
    
}

- (void)viewDidLayoutSubviews {
    
        imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height);
    
}
@end
