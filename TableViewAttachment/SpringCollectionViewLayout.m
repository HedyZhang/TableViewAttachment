//
//  SpringCollectionViewLayout.m
//  TableViewAttachment
//
//  Created by yanshu on 15/5/13.
//  Copyright (c) 2015年 yanshu. All rights reserved.
//

#import "SpringCollectionViewLayout.h"

@implementation SpringCollectionViewLayout
{
    UIDynamicAnimator *_dynamicAnimator;
    CGFloat _bounceFactor;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}
- (void)prepareLayout
{
    [super prepareLayout];
    if (!_dynamicAnimator)
    {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        CGSize contentSize = [self collectionViewContentSize];
        NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        _bounceFactor = items.count;
        for (UICollectionViewLayoutAttributes *item in items) {
            UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:item.center];
            spring.length = 0;        //依附点的距离
            spring.damping = 0.5;     //阻尼
            spring.frequency = 0.8;  //震动频率
            [_dynamicAnimator addBehavior:spring];
        }
    }
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [_dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [_dynamicAnimator itemsInRect:rect];
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView *scrollView = self.collectionView;
    CGFloat scrollDelta = newBounds.origin.y - scrollView.bounds.origin.y;
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
    
    for (UIAttachmentBehavior *spring in _dynamicAnimator.behaviors)
    {
        CGPoint anchorPoint = spring.anchorPoint;
        CGFloat distanceFromTouch = fabs(touchLocation.y - anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch / _bounceFactor; // higher the number, larger the bounce
        
        UICollectionViewLayoutAttributes *item = [spring.items firstObject];
        CGPoint center = item.center;
        center.y += scrollDelta * scrollResistance;
        item.center = center;
        
        [_dynamicAnimator updateItemUsingCurrentState:item];
    }
    
    return YES;
}

@end
