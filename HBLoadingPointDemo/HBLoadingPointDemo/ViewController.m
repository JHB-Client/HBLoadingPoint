//
//  ViewController.m
//  HBLoadingPointDemo
//
//  Created by admin on 2019/11/25.
//  Copyright © 2019 admin. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "HBLoadingPointView.h"
@interface ViewController ()
@property (nonatomic, strong) HBLoadingPointView *loadingPointView;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) NSArray *pointStrArr;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL start;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.pointStrArr = @[@"", @".", @"..", @"..."];
    
    [self startAnimation];
}

- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTextColor)];
        _displayLink.preferredFramesPerSecond = 2;
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}


-(void)updateTextColor{
    NSLog(@"------");
    
    self.loadingPointView.text = [NSString stringWithFormat:@"加载中%@", self.pointStrArr[self.index % 4]];
    self.index++;
}


- (void)startAnimation{
    self.displayLink.paused = NO;
}

- (void)stopAnimation{
   self.displayLink.paused = YES;
   [self.displayLink invalidate];
   self.displayLink = nil;
}
  

- (HBLoadingPointView *)loadingPointView {
    if (!_loadingPointView) {
        _loadingPointView = [HBLoadingPointView new];
        _loadingPointView.backgroundColor = [UIColor greenColor];
        _loadingPointView.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:_loadingPointView];
        [_loadingPointView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(100, 50));
        }];
    }
    
    return _loadingPointView;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.start == true ? [self stopAnimation] : [self startAnimation];
    self.start = !self.start;
}

@end
