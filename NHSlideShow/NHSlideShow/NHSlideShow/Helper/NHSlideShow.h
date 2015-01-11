//
//  NHSlideShow.h
//  NHSlideShow
//
//  Created by Shahan on 04/01/2015.
//  Copyright (c) 2015 Shahan. All rights reserved.
//

#import "NHConstants.h"
#import "UIView+NHExtension.h"

@class NHSlideShow;

@protocol NHSlideShowDelegate <NSObject>

-(NSInteger)slideShowShouldStartFromSlide:(NHSlideShow *)slideShow;
-(void)slideShow:(NHSlideShow *)slideShow didChangedSlideAtIndex:(NSInteger)slideIndex;

@end

@interface NHSlideShow : UIView
{
    NSArray *collection;
    UIViewAnimationOptions animationOptions;
    UIImageView *currentImg;
    UIImageView *nextImg;
    UIViewContentMode contentMode;
    
    NSTimer *animationTimer;
    NHSlideShowDirection direction;
    
    NSInteger currentImageCounter; // presented image counter.
    NSInteger otherImageCounter;   // next or previous image counter.
}

@property (nonatomic, assign, readonly) BOOL isAnimating;
@property (nonatomic, assign, readonly) NSInteger currentSlide;
@property (nonatomic, assign) CGFloat delayInTransition;
@property (nonatomic, assign) NHSlideShowMode slideShowMode;
@property (nonatomic, weak) id<NHSlideShowDelegate>delegate;

-(void)start;
-(void)stop;
-(void)moveNext;
-(void)movePrevious;
-(void)doneLayout;
-(void)slidesWithImages:(NSArray *)slides;

@end
