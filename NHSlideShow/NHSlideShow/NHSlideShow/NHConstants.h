//
//  NHConstants.h
//  NHAutoCompleteTextBox
//
//  Created by Shahan on 02/01/2015.
//  Copyright (c) 2015 Shahan. All rights reserved.
//

#ifndef NHAutoCompleteTextBox_NHConstants_h
#define NHAutoCompleteTextBox_NHConstants_h

#define kAnimationDuration     1.0f
#define kScreen                [[UIScreen mainScreen] bounds] 
#define kScreenSize            [[UIScreen mainScreen] bounds].size

typedef enum
{
    NHSlideShowModeSwipeLeft,
    NHSlideShowModeFade,
    NHSlideShowModeScale,
    NHSlideShowModeWindow,
    NHSlideShowModeRandom
    
} NHSlideShowMode;

typedef enum
{
    NHSlideShowDirectionForward,
    NHSlideShowDirectionBackward
    
} NHSlideShowDirection;


#endif
