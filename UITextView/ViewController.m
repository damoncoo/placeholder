//
//  ViewController.m
//  UITextView
//
//  Created by BeiliaoIOSDev on 14/12/3.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

//#define SLK
#if defined(SLK)

#define TEXTVIEW   SLKTextView
#else 
#define TEXTVIEW   XYTextView
#endif

#import "ViewController.h"
#import "XYTextView.h"

TEXTVIEW *_textView;

@interface ViewController ()

@end

@implementation ViewController

-(void)backSpace {
    NSString *inputString = _textView.text;
    NSRange range = _textView.selectedRange;
    
    NSString *beforeString=[inputString substringToIndex:range.location];
    NSString *afterString= [inputString  substringFromIndex:range.location];

    NSInteger stringLength = beforeString.length;
    
    if (stringLength >= 1) {
        NSString *   string = [beforeString stringByAppendingFormat:@"你好"];
        _textView.text = [NSString stringWithFormat:@"%@%@",string,afterString];
//        tv.selectedRange=NSMakeRange(string.length,0);
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(10, 200, 50, 50);
    [btn addTarget:self action:@selector(backSpace) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    _textView = [[TEXTVIEW alloc]init];
    _textView.placeholder = @"这里输入文字";
    _textView.scrollEnabled = YES;
    _textView.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 100);
    _textView.font = [UIFont systemFontOfSize:20];
    _textView.backgroundColor = [UIColor lightGrayColor];
    
    [_textView setTextViewHeight:150 minus:100 frameChange:^(CGRect rect) {
        
        [UIView animateWithDuration:0.2 animations:^{
            _textView.frame = rect;
        }];
        
//        [_textView setNeedsDisplay];
//        [_textView setNeedsLayout];
        
    }];
    [self.view addSubview:_textView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
