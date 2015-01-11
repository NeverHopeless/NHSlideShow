//
//  ViewController.h
//  NHSlideShow
//
//  Created by Shahan on 04/01/2015.
//  Copyright (c) 2015 Shahan. All rights reserved.
//

#import "NHMainHeader.h"

@interface ViewController : UIViewController<NHSlideShowDelegate>
{
    IBOutlet NHSlideShow *slideShow;
    UISegmentedControl *segmentedCtrl;
}


-(IBAction)btnNext_Click:(id)sender;
-(IBAction)btnPrevious_Click:(id)sender;

@end
