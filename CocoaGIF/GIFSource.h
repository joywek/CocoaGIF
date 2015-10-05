//
//  GIFSource.h
//  CocoaGif
//
//  Copyright (c) 2013 WenBi. All rights reserved.
//

#import "GIFFrame.h"

@interface GIFSource : NSObject

- (id)initWithContentsOfFile:(NSString *)path;
- (id)initWithData:(NSData *)data;

- (NSUInteger)frameCount;
- (GIFFrame *)frameAtIndex:(NSUInteger)index;

@end
