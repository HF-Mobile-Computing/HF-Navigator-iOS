//
//  AboutController.m
//  HF Navigator
//
//  Created by Ethan on 11/22/14.
//  Copyright (c) 2014 Ethan Thomas. All rights reserved.
//

#import "AboutController.h"
#import "UIColor+Hexadecimal.h"

@implementation AboutController
@synthesize webView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    webView.delegate = self;

    NSString *fullURL = @"http://harborfieldscsd.net/our_schools/harborfields_high_school";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
    self.spinnerView = [[LLARingSpinnerView alloc]
                        initWithFrame:CGRectMake(0, 0, 50, 50)];
    
 self.spinnerView.frame = CGRectMake((self.view.frame.size.width / 2) - (self.spinnerView.frame.size.width / 2), (self.view.frame.size.height / 2) - (self.spinnerView.frame.size.height / 2), 50, 50);
    
    self.spinnerView.lineWidth = 4.0f;
    
    self.spinnerView.tintColor = [UIColor colorWithHexString:@"#336699"];
    
    [self.view addSubview:self.spinnerView];
    
    [self.spinnerView startAnimating];
}

- (void)viewDidLayoutSubviews {
    
    webView.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + 44, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinnerView stopAnimating];
    self.spinnerView.hidden = YES;
}

@end
