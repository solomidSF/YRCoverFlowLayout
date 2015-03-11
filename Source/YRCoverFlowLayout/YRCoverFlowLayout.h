//
//  CoverFlowLayout.h
//  Epoxy
//
//  Created by Yuriy Romanchenko on 3/10/15.
//  Copyright (c) 2015 Epoxy. All rights reserved.
//

@import UIKit;

/**
 *  Layout to add cover flow effect to collection view scrolling.
 *  Applicable only for horizontal flow direction.
 */
@interface YRCoverFlowLayout : UICollectionViewFlowLayout

/**
 *  Max degree that can be applied to individual item.
 *  Default to 45 degrees.
 */
@property (nonatomic) CGFloat maxCoverDegree;

/**
 *  Determines how elements covers each other.
 *  Should be in range 0..1.
 *  Default to 0.25.
 *  Examples:
 *  0 means that they they are placed within a continious line.
 *  0.5 means that half of 3 and 1 cover will be behind 2.
 */
@property (nonatomic) CGFloat coverDensity;

@end
