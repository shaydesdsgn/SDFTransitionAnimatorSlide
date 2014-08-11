//
//  SDFTransitionAnimatorSlide.h
//
//  Created by Trent Milton on 28/12/2013.
//  Copyright (c) 2013 shaydes.dsgn. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSDTransitionAnimatorSlideUp       CGPointMake(0, 1)
#define kSDTransitionAnimatorSlideDown     CGPointMake(0, -1)
#define kSDTransitionAnimatorSlideLeft     CGPointMake(-1, 0)
#define kSDTransitionAnimatorSlideRight    CGPointMake(1, 0)

@protocol SDTransitionAnimatorSlideDelegate

- (void) transitionAnimatorSlideComplete:(NSString *)identifier
                      fromViewController:(UIViewController *)fromViewController
                      toViewController:(UIViewController *)toViewController;

@end

@interface SDTransitionAnimatorSlide : NSObject <UIViewControllerAnimatedTransitioning>

/**
 An id for the animation
 */
@property (nonatomic, strong) NSString *identifier;
/**
 Delegate class.
 */
@property (nonatomic, weak) id <SDTransitionAnimatorSlideDelegate> delegate;
/**
 Allows you to set the transitionDuration instead of overriding the method.
 Default: 0.3
 */
@property (nonatomic) float transitionDuration;
/**
 A basic cartesian style guide to which direction the animation is moving.
  1:    Right or Up
  0:    No movement
 -1:    Left or down

 NOTE: If you define your own outside of the constants above then unknown things could happen.
 Default: kSDTransitionAnimatorSlideLeft
 */
@property (nonatomic) CGPoint direction;
/**
 How much to overlap the toViewController over the fromViewController.
 Default: 0
 */
@property (nonatomic) float overlap;
/**
 Turn off the colour transition between view controllers.
 */
@property (nonatomic) BOOL disableColourTransition;

@end
