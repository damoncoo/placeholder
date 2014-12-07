//
//  UITextView+PlaceHolder.h
//  beiliao
//
//  Created by BeiliaoIOSDev on 14/11/6.
//  Copyright (c) 2014年 wangchen. All rights reserved.
//


#import <UIKit/UIKit.h>
typedef void (^FrameChangeBlock)(CGRect rect);

@interface UITextView (PlaceHolder)

-(void)setPlaceHolderString:(NSString *)placeHolder;

-(void)setTextViewHeight:(int)max  minus:(int)minus  frameChange:(FrameChangeBlock)block;

@end
