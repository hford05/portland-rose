//
//  PORLabeledIconView.h
//  Portland Rose
//
//  Created by Hunter Ford on 12/04/2018.
//  Copyright © 2018 Useless Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PORPalette.h"
#import "PORTypeLibrary.h"

IB_DESIGNABLE

@interface PORLabeledIconView : UIView

@property IBInspectable UIColor * color;
@property (nonatomic) IBInspectable NSString * text;
@property IBInspectable UIImage * icon;
@property IBInspectable CGFloat spacingStack;
@property UIFont * font;

@end