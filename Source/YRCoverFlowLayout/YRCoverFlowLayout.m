//
// YRCoverFlowLayout.m
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Yuri R.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "YRCoverFlowLayout.h"

static CGFloat const kDistanceToProjectionPlane = 500.0f;

@implementation YRCoverFlowLayout

#pragma mark - Init

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    self.maxCoverDegree = 45.0f;
    self.coverDensity = 0.25f;
    self.minCoverOpacity = 1.0f;
    self.minCoverScale = 1.0f;
}

#pragma mark - Overridden

- (void)prepareLayout {
    [super prepareLayout];
    
    NSAssert(self.collectionView.numberOfSections == 1, @"[YRCoverFlowLayout]: Multiple sections aren't supported!");
    NSAssert(self.scrollDirection == UICollectionViewScrollDirectionHorizontal, @"[YRCoverFlowLayout]: Vertical scrolling isn't supported!");
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//    CGFloat xOffset = self.collectionView.contentOffset.x;
    NSArray *idxPaths = [self indexPathsContainedInRect:rect];
//    CGRect visibleRect = (CGRect){self.collectionView.contentOffset, self.collectionView.bounds.size};
    
//    NSLog(@"Current offset: %.2f.", xOffset);
//    NSLog(@"Visible rect: %@. Requested rect: %@", NSStringFromCGRect(visibleRect), NSStringFromCGRect(rect));
//    NSLog(@"Got %d items for requested rect.", (int32_t)idxPaths.count);
    
    NSMutableArray *resultingAttributes = [NSMutableArray new];
    
    for (NSIndexPath *path in idxPaths) {
        // We should create attributes by ourselves.
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:path];
        
        [resultingAttributes addObject:attributes];
    }
    
    return [NSArray arrayWithArray:resultingAttributes];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attributes.size = self.itemSize;
    attributes.center = (CGPoint){
        [self collectionViewWidth] * indexPath.row + [self collectionViewWidth],
        [self collectionViewHeight] / 2
    };
    
    [self interpolateAttributes:attributes
                      forOffset:self.collectionView.contentOffset.x];
    
    return attributes;
}

- (CGSize)collectionViewContentSize {
    return (CGSize){self.collectionView.bounds.size.width * [self.collectionView numberOfItemsInSection:0],
                    self.collectionView.bounds.size.height};
}

#pragma mark - Accessors

- (CGFloat)collectionViewHeight {
    return self.collectionView.bounds.size.height;
}

- (CGFloat)collectionViewWidth {
    return self.collectionView.bounds.size.width;
}

#pragma mark - Private

- (CGPoint)itemCenterForRow:(NSInteger)row {
    CGSize collectionViewSize = self.collectionView.bounds.size;
    return (CGPoint){row * collectionViewSize.width + collectionViewSize.width / 2 ,
                    collectionViewSize.height / 2};
}

- (CGFloat)minXForRow:(NSInteger)row {
    return [self itemCenterForRow:row - 1].x + (1.0f / 2 - self.coverDensity) * self.itemSize.width;
}

- (CGFloat)maxXForRow:(NSInteger)row {
    return [self itemCenterForRow:row + 1].x - (1.0f / 2 - self.coverDensity) * self.itemSize.width;
}

- (CGFloat)minXCenterForRow:(NSInteger)row {
	CGFloat halfWidth = self.itemSize.width / 2;
	CGFloat maxRads = [self degreesToRad:self.maxCoverDegree];
    CGFloat center = [self itemCenterForRow:row - 1].x;
	CGFloat prevItemRightEdge = center + halfWidth;
	CGFloat projectedLeftEdgeLocal = halfWidth * cos(maxRads) * kDistanceToProjectionPlane / (kDistanceToProjectionPlane + halfWidth * sin(maxRads));
	
	return prevItemRightEdge - self.coverDensity * self.itemSize.width + projectedLeftEdgeLocal;
}

- (CGFloat)maxXCenterForRow:(NSInteger)row {
	CGFloat halfWidth = self.itemSize.width / 2;
	CGFloat maxRads = [self degreesToRad:self.maxCoverDegree];
	CGFloat center = [self itemCenterForRow:row + 1].x;
	CGFloat nextItemLeftEdge = center - halfWidth;
	CGFloat projectedRightEdgeLocal = fabs(halfWidth * cos(maxRads) * kDistanceToProjectionPlane / (-halfWidth * sin(maxRads) - kDistanceToProjectionPlane));
	
	return nextItemLeftEdge + self.coverDensity * self.itemSize.width - projectedRightEdgeLocal;
}

