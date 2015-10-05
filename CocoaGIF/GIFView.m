//
//  GIFView.m
//  CocoaGif
//
//  Copyright (c) 2013 WenBi. All rights reserved.
//

#import "GIFView.h"

@interface GIFView ()

@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, assign) NSUInteger frameIndex;
@property(nonatomic, assign, getter = isAnimating) BOOL animating;

@end

@implementation GIFView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.imageView];
}

- (void)setSource:(GIFSource *)source
{
	_source = source;
	_frameIndex = 0;
	[self startAnimating];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	self.imageView.frame = self.bounds;
}

#pragma mark - Gif Play Control

- (void)startAnimating
{
	if (![self isAnimating]) {
		[self setAnimating:YES];
		[self displayNextImage];
	}
}

- (void)stopAnimating
{
	if ([self isAnimating]) {
		[self setAnimating:NO];
		if (_timer && _timer.isValid) {
			[_timer invalidate];
		}
		self.timer = nil;
	}
}

- (void)displayNextImage
{
	if (_frameIndex == self.source.frameCount) {
		_frameIndex = 0;
	}
	GIFFrame *frame = [self.source frameAtIndex:_frameIndex++];
	self.imageView.image = frame.image;
	self.timer = [NSTimer scheduledTimerWithTimeInterval:frame.delayTime target:self selector:@selector(displayNextImage) userInfo:nil repeats:NO];
}

@end
