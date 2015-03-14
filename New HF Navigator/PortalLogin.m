//
//  PortalLogin.m
//  HF Navigator
//
//  Created by Ethan on 11/22/14.
//  Copyright (c) 2014 Ethan Thomas. All rights reserved.
//

#import "PortalLogin.h"
#import "UIColor+Hexadecimal.h"

@implementation PortalLogin
@synthesize webView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    webView.delegate = self;

    NSString *fullURL = @"https://harborfieldscsd.esboces.org/campus/portal/harborfields.jsp";
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
    
    webView.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + 50, self.view.frame.size.width, self.view.frame.size.height - 2 * ([UIApplication sharedApplication].statusBarFrame.size.height + 47));
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinnerView stopAnimating];
    self.spinnerView.hidden = YES;
}
@end
