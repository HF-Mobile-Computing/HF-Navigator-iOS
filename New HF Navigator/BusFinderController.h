//
//  BusFinderController.h
//  HF Navigator
//
//  Created by Ethan on 10/23/14.
//  Copyright (c) 2014 Ethan Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLARingSpinnerView.h"

@interface BusFinderController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) LLARingSpinnerView * spinnerView;

@end
