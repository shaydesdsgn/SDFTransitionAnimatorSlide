SDFTransitionAnimatorSlide
==========================

# Usage

1. Import the **SDFTransitionAnimatorSlide.h** file into the .m file.
2. Setup the **prepareForSegue** as follows
 
  ```
  - (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.transitioningDelegate = self;
    destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
    
    // Anything else you need to do now...
  }
  ```
3. Add the following chunk of code to setup the animation and assign an identifier for later use.

  ```
  #pragma mark - UIViewControllerTransitioningDelegate

  - (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    SDFTransitionAnimatorSlide *animator = [SDFTransitionAnimatorSlide new];
    animator.delegate = self;
    
    if ([presented isKindOfClass:[ViewControllerA class]]) {
        animator.identifier = @"IdentifierA";
        animator.direction = kSDTransitionAnimatorSlideDown;
        // This is optional and will allow the view controller to overlap for the animation duration.
        animator.overlap = 110.0f;
    } else if ([presented isKindOfClass:[ViewControllerB class]]) {
        animator.identifier = @"IdentifierB";;
        animator.direction = kSDTransitionAnimatorSlideLeft;
    } // ... etc.
    
    return animator;
  }
  ```
  
4. Now this chunk of code to run when a view controller is dismissed.

  ```
  - (id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed {
    
    SDTransitionAnimatorSlide *animator = [SDTransitionAnimatorSlide new];
    animator.delegate = self;
    
    if ([dismissed isKindOfClass:[ViewControllerA class]]) {
        animator.identifier = @"IdentifierA";
        animator.direction = kSDTransitionAnimatorSlideUp;
        animator.overlap = 110.0f;
    } else if ([dismissed isKindOfClass:[ViewControllerB class]]) {
    }
    
    return animator;
  }
  ```
  
5. Finally add this. This will let you run whatever you need post animation

  ```
  #pragma mark - SDTransitionAnimatorSlideDelegate

- (void) transitionAnimatorSlideComplete:(NSString *)identifier
                      fromViewController:(UIViewController *)fromViewController
                        toViewController:(UIViewController *)toViewController {
    
    if ([identifier isEqualToString:@"IdentifierA"]) {
        
    } else if ([identifier isEqualToString:@"IdentifierB"]) {
        
    }
  }
  ```
