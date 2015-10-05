//
//  GIFSource.m
//  CocoaGif
//
//  Copyright (c) 2013 WenBi. All rights reserved.
//

#import "GIFSource.h"
#import "GIFMutableFrame.h"
#import <ImageIO/ImageIO.h>

@interface GIFSource ()

@property(nonatomic, strong) NSMutableArray *frames;

@end

@implementation GIFSource

- (id)initWithContentsOfFile:(NSString *)path
{
	NSData *data = [NSData dataWithContentsOfFile:path];
	if (data) {
		self = [self initWithData:data];
	}
	else {
		self = nil;
	}
	return self;
}

- (id)initWithData:(NSData *)data
{
	self = [super init];
	if (self) {
		CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
		if (source) {

			size_t count = CGImageSourceGetCount(source);
			
			self.frames = [NSMutableArray arrayWithCapacity:count];
			
			for (NSInteger i = 0; i < count; ++i) {
				[self iterateSource:source index:i];
			}
			
			CFRelease(source);
		}
	}
	return self;
}

- (void)iterateSource:(CGImageSourceRef)source index:(NSUInteger)index
{
	GIFMutableFrame *frame = [[GIFMutableFrame alloc] init];
	
	CGImageRef image = CGImageSourceCreateImageAtIndex(source, index, NULL);
	if (image) {
		frame.image = [UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
		CFRelease(image);
	}
	
	CFDictionaryRef properties = CGImageSourceCopyPropertiesAtIndex(source, index, NULL);
	if (properties) {
		CFDictionaryRef gifDictionary = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
		CFStringRef delayTime = CFDictionaryGetValue(gifDictionary, kCGImagePropertyGIFDelayTime);
		frame.delayTime = [((__bridge NSString *)delayTime) floatValue];
		CFRelease(properties);
	}
	
	[self.frames addObject:frame];
	
}

- (NSUInteger)frameCount
{
	return self.frames.count;
}

- (GIFFrame *)frameAtIndex:(NSUInteger)index
{
	return [self.frames objectAtIndex:index];
}

@end
