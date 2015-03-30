//
//  PhotoModel.h
//  CoverFlowLayoutDemo
//
//  Created by Yuriy Romanchenko on 3/13/15.
//  Copyright (c) 2015 solomidSF. All rights reserved.
//

@import UIKit;

/**
 *  Simple photo model that acts as a datasource for collection view.
 */
@interface PhotoModel : NSObject

@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) NSString *imageDescription;

+ (instancetype)modelWithImageNamed:(NSString *)imageNamed
                        description:(NSString *)description;

@end
