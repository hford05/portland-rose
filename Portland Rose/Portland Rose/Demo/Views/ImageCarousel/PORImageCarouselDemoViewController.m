//
//  PORImageCarouselDemoViewController.m
//  Portland Rose
//
//  Created by Hunter Ford on 09/04/2018.
//  Copyright © 2018 Useless Corporation. All rights reserved.
//

#import "PORImageCarouselDemoViewController.h"

/// Names of demo images
static NSString * const NAMES_IMAGES = @"image-lg-0,image-lg-1,image-lg-2";

@interface PORImageCarouselDemoViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewContainerCarousel;
@property PORImageCarouselView * viewImageCarousel;
@end

@implementation PORImageCarouselDemoViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  _viewImageCarousel = self.childViewControllers.firstObject;
  [self loadImages];
}

- (void) loadImages {
  NSArray * names;
  NSMutableArray * imgs;
  
  names = [NAMES_IMAGES componentsSeparatedByString:@","];
  imgs = [[NSMutableArray alloc] init];
  
  for (NSString * name in names){
    [imgs addObject: [UIImage imageNamed:name]];
  }
  
  [_viewImageCarousel setImages: imgs];
}

@end