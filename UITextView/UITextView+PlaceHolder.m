//
//  UITextView+PlaceHolder.m
//  beiliao
//
//  Created by BeiliaoIOSDev on 14/11/6.
//  Copyright (c) 2014年 wangchen. All rights reserved.
//

#import "UITextView+PlaceHolder.h"
#import <objc/runtime.h>

static char lableChar;

static char maxHeightChar;
static char minHeightChar;
static char charBlock;

@implementation UITextView (PlaceHolder)

-(void)setPlaceHolderString:(NSString *)placeHolder {
    self.font = [UIFont systemFontOfSize:16];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                selector:@selector(textChange:)
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];
    UILabel *placeLabel;
    placeLabel = [[UILabel alloc]init];
    placeLabel.backgroundColor = [UIColor clearColor];
    placeLabel.text = placeHolder;
    placeLabel.textColor = [UIColor blackColor];
    [self addSubview:placeLabel];
    
    objc_setAssociatedObject(self, &lableChar, placeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setTextViewHeight:(int)max  minus:(int)minus  frameChange:(FrameChangeBlock)block
{
//    [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(textViewContentChanged:)
//                                                 name:UITextViewTextDidChangeNotification object:self];
    objc_setAssociatedObject(self, &maxHeightChar, [NSNumber numberWithInt:max], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &minHeightChar, [NSNumber numberWithInt:minus], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &charBlock, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)textChange:(NSNotification *)notification {
    
    UILabel *placeLabel = objc_getAssociatedObject(self, &lableChar);
    NSObject * obj = notification.object;
    if (obj == self)
    {
        if ([self.text isEqualToString:@""] || self.text == nil)  {
            placeLabel.hidden = NO;
        }
        else  {
            placeLabel.hidden = YES;
        }
        
        [self textViewContentChanged];
    }
}
-(void)textViewContentChanged{
    
    FrameChangeBlock block = objc_getAssociatedObject(self, &charBlock);
    if (!block) return;

    
    NSString *content = self.text;
    
    float h  = [content sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
    
    NSNumber *max = objc_getAssociatedObject(self, &maxHeightChar);
    NSNumber *min = objc_getAssociatedObject(self, &minHeightChar);
    
    CGRect rect = self.frame;
//    CGFloat h = self.contentSize.height;
    
    if (h > [max intValue]) {
        rect.size.height = [max intValue];
    }
    else if (h < [min intValue]) {
        rect.size.height = [min intValue];
    }
    else {
        rect.size.height =  h;
    }
    
    NSLog(@"caculated height = %f",h);
    NSLog(@"actual height = %f",rect.size.height);
    NSLog(@"contentsize height = %f",self.contentSize.height);
    NSLog(@"contentOffSet height = %f",self.contentOffset.y);
    
  
    block(rect);
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
//                       change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"contentSize"]) {
//        
//        NSNumber *max = objc_getAssociatedObject(self, &maxHeightChar);
//        NSNumber *min = objc_getAssociatedObject(self, &minHeightChar);
//        
//        CGRect rect = self.frame;
//        CGFloat h = self.contentSize.height;
//        
//        if (h > [max intValue]) {
//            rect.size.height = [max intValue];
//        }
//        else if (h < [min intValue]) {
//            rect.size.height = [min intValue];
//        }
//        else {
//            rect.size.height =  h;
//        }
//        
//        FrameChangeBlock block = objc_getAssociatedObject(self, &charBlock);
//        block(rect);
//    }
//}

-(void)layoutSubviews
{
    UILabel *placeLabel = objc_getAssociatedObject(self, &lableChar);
    placeLabel.frame = CGRectMake(10, 8, self.frame.size.width - 10 *2, 20);
}
-(void)removeFromSuperview
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self removeObserver:self forKeyPath:@"contentSize"];
    
    UILabel *placeLabel = objc_getAssociatedObject(self, &lableChar);
    [placeLabel removeFromSuperview];
     placeLabel = nil ;
    objc_setAssociatedObject(self, &lableChar, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &lableChar, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &lableChar, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [super removeFromSuperview];
}

@end
