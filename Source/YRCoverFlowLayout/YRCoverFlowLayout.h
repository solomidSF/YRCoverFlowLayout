//
// YRCoverFlowLayout.h
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
 *  0 means that items are placed within a continious line.
 *  0.5 means that half of 3 and 1 cover will be behind 2.
 */
@property (nonatomic) CGFloat coverDensity;

@end
