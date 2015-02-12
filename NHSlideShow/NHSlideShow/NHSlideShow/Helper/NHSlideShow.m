//
//  NHSlideShow.m
//  NHSlideShow
//
//  Created by Shahan on 04/01/2015.
//  Copyright (c) 2015 Shahan. All rights reserved.
//

#import "NHSlideShow.h"

@interface NHSlideShow()
{
    
}

@property (nonatomic, assign, readwrite) BOOL isAnimating;
@property (nonatomic, assign, readwrite) NSInteger currentImageCounter;

@end

@implementation NHSlideShow

@synthesize delayInTransition;
@synthesize slideShowMode;
@synthesize delegate;
@synthesize currentImageCounter;
@synthesize isAnimating;

#pragma mark - Initializatiion functions

-(id)init
{
    if(self = [super init])
    {
        if(CGRectEqualToRect(self.frame, CGRectZero))
        {
             NSLog(@"You should either initialize your view with `initWithFrame` or `initWithCoder`");
            [self setFrame:CGRectMake(0, 0, kScreenSize.width, 100)];
        }
        
        [self initialize];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self initialize];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self initialize];
    }
    
    return self;
}

-(void)initialize
{
     animationOptions = UIViewAnimationOptionCurveLinear;
     contentMode = UIViewContentModeScaleToFill;
     currentImageCounter = 0;
     currentImageCounter = 0;
     otherImageCounter = currentImageCounter + 1;
    
     slideShowMode = NHSlideShowModeSwipeLeft;
    
     currentImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
     nextImg    = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [nextImg setXNextToView:currentImg];
    
    [currentImg setContentMode:contentMode];
    [nextImg    setContentMode:contentMode];
    
    [self setClipsToBounds:YES];
    [self setAutoresizesSubviews:YES];
}

-(void)doneLayout
{
    [currentImg setSize:[self getSize]];
    [nextImg setSize:[self getSize]];
    
    [currentImg setNeedsDisplayInRect:self.frame];
    [nextImg    setNeedsDisplayInRect:self.frame];
    [nextImg setXNextToView:currentImg];
    
    if(![self.subviews containsObject:currentImg])
    {
        [self addSubview:currentImg];
    }
    
    if(![self.subviews containsObject:nextImg])
    {
        [self addSubview:nextImg];
    }
}

-(void)slidesWithImages:(NSArray *)slides
{
    NSAssert(slides != nil || [slides count] > 0, @"Before begining, one should provide collection to display");
    
    collection = slides;
    
    for (id obj in collection)
    {
        if(![obj isKindOfClass:[UIImage class]])
        {
            NSAssert(FALSE, @"Collection must be of type UIImage");
        }
    }
    
     // Override slide number if provided by user.
     if([delegate respondsToSelector:@selector(slideShowShouldStartFromSlide:)])
     {
          currentImageCounter = [delegate slideShowShouldStartFromSlide:self];
          currentImageCounter =  MIN(MAX(currentImageCounter, 0), [collection count] - 1);
     }
    
    [self updateSlidesForcurrentImageCounterNumber];
}

#pragma mark - Helper functions

-(void)start
{
     animationTimer = [NSTimer scheduledTimerWithTimeInterval:kAnimationDuration + delayInTransition
                                                       target:self
                                                     selector:@selector(beginAnimation)
                                                     userInfo:nil
                                                      repeats:YES];
}

-(void)stop
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginAnimation) object:nil];
    
    [animationTimer invalidate];
     animationTimer = nil;
    
    [nextImg setImage:nil];
}

-(void)updateSlidesForcurrentImageCounterNumber
{
    [currentImg setImage:[collection objectAtIndex:currentImageCounter]];
    [nextImg    setImage:[collection objectAtIndex:otherImageCounter]];
}

-(void)beginAnimation
{
    if(!self.isAnimating) // This check is needed for iOS8, due to a bug in NSTimer.
    {
        [self setUserInteractionEnabled:NO];
         self.isAnimating = YES;
        
        [nextImg setImage:[collection objectAtIndex:otherImageCounter]];
        
        switch (self.slideShowMode)
        {
            case NHSlideShowModeSwipeLeft:
            {
                [self runSwipeLeftAnimation];
            }break;
            case NHSlideShowModeFade:
            {
                [self runFadeAnimation];
            }break;
            case NHSlideShowModeScale:
            {
                [self runScaleAnimation];
            }break;
            case NHSlideShowModeWindow:
            {
                [self runWindowsAnimation];
            }break;
            case NHSlideShowModeRandom:
            {
                [self runRandomAnimation];
            }break;
            default:
            {
                
            }break;
        }
    }
}

