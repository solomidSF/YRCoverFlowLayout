//
//  ViewController.m
//  CoverFlowLayoutDemo
//
//  Created by Yuriy Romanchenko on 3/13/15.
//  Copyright (c) 2015 solomidSF. All rights reserved.
//

// Controllers
#import "HomeViewController.h"

// Components
#import "YRCoverFlowLayout.h"

// Model
#import "PhotoModel.h"

// Cells
#import "CustomCollectionViewCollectionViewCell.h"

@interface HomeViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@end

@implementation HomeViewController {
    NSArray *_photoModelsDatasource;
    
    __weak IBOutlet UICollectionView *_photosCollectionView;
    __weak IBOutlet YRCoverFlowLayout *_coverFlowLayout;
    
    __weak IBOutlet UILabel *_maxDegreeValueLabel;
    __weak IBOutlet UILabel *_coverDensityValueLabel;
    __weak IBOutlet UILabel *_minOpacityValueLabel;
    __weak IBOutlet UILabel *_minScaleValueLabel;
    
    // To support all screen sizes we need to keep item size consistent.
    CGSize _originalItemSize;
    CGSize _originalCollectionViewSize;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    _originalItemSize = _coverFlowLayout.itemSize;
    _originalCollectionViewSize = _photosCollectionView.bounds.size;
 
    _maxDegreeValueLabel.text = [NSString stringWithFormat:@"%.2f", _coverFlowLayout.maxCoverDegree];
    _coverDensityValueLabel.text = [NSString stringWithFormat:@"%.2f", _coverFlowLayout.coverDensity];
    _minOpacityValueLabel.text = [NSString stringWithFormat:@"%.2f", _coverFlowLayout.minCoverOpacity];
    _minScaleValueLabel.text = [NSString stringWithFormat:@"%.2f", _coverFlowLayout.minCoverScale];
    
    [self generateDatasource];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_photosCollectionView reloadData];
    });    
}

#pragma mark - Auto Layout

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // We should invalidate layout in case we are switching orientation.
    // If we won't do that we will receive warning from collection view's flow layout that cell size isn't correct.
    [_coverFlowLayout invalidateLayout];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Now we should calculate new item size depending on new collection view size.
    _coverFlowLayout.itemSize = (CGSize){
        _photosCollectionView.bounds.size.width * _originalItemSize.width / _originalCollectionViewSize.width,
        _photosCollectionView.bounds.size.height * _originalItemSize.height / _originalCollectionViewSize.height
    };

    // Forcely tell collection view to reload current data.
    [_photosCollectionView setNeedsLayout];
    [_photosCollectionView layoutIfNeeded];
    [_photosCollectionView reloadData];
}

#pragma mark - Callbacks

- (IBAction)degreesSliderValueChanged:(UISlider *)sender {
    _coverFlowLayout.maxCoverDegree = sender.value;
    _maxDegreeValueLabel.text = [NSString stringWithFormat:@"%.2f", _coverFlowLayout.maxCoverDegree];
    
    [_photosCollectionView reloadData];
}

- (IBAction)densitySliderValueChanged:(UISlider *)sender {
    _coverFlowLayout.coverDensity = sender.value;
    _coverDensityValueLabel.text = [NSString stringWithFormat:@"%.2f", _coverFlowLayout.coverDensity];

    [_photosCollectionView reloadData];
}

- (IBAction)opacitySliderValueChanged:(UISlider *)sender {
    _coverFlowLayout.minCoverOpacity = sender.value;
    _minOpacityValueLabel.text = [NSString stringWithFormat:@"%.2f", _coverFlowLayout.minCoverOpacity];
    
    [_photosCollectionView reloadData];
}

- (IBAction)scaleSliderValueChanged:(UISlider *)sender {
    _coverFlowLayout.minCoverScale = sender.value;
    _minScaleValueLabel.text = [NSString stringWithFormat:@"%.2f", _coverFlowLayout.minCoverScale];
    
    [_photosCollectionView reloadData];
}

#pragma mark - Private

- (void)generateDatasource {
    _photoModelsDatasource = @[[PhotoModel modelWithImageNamed:@"nature1"
                                                   description:@"Lake and forest."],
                               [PhotoModel modelWithImageNamed:@"nature2"
                                                   description:@"Beautiful bench."],
                               [PhotoModel modelWithImageNamed:@"nature3"
                                                   description:@"Sun rays going through trees."],
                               [PhotoModel modelWithImageNamed:@"nature4"
                                                   description:@"Autumn Road."],
                               [PhotoModel modelWithImageNamed:@"nature5"
                                                   description:@"Outstanding Waterfall."],
                               [PhotoModel modelWithImageNamed:@"nature6"
                                                   description:@"Different Seasons."],
                               [PhotoModel modelWithImageNamed:@"nature7"
                                                   description:@"Home near lake."],
                               [PhotoModel modelWithImageNamed:@"nature8"
                                                   description:@"Perfect Mirror."],
                               [PhotoModel modelWithImageNamed:@"smtng"
                                                   description:@"Interesting formula."],];
}

#pragma mark - UICollectionViewDelegate/Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photoModelsDatasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCustomCellIdentifier
                                                                                             forIndexPath:indexPath];
    
    cell.photoModel = _photoModelsDatasource[indexPath.row];
    
    return cell;
}

@end