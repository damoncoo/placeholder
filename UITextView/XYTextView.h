//
//  XYTextView.h
//  UITextView
//
//  Created by BeiliaoIOSDev on 14/12/4.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FrameChangeBlock)(CGRect rect);

@interface XYTextView : UITextView

-(void)setPlaceHolderString:(NSString *)placeHolder;

-(void)setTextViewHeight:(NSInteger)max  minus:(NSInteger)minus  frameChange:(FrameChangeBlock)block;

@property (nonatomic, strong)   UILabel *placeholderLabel;
@property (nonatomic, readwrite) UIColor *placeholderColor;
@property (nonatomic, readwrite) NSString *placeholder;

@end
