/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNCMaskedView.h"

#import <React/UIView+React.h>

@implementation RNCMaskedView

- (void)didUpdateReactSubviews
{
  // RNCMaskedView expects that the first subview rendered is the mask.
  UIView *maskView = [self.reactSubviews firstObject];
  self.maskView = maskView;

  // Add the other subviews to the view hierarchy
  for (NSUInteger i = 1; i < self.reactSubviews.count; i++) {
    UIView *subview = [self.reactSubviews objectAtIndex:i];
    [self addSubview:subview];
  }
}

- (void)displayLayer:(CALayer *)layer
{
    [super displayLayer:layer];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    CGRect maskFrame = self.maskView.frame;
    if ([self.maskView subviews].count > 0) {
            maskFrame = [[self.maskView subviews] firstObject].frame;
      }
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(maskFrame.origin.x, maskFrame.origin.y, maskFrame.size.width,  maskFrame.size.height)];
    [path appendPath:[UIBezierPath bezierPathWithRect:self.bounds]];

    shapeLayer.path = path.CGPath;
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    layer.mask = shapeLayer;
}

@end