-(void)moveNext
{
    if(!isAnimating)
    {
         direction = NHSlideShowDirectionForward;
        
        [self movePointerToNext];
        
         NSLog(@"Moved next. Current slide : %ld", (long)currentImageCounter);
        
        [currentImg setImage:[collection objectAtIndex:currentImageCounter]];
        [nextImg    setImage:[collection objectAtIndex:otherImageCounter]];
    }
    else
    {
         NSLog(@"Can not move next slide, an action is already in progress");
    }
}

-(void)movePrevious
{
    if(!isAnimating)
    {
         direction = NHSlideShowDirectionBackward;
        
        [self movePointerToPrevious];
        
         NSLog(@"Moved previous. Current slide : %ld", (long)currentImageCounter);
        
        [currentImg setImage:[collection objectAtIndex:currentImageCounter]];
        [nextImg    setImage:[collection objectAtIndex:otherImageCounter]];
    }
    else
    {
        NSLog(@"Can not move to previous, an action is already in progress");
    }
}

-(void)movePointerToNext
{
    currentImageCounter += 1;
    
    if(currentImageCounter > [collection count] - 1)
    {
        currentImageCounter = 0;
    }
 
    if(currentImageCounter == [collection count] - 1)
    {
        otherImageCounter = 0;
    }
    else
    {
        otherImageCounter = currentImageCounter + 1;
    }
}

-(void)movePointerToPrevious
{
    currentImageCounter -= 1;
    
    if(currentImageCounter < 0)
    {
        currentImageCounter = [collection count] - 1;
    }
    
    if(currentImageCounter > 0)
    {
        otherImageCounter = currentImageCounter - 1;
    }
    else
    {
        otherImageCounter = [collection count] - 1;
    }
}

-(void)slideChanged
{
     direction = NHSlideShowDirectionForward;
    [self movePointerToNext];
    
    NSLog(@"Presenting slide : %ld", (long)currentImageCounter);
    
    if([delegate respondsToSelector:@selector(slideShow:didChangedSlideAtIndex:)])
    {
        [delegate slideShow:self didChangedSlideAtIndex:currentImageCounter];
    }
}

-(void)runSwipeLeftAnimation
{
    [currentImg setAlpha:1.0f];
    [nextImg    setAlpha:1.0f];
    [nextImg setX:currentImg.width];
    [UIView animateWithDuration:kAnimationDuration * 0.5
                          delay:0.0f
                        options:animationOptions
                     animations:^{
                         [currentImg setX: -currentImg.width];
                         [nextImg    setX:0];
                     }
                     completion:^(BOOL finished)
     {
         // Next image is now the current image
         [currentImg setImage:nextImg.image];
         
         // Move pointer to next slide
         [self slideChanged];
         
         // Relocate the position which was changed due to animation
         [currentImg setX:0];
         [nextImg setXNextToView:currentImg];
         
         // Prepare the next image
         [nextImg setImage:[collection objectAtIndex:otherImageCounter]];
         
         [self setUserInteractionEnabled:YES];
          self.isAnimating = NO;
     }
     ];
    
}

-(void)runFadeAnimation
{
    [nextImg setAlpha:0.0f];
    [nextImg setX:currentImg.xLocation];
    [UIView animateWithDuration:kAnimationDuration
                          delay:0.0f
                        options:animationOptions
                     animations:^{
                         [currentImg setAlpha:0.0f];
                         [nextImg    setAlpha:1.0f];
                     }
                     completion:^(BOOL finished)
     {
         // Next image is now the current image
         [currentImg setImage:nextImg.image];
         
         // Move pointer to next slide
         [self slideChanged];
         
         // Relocate the position which was changed due to animation
         [currentImg setX:0];
         [nextImg setXNextToView:currentImg];
         
         [currentImg setAlpha:1.0f];
         [nextImg    setAlpha:0.0f];
         
         // Prepare the next image
         [nextImg setImage:[collection objectAtIndex:otherImageCounter]];
         [self setUserInteractionEnabled:YES];
         self.isAnimating = NO;
     }
     ];
    
}

