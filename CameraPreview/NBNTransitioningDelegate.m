#import "NBNTransitioningDelegate.h"

@interface NBNTransitioningDelegate ()
@property (nonatomic,assign) CGRect originFrame;
@end

@implementation NBNTransitioningDelegate

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}


#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.33;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    if (fromViewController.presentedViewController == toViewController) {
        [self presentWithTransitionContext:transitionContext];
    } else {
        [self dismissWithTransitionContext:transitionContext];
    }



}

#pragma mark - Private methods

- (void)presentWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UINavigationController *navigationController = (UINavigationController *) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UICollectionViewController *collectionViewController = navigationController.viewControllers[0];
    UICollectionView *collectionView = collectionViewController.collectionView;
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];

    CGRect endFrame = [transitionContext initialFrameForViewController:navigationController];

    NSArray *selectedIndexPaths = [collectionView indexPathsForSelectedItems];
    NSIndexPath *selectedIndexPath = [selectedIndexPaths firstObject];
    NSAssert(selectedIndexPath, @"No selectedIndexPath available for animation");
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:selectedIndexPath];

    self.originFrame = [containerView convertRect:cell.frame fromView:collectionView];

    toViewController.view.frame = self.originFrame;
    [containerView addSubview:toViewController.view];

    [UIView animateWithDuration:[self transitionDuration:nil]
                     animations:^{
                         toViewController.view.frame = endFrame;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:finished];
                     }];
}

- (void)dismissWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    CGRect endFrame = [transitionContext initialFrameForViewController:fromViewController];

    toViewController.view.frame = endFrame;
    fromViewController.view.frame = endFrame;

    [containerView addSubview:toViewController.view];
    [containerView addSubview:fromViewController.view];

    [UIView animateWithDuration:[self transitionDuration:nil]
                     animations:
     ^{
         fromViewController.view.frame = self.originFrame;
     }
                     completion:
     ^(BOOL finished) {
         [transitionContext completeTransition:finished];
     }];
}

@end
