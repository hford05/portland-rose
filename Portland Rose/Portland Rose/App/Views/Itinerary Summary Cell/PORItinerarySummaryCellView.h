//
//  PORItinerarySummaryCellView.h
//  Portland Rose
//
//  Created by Hunter Ford on 11/04/2018.
//  Copyright © 2018 Useless Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PORItinerary.h"
#import "PORItinerarySummaryView.h"
#import "PORPalette.h"


IB_DESIGNABLE

@protocol PORItinerarySummaryCellViewDelegate

- (void) didSelectItineraryAtIndex: (NSUInteger) index;

@end

@interface PORItinerarySummaryCellView : UITableViewCell

// Table cell delegate
@property id <PORItinerarySummaryCellViewDelegate> delegate;
/// Table cell index
@property NSUInteger index;
/// Itinerary
@property (nonatomic) PORItinerary * itinerary;
// Itinerary summary view
@property PORItinerarySummaryView * viewItinerarySummary;


@end
