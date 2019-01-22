# YRCoverFlowLayout

Simple cover animation flow layout for collection view.

# Description

This custom layout enhances your collection view with cover flow effect.
You don’t need to worry about items(cells) positions, spaces between them, etc. because it’s already done in `YRCoverFlowLayout`! You simply design your cell and return them as usual in datasource methods and `YRCoverFlowLayout` handles the rest.

# Demo

![Portrait flow](https://raw.githubusercontent.com/solomidSF/YRCoverFlowLayout/1.3.0/PortraitCoverLayout.gif)
![Lanscape flow](https://raw.githubusercontent.com/solomidSF/YRCoverFlowLayout/1.3.0/LandscapeCoverLayout.gif)

# Installation

### Manual
1. Simply drag&drop source into your project.
2. Set custom layout class in your collection view to `YRCoverFlowLayout`.
3. Design your cell in collection view.
4. Return your cell in datasource methods.
5. Scroll and enjoy.

### CocoaPods
`YRCoverFlowLayout` is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YRCoverFlowLayout'
```

# Customization 

There are 4 properties that can be customized:

Max degree of rotation for items. Default to 45. This means that item on a left side of screen will be rotated 45 degrees around y and item on a right side will be rotated -45 degrees around y. 

	@property (nonatomic) CGFloat maxCoverDegree;

This property means how neighbour items are placed to in relation to currently displayed item. Default to 1/4. This means that item on left will cover 1/4 of current displayed item and item from right will also cover 1/4 of current item. Value should be in 0..1 range.

	@property (nonatomic) CGFloat coverDensity;

Thanks to [viteinfinite](https://github.com/viteinfinite) for adding 2 more customizable properties:

Min opacity that can be applied to individual item.
Default to 1.0 (alpha 100%).

	@property (nonatomic) CGFloat minCoverOpacity;

Min scale that can be applied to individual item.
Default to 1.0 (no scale).

	@property (nonatomic) CGFloat minCoverScale;

If you’re changing them at runtime - don’t forget to call ‘reloadData’.

# Notes

Currently only horizontal scroll direction supported.
In future releases vertical scrolling will be added too.

# Keywords

Cover flow, custom layout, collection view

# Version
v1.3.0

# License

`YRCoverFlowLayout` is released under the MIT license. See [LICENSE](https://github.com/solomidSF/YRCoverFlowLayout/blob/master/LICENSE) for details.
