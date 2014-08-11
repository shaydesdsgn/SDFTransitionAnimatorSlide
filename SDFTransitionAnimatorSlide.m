//
//  SDFTransitionAnimatorSlide.m
//
//  Created by Trent Milton on 28/12/2013.
//  Copyright (c) 2013 shaydes.dsgn. All rights reserved.
//

#import "SDFTransitionAnimatorSlide.h"

@implementation SDFTransitionAnimatorSlide

- (id)init
{
    self = [super init];
    if (self) {
        self.direction = kSDTransitionAnimatorSlideLeft;
        self.transitionDuration = 0.5f;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    // Grab the from and to view controllers from the context.
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    [transitionContext.containerView addSubview:fromViewController.view];
    [transitionContext.containerView addSubview:toViewController.view];

    // We need to set the toViewController up correctly based on the direction of the animation.
    CGRect frame = toViewController.view.frame;
    frame.origin.y = (frame.size.height - self.overlap) * -self.direction.y;
    frame.origin.x = (frame.size.width - self.overlap) * -self.direction.x;
    toViewController.view.frame = frame;

    // Colour - so it looks nice and smooth
    UIColor *fromBackgroundColour = fromViewController.view.backgroundColor;
    UIColor *toBackgroundColour = toViewController.view.backgroundColor;
    if (!self.disableColourTransition) {
        toViewController.view.backgroundColor = fromViewController.view.backgroundColor;
    }
    [UIView animateWithDuration:self.transitionDuration animations:^{
        // This will move the toViewController to where the fromViewController is.
        toViewController.view.frame = fromViewController.view.frame;

        // Now we want to move the fromViewController in the appropriate direction so it appears
        // to move with the toViewController animation.
        CGRect frame = fromViewController.view.frame;
        frame.origin.y = (frame.size.height - self.overlap) * self.direction.y;
        frame.origin.x = (frame.size.width - self.overlap) * self.direction.x;
        fromViewController.view.frame = frame;

        // Colour
        if (!self.disableColourTransition) {
            fromViewController.view.backgroundColor = toBackgroundColour;
            toViewController.view.backgroundColor = toBackgroundColour;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromViewController.view.backgroundColor = fromBackgroundColour;
        [self.delegate transitionAnimatorSlideComplete:self.identifier fromViewController:fromViewController toViewController:toViewController];

    }];
}

@end
