//
//  ViewController.m
//  CocoaGIF
//
//  Created by wenbi on 15/10/5.
//  Copyright © 2015年 vimkoo. All rights reserved.
//

#import "ViewController.h"
#import <CocoaGIF/GIFSource.h>
#import <CocoaGIF/GIFView.h>

@interface ViewController ()

@property(nonatomic, strong) IBOutlet GIFView *gifView;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"20148114315183804" ofType:@"gif"];
    GIFSource *source = [[GIFSource alloc] initWithContentsOfFile:path];
    self.gifView.source = source;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
