//
//  ViewController.h
//  GestureRecognizerSample
//
//  Created by Sumardi Shukor on 5/2/12.
//  Copyright (c) 2012 Wutmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    CGFloat firstX;
	CGFloat firstY;
}

@property (retain, nonatomic) IBOutlet UIImageView *imageView;

- (void)handleTapRecognizerFrom:(UIGestureRecognizer *)gesture;
- (void)handleLongPressRecognizerFrom:(UIGestureRecognizer *)gesture;
- (void)handleSwipeRecognizerFrom:(UIGestureRecognizer *)gesture;

@end