- (CGFloat)degreesToRad:(CGFloat)degrees {
    return degrees * M_PI / 180;
}

- (NSArray *)indexPathsContainedInRect:(CGRect)rect {
    if ([self.collectionView numberOfItemsInSection:0] == 0) {
        // Nothing to do here when we don't have items.
        return @[];
    }
    
    // Find min and max rows that can be determined for sure.
    NSInteger minRow = MAX(rect.origin.x / [self collectionViewWidth], 0);
    NSInteger maxRow = CGRectGetMaxX(rect) / [self collectionViewWidth];
    
    // Additional check for rows that also can be included (our rows are moving depending on content size).
    NSInteger candidateMinRow = MAX(minRow - 1, 0);
    if ([self maxXForRow:candidateMinRow] >= rect.origin.x) {
        // We have a row that is less than given minimum.
        minRow = candidateMinRow;
    }
    
    NSInteger candidateMaxRow = MIN(maxRow + 1, [self.collectionView numberOfItemsInSection:0] - 1);
    if ([self minXForRow:candidateMaxRow] <= CGRectGetMaxX(rect)) {
        maxRow = candidateMaxRow;
    }
    
    // Simply add index paths between min and max.
    NSMutableArray *resultingIdxPaths = [NSMutableArray new];
    
    for (NSInteger i = minRow; i <= maxRow; i++) {
        [resultingIdxPaths addObject:[NSIndexPath indexPathForRow:i
                                                        inSection:0]];
    }
    
    return [NSArray arrayWithArray:resultingIdxPaths];
}

- (void)interpolateAttributes:(UICollectionViewLayoutAttributes *)attributes
                    forOffset:(CGFloat)offset {
    NSIndexPath *attributesPath = attributes.indexPath;
    
    // Interpolate offset for given attribute. For this task we need min max interval and min and max x allowed for item.
    CGFloat minInterval = (attributesPath.row - 1) * [self collectionViewWidth];
    CGFloat maxInterval = (attributesPath.row + 1) * [self collectionViewWidth];
    
    CGFloat minX = [self minXCenterForRow:attributesPath.row];
    CGFloat maxX = [self maxXCenterForRow:attributesPath.row];
    CGFloat spanX = maxX - minX;
    
    // Interpolate by formula
    CGFloat interpolatedX = MIN(MAX(minX + ((spanX / (maxInterval - minInterval)) * (offset - minInterval)),
                                    minX),
                                maxX);
    attributes.center = (CGPoint){
        interpolatedX,
        attributes.center.y
    };
    
    CATransform3D transform = CATransform3DIdentity;
    // Add perspective.
	transform.m34 = -1.0 / kDistanceToProjectionPlane;
    
    // Then rotate.
    CGFloat angle = -self.maxCoverDegree + (interpolatedX - minX) * 2 * self.maxCoverDegree / spanX;
    transform = CATransform3DRotate(transform, angle * M_PI / 180, 0, 1, 0);
    
    // Then scale: 1 - abs(1 - Q - 2 * x * (1 - Q))
    CGFloat scale = 1.0 - ABS(1.0 - self.minCoverScale - (interpolatedX - minX) * 2 * (1.0 - self.minCoverScale) / spanX);
    transform = CATransform3DScale(transform, scale, scale, scale);
    
    // Apply transform.
    attributes.transform3D = transform;
    
    // Add opacity: 1 - abs(1 - Q - 2 * x * (1 - Q))
    CGFloat opacity = 1.0 - ABS(1.0 - self.minCoverOpacity - (interpolatedX - minX) * 2 * (1.0 - self.minCoverOpacity) / spanX);
    attributes.alpha = opacity;
    
//    NSLog(@"IDX: %d. MinX: %.2f. MaxX: %.2f. Interpolated: %.2f. Interpolated angle: %.2f",
//          (int32_t)attributesPath.row,
//          minX,
//          maxX,
//          interpolatedX,
//          angle);
}

@end