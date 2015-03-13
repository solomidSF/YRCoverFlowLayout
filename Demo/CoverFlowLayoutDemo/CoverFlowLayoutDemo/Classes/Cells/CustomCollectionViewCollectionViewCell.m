//
//  CustomCollectionViewCollectionViewCell.m
//  CoverFlowLayoutDemo
//
//  Created by Yuriy Romanchenko on 3/13/15.
//  Copyright (c) 2015 solomidSF. All rights reserved.
//

// Cell
#import "CustomCollectionViewCollectionViewCell.h"

// Model
#import "PhotoModel.h"

NSString *const kCustomCellIdentifier = @"CustomCell";

@implementation CustomCollectionViewCollectionViewCell {
    __weak IBOutlet UIImageView *_photoImageView;
    __weak IBOutlet UILabel *_photoDescription;
}

#pragma mark - Dynamic Properties

- (void)setPhotoModel:(PhotoModel *)photoModel {
    _photoModel = photoModel;
    
    _photoImageView.image = photoModel.image;
    _photoDescription.text = photoModel.imageDescription;
}

@end
