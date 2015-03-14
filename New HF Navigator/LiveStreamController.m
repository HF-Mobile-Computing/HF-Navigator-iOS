//
//  LiveStreamController.m
//  HF Navigator
//
//  Created by Ethan on 2/20/15.
//  Copyright (c) 2015 Ethan Thomas. All rights reserved.
//

#import "LiveStreamController.h"
#import "UIColor+Hexadecimal.h"

@implementation LiveStreamController
@synthesize webView;

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#336699"];
    
    NSString *fullURL = @"http://www.harbingernews.net/livestreams";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
    webView.delegate = self;


    self.spinnerView = [[LLARingSpinnerView alloc]
                        initWithFrame:CGRectMake(0, 0, 50, 50)];
    
 self.spinnerView.frame = CGRectMake((self.view.frame.size.width / 2) - (self.spinnerView.frame.size.width / 2), (self.view.frame.size.height / 2) - (self.spinnerView.frame.size.height / 2), 50, 50);
    
    self.spinnerView.lineWidth = 4.0f;
    
    self.spinnerView.tintColor = [UIColor colorWithHexString:@"#336699"];
    
    [self.view addSubview:self.spinnerView];
    
    [self.spinnerView startAnimating];
    
}

- (void)viewDidLayoutSubviews {
    
    webView.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height - 20, self.view.frame.size.width, self.view.frame.size.height);
}

- (IBAction)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinnerView stopAnimating];
    self.spinnerView.hidden = YES;
}
@end