-(void)runScaleAnimation
{
    [currentImg setAlpha:1.0f];
    [nextImg    setAlpha:0.0f];
    [nextImg setX:currentImg.xLocation];
    [self sendSubviewToBack:nextImg];
    
    [UIView animateWithDuration:kAnimationDuration * 0.25
                          delay:0.0f
                        options:animationOptions
                     animations:^{
                         [currentImg setTransform:CGAffineTransformMakeScale(9.0f, 9.0f)];
                         [currentImg setAlpha:0.0f];
                         [nextImg    setAlpha:0.5f];
                     }
                     completion:^(BOOL finished)
     {
         [nextImg    setAlpha:1.0f];
         [UIView animateWithDuration:kAnimationDuration * 0.20
                               delay:0.0f
                             options:animationOptions
                          animations:^{
                              [nextImg    setTransform:CGAffineTransformMakeScale(1.0f, 1.0f)];
                              [currentImg setTransform:CGAffineTransformMakeScale(1.0f, 1.0f)];
                          }
                          completion:^(BOOL finished)
          {
              // Next image is now the current image
              [currentImg setImage:nextImg.image];
              
              // Move pointer to next slide
              [self slideChanged];
              
              // Relocate the position which was changed due to animation
              [currentImg setX:0.0f];
              [nextImg    setX:0.0f];
              
              [currentImg setAlpha:1.0f];
              [nextImg    setAlpha:0.0f];
              
              // Prepare the next image
              [nextImg setImage:[collection objectAtIndex:otherImageCounter]];
              [self setUserInteractionEnabled:YES];
              
              [self sendSubviewToBack:currentImg];
               self.isAnimating = NO;
          }
          ];
     }
     ];
    
}

-(void)runWindowsAnimation
{
    [nextImg setAlpha:1.0f];
    [currentImg setAlpha:0.0f];
    [self sendSubviewToBack:nextImg];
    
     __block UIView *vwLeft  = [[UIView alloc] initWithFrame:CGRectMake(currentImg.xLocation, currentImg.yLocation, currentImg.width / 2, currentImg.height)];
     __block UIView *vwRight = [[UIView alloc] initWithFrame:CGRectMake(currentImg.xLocation + currentImg.width / 2, currentImg.yLocation, currentImg.width / 2, currentImg.height)];
    
     __block UIImageView *imgLeft  = [[UIImageView alloc] initWithFrame:currentImg.frame];
    [imgLeft setContentMode:contentMode];
    [imgLeft setImage:currentImg.image];
    
     __block UIImageView *imgRight = [[UIImageView alloc] initWithFrame:currentImg.frame];
    [imgRight setContentMode:contentMode];
    [imgRight setImage:currentImg.image];
    [imgRight setX:-currentImg.width / 2];
    
    [vwLeft  addSubview:imgLeft];
    [vwRight addSubview:imgRight];
    
    [vwLeft  setClipsToBounds:YES];
    [vwRight setClipsToBounds:YES];
    
    [self addSubview:vwLeft];
    [self addSubview:vwRight];
    
    [nextImg setX:currentImg.xLocation];
    [UIView animateWithDuration:kAnimationDuration
                          delay:0.0f
                        options:animationOptions
                     animations:^{
                         [vwLeft  setX:-currentImg.width / 2];
                         [vwRight setX:currentImg.width];
                     }
                     completion:^(BOOL finished)
     {
         [imgLeft  removeFromSuperview]; imgLeft = nil;
         [imgRight removeFromSuperview]; imgRight = nil;
         
         [vwLeft   removeFromSuperview]; vwLeft = nil;
         [vwRight  removeFromSuperview]; vwRight = nil;
         
         // Next image is now the current image
         [currentImg setImage:nextImg.image];
         
         // Move pointer to next slide
         [self slideChanged];
         
         // Relocate the position which was changed due to animation
         [currentImg setX:0];
         [nextImg setXNextToView:currentImg];
         
         [currentImg setAlpha:1.0f];
         [nextImg    setAlpha:0.0f];
         
         // Prepare the next image
         [nextImg setImage:[collection objectAtIndex:otherImageCounter]];
         [self setUserInteractionEnabled:YES];
          self.isAnimating = NO;
     }
     ];
}

-(void)runRandomAnimation
{
    NHSlideShowMode mode = arc4random() % 4; // Random should be the last option, so each option can be covered.
    switch (mode)
    {
        case NHSlideShowModeSwipeLeft:
        {
            [self runSwipeLeftAnimation];
        }break;
        case NHSlideShowModeFade:
        {
            [self runFadeAnimation];
        }break;
        case NHSlideShowModeScale:
        {
            [self runScaleAnimation];
        }break;
        case NHSlideShowModeWindow:
        {
            [self runWindowsAnimation];
        }break;
        default:
        {
            
        }break;
    }
}

@end
