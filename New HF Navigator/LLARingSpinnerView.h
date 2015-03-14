//
//  LLARSpinnerView.h
//  HF Navigator
//
//  Created by Ethan on 2/26/15.
//  Copyright (c) 2015 Ethan Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLARingSpinnerView : UIView

@property (nonatomic) CGFloat lineWidth;
@property (nonatomic) BOOL hidesWhenStopped;
@property (nonatomic, strong) CAMediaTimingFunction *timingFunction;
@property (nonatomic, readonly) BOOL isAnimating;

- (void)startAnimating;
- (void)stopAnimating;

@end