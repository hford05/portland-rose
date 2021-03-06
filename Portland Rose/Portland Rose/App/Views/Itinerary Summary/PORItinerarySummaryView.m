//
//  PORItinerarySummaryView.m
//  Portland Rose
//
//  Created by Hunter Ford on 11/04/2018.
//  Copyright © 2018 Useless Corporation. All rights reserved.
//

#import "PORItinerarySummaryView.h"

/// Cost format
static NSString * const FORMAT_COST = @"%lu";
/// Cost format (range)
static NSString * const FORMAT_COST_RANGE = @"%lu to %lu";
/// Duration format (hours)
static NSString * const FORMAT_DURATION_HOURS = @"%lu hrs";
/// Duration format (minutes)
static NSString * const FORMAT_DURATION_MINUTES = @"%lu mins";
/// Cost text (free)
static NSString * const TEXT_COST_FREE = @"FREE";
/// NIB name
static NSString * const NAME_NIB = @"PORItinerarySummaryView";


@interface PORItinerarySummaryView()
/// Main view
@property (strong, nonatomic) IBOutlet UIView *view;
/// Itinerary image
@property (weak, nonatomic) IBOutlet PORImageCardView *viewCardImage;
/// Itinerary cost label
@property (weak, nonatomic) IBOutlet UILabel *viewLabelCost;
/// Itinerary duration label
@property (weak, nonatomic) IBOutlet UILabel *viewLabelDuration;
/// Itinerary title label
@property (weak, nonatomic) IBOutlet UILabel *viewLabelTitle;
/// Stack view showing itinerary summary icons, cost, etc.
@property (weak, nonatomic) IBOutlet UIStackView *viewStackDashboard;
/// Stack view showing summary icons
@property (weak, nonatomic) IBOutlet UIStackView *viewStackDashboardIcons;

@end

@implementation PORItinerarySummaryView

#pragma mark - lifecycle

- (instancetype) initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  [self loadNib];
  return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder{
  self = [super initWithCoder:aDecoder];
  [self loadNib];
  return self;
}

#pragma mark - setters

- (void) setCostLower:(NSUInteger) costLower {
  _costLower = costLower;
  [_viewLabelCost setText: [self formattedCost]];
};

- (void) setCostUpper:(NSUInteger) costUpper {
  _costUpper = costUpper;
  [_viewLabelCost setText: [self formattedCost]];
}

- (void) setDuration:(NSUInteger) duration{
  _duration = duration;
  [_viewLabelDuration setText: [self formattedDuration]];
}

- (void) setIcons:(NSMutableArray *) icons{
  _icons = icons;
  [self updateIcons];
}

- (void) setImage:(UIImage *) image{
  _image = image;
  [_viewCardImage setImage: _image];
}

- (void) setTitle:(NSString *)title{
  _title = title;
  [_viewLabelTitle setText: _title];
}

#pragma mark - events


#pragma mark - helpers

/**
 * Returns the itinerary's cost as a displayable text string
 */
- (NSString *) formattedCost {
  if (_costUpper == 0){
    return TEXT_COST_FREE;
  }
  else if (_costLower == _costUpper){
    return [NSString stringWithFormat: FORMAT_COST, (unsigned long)_costLower];
  }
  return [NSString stringWithFormat: FORMAT_COST_RANGE, (unsigned long)_costLower, (unsigned long)_costUpper];
}

/**
 * Returns the itinerary's duration as a displayable text string
 */
- (NSString *) formattedDuration {
  NSUInteger hours;
  
  if (_duration < 60){
    return [NSString stringWithFormat:FORMAT_DURATION_MINUTES, _duration];
  } else {
    hours = _duration / 60;
    return [NSString stringWithFormat:FORMAT_DURATION_HOURS, hours];
  }
}

/**
 * Load the nib file
 */
- (void) loadNib {
  [[NSBundle bundleForClass:self.class] loadNibNamed:NAME_NIB owner:self options:nil];
  [self nibDidLoad];
}

/**
 * Perform initial setup after the nib loads
 */
- (void) nibDidLoad {
  PORPalette * palette;
  PORTypeLibrary * typeLibrary;
  
  palette = [PORPalette sharedPalette];
  typeLibrary = [PORTypeLibrary sharedTypeLibrary];
  
  // Configure primary view
  _view.frame = self.bounds;
  [self addSubview: _view];
  
  // Configure label colors
  [_viewLabelTitle setTextColor: palette.colorTextLoud];
  [_viewLabelCost setTextColor: palette.colorText];
  [_viewLabelDuration setTextColor: palette.colorText];
  
  // Configure label fonts
  [_viewLabelTitle setFont: typeLibrary.fontHeadline];
  [_viewLabelCost setFont: typeLibrary.fontBody];
  [_viewLabelDuration setFont: typeLibrary.fontBody];
  
  // Configure background
  [self.view setBackgroundColor: palette.colorBackground];
  
  // Configure icon tints
  for (UIView * v in _viewStackDashboard.arrangedSubviews) {
    v.tintColor = palette.colorText;
  }
  
}

/**
 * Update the interary dashboard's icons
 */
- (void) updateIcons{
  UIImageView * icon;
  PORPalette * palette;
  
  palette = PORPalette.sharedPalette;
  
  // If there are no icons to show, hide the stack view
  _viewStackDashboardIcons.hidden = _icons.count == 0;
  
  // Remove old icons
  for (UIView * av in _viewStackDashboardIcons.arrangedSubviews){
    [NSLayoutConstraint deactivateConstraints: av.constraints];
    [av removeFromSuperview];
  }
  
  // Add and configure new ones
  for (UIImage * img in _icons){
    icon = [[UIImageView alloc] initWithImage:img];
    [icon addConstraint: [NSLayoutConstraint constraintWithItem:icon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:icon attribute: NSLayoutAttributeWidth multiplier:1 constant:0]];
    [icon setTintColor: palette.colorText];
    [_viewStackDashboardIcons addArrangedSubview:icon];
  }
}

@end
