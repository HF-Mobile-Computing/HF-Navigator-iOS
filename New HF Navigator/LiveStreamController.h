//
//  LiveStreamController.h
//  HF Navigator
//
//  Created by Ethan on 2/20/15.
//  Copyright (c) 2015 Ethan Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "LLARingSpinnerView.h"

@interface LiveStreamController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) LLARingSpinnerView * spinnerView;
- (IBAction)showMenu;

@end
