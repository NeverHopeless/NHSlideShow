//
//  UIView+NHExtension.h
//  NHAutoCompleteTextBox
//
//  Created by Shahan on 14/12/2014.
//  Copyright (c) 2014 Shahan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NHExtension)
{
    
}

-(void)setX:(CGFloat)x;
-(void)setY:(CGFloat)y;
-(void)setHeight:(CGFloat)height;
-(void)setWidth:(CGFloat)width;
-(void)setXNextToView:(UIView *)refView;
-(void)setYNextToView:(UIView *)refView;
-(CGFloat)xLocation;
-(CGFloat)yLocation;
-(CGFloat)width;
-(CGFloat)height;
-(void)setSize:(CGSize)size;
-(CGSize)getSize;

@end
