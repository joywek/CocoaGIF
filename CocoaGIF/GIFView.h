//
//  GIFView.h
//  CocoaGif
//
//  Copyright (c) 2013 WenBi. All rights reserved.
//

#import "GIFSource.h"

@interface GIFView : UIView

@property(nonatomic, strong) GIFSource *source;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

@end
