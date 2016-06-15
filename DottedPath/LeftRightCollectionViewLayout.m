//
//  LeftRightCollectionViewLayout.m
//  DottedPath
//
//  Created by Arun Kumar.P on 6/14/16.
//  Copyright © 2016 ArunKumar.P. All rights reserved.
//

#import "LeftRightCollectionViewLayout.h"

@interface LeftRightCollectionViewLayout ()

@end

@interface UICollectionViewLayoutAttributes (RightAligned)

- (void)rightAlignFrameOnWidth:(CGFloat)width;

@end

@implementation UICollectionViewLayoutAttributes (RightAligned)

- (void)rightAlignFrameOnWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.origin.x = width - frame.size.width;
    self.frame = frame;
}

@end

#pragma mark -

@implementation LeftRightCollectionViewLayout

#pragma mark - UICollectionViewLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *originalAttributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *updatedAttributes = [NSMutableArray arrayWithArray:originalAttributes];
    for (UICollectionViewLayoutAttributes *attributes in originalAttributes) {
        if (!attributes.representedElementKind) {
            NSUInteger index = [updatedAttributes indexOfObject:attributes];
            updatedAttributes[index] = [self layoutAttributesForItemAtIndexPath:attributes.indexPath];
        }
    }
    
    return updatedAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes* currentItemAttributes = [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
    

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGRect frame = currentItemAttributes.frame;
    int column = indexPath.row/3;
    if (column%2 != 0) {
        frame.origin.x = width - (frame.size.width+frame.origin.x);
    }
    currentItemAttributes.frame = frame;
    return currentItemAttributes;
}

- (CGFloat)evaluatedMinimumInteritemSpacingForItemAtIndex:(NSInteger)index
{
    
    return 0.0f;
    
}

@end

