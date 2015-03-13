//
//  PhotoModel.m
//  CoverFlowLayoutDemo
//
//  Created by Yuriy Romanchenko on 3/13/15.
//  Copyright (c) 2015 solomidSF. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

#pragma mark - Init

+ (instancetype)modelWithImageNamed:(NSString *)imageNamed
                        description:(NSString *)description {
    return [[self alloc] initWithImageNamed:imageNamed
                                description:description];
}

- (instancetype)initWithImageNamed:(NSString *)imageNamed
                       description:(NSString *)description {
    if (self = [super init]) {
        _image = [UIImage imageNamed:imageNamed];
        _imageDescription = description;
    }
    
    return self;
}

@end
