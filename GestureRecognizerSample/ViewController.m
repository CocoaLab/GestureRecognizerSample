//
//  ViewController.m
//  GestureRecognizerSample
//
//  Created by Sumardi Shukor on 5/2/12.
//  Copyright (c) 2012 Wutmedia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapRecognizerFrom:)];
    [self.imageView addGestureRecognizer:tapRecognizer];
    [tapRecognizer release];
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressRecognizerFrom:)];
    [self.imageView addGestureRecognizer:longPressGestureRecognizer];
    [longPressGestureRecognizer release];
    
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRecognizerFrom:)];
    [swipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.imageView addGestureRecognizer:swipeGestureRecognizer];
    [swipeGestureRecognizer release];
    
    UISwipeGestureRecognizer *swipeGestureRecognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRecognizerFrom:)];
    [swipeGestureRecognizer2 setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.imageView addGestureRecognizer:swipeGestureRecognizer2];
    [swipeGestureRecognizer2 release];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizerFrom:)];
    [self.imageView addGestureRecognizer:panGestureRecognizer];
    [panGestureRecognizer release];
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [imageView release];
    [super dealloc];
}

- (void)handleTapRecognizerFrom:(UIGestureRecognizer *)gesture
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Information" message:@"Tap gesture recognized!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

- (void)handleLongPressRecognizerFrom:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Information" message:@"Long press gesture recognized!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

- (void)handleSwipeRecognizerFrom:(UIGestureRecognizer *)gesture
{
    UISwipeGestureRecognizer *swipeRecognizer = (UISwipeGestureRecognizer *)gesture;
    
    NSString *message = [[NSString alloc] init];
    if (swipeRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        message = @"Swipe direction left";
    } else if (swipeRecognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        message = @"Swipe direction right";
    } else if (swipeRecognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        message = @"Swipe direction up";
    } else if (swipeRecognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        message = @"Swipe direction down";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Information" message:message delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alertView show];
    [message release];
    [alertView release];
}

- (void)handlePanRecognizerFrom:(UIGestureRecognizer *)sender
{
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
		firstX = [[sender view] center].x;
		firstY = [[sender view] center].y;
	}
    
	translatedPoint = CGPointMake(firstX+translatedPoint.x, firstY+translatedPoint.y);
    
	[[sender view] setCenter:translatedPoint];
    
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
		CGFloat finalX = translatedPoint.x + (.35*[(UIPanGestureRecognizer*)sender velocityInView:self.view].x);
		CGFloat finalY = translatedPoint.y + (.35*[(UIPanGestureRecognizer*)sender velocityInView:self.view].y);
        
		if(UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation])) {    
			if(finalX < 0) { 				 				
                finalX = 0; 			
            } else if(finalX > 320) {  
				finalX = 320;
			}
            
			if(finalY < 0) { 				 				
                finalY = 0; 			
            } else if(finalY > 480) {
				finalY = 480;
			}
		} else {
			if(finalX < 0) { 				 				
                finalX = 0; 			
            } else if(finalX > 480) { 
				finalX = 320;
			}
            
			if(finalY < 0) { 				 				
                finalY = 0; 			
            } else if(finalY > 320) {  
				finalY = 480;
			}
		}
        
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.35];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[[sender view] setCenter:CGPointMake(finalX, finalY)];
		[UIView commitAnimations];
	}
}

@end
