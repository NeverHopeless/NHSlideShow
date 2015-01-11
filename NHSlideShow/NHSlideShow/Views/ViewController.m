
//
//  ViewController.m
//  NHSlideShow
//
//  Created by Shahan on 04/01/2015.
//  Copyright (c) 2015 Shahan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     // Do any additional setup after loading the view, typically from a nib.
     /* Design by code */
     /*
        In order to use this tutorial to run the below commented code, you should first disconnect
        `slideShow` outlet from IB and set `Hidden = YES`
      */
     /*
     slideShow = [[NHSlideShow alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.height, kScreenSize.width)];
    [slideShow setDelayInTransition:0.5f];
    [slideShow setSlidesDelegate:self];
    [slideShow slidesWithImages:[self getImages]];
    [self.view addSubview:slideShow];
    [self.view sendSubviewToBack:slideShow];
     */

     /* ----     -----*/
     /* ----  OR -----*/
     /* ----     -----*/
     /* Design from UI and attached via IBOutlet */
     [slideShow setDelayInTransition:2.0f];
     [slideShow setDelegate:self];
     [slideShow slidesWithImages:[self getImages]];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [slideShow doneLayout];
    [slideShow start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper functions

-(NSArray *)getImages
{
     NSMutableArray *mArr = [[NSMutableArray alloc] init];
    
    [mArr addObject:[UIImage imageNamed:@"1.png"]];
    [mArr addObject:[UIImage imageNamed:@"2.png"]];
    [mArr addObject:[UIImage imageNamed:@"3.png"]];
    
    [mArr addObject:[UIImage imageNamed:@"4.png"]];
    [mArr addObject:[UIImage imageNamed:@"5.png"]];
    [mArr addObject:[UIImage imageNamed:@"6.png"]];
    
    [mArr addObject:[UIImage imageNamed:@"7.png"]];
    [mArr addObject:[UIImage imageNamed:@"8.png"]];
    [mArr addObject:[UIImage imageNamed:@"9.png"]];
    
    [mArr addObject:[UIImage imageNamed:@"10.png"]];    
    
     return mArr;
}

#pragma mark - Event Handlers

-(IBAction)valueChanged:(UISegmentedControl *)segmentedControl
{
    NSLog(@"ValueChanged...");
    
    switch (segmentedControl.selectedSegmentIndex)
    {
        case NHSlideShowModeSwipeLeft:
        {
            [slideShow setSlideShowMode:NHSlideShowModeSwipeLeft];
        }break;
        case NHSlideShowModeFade:
        {
            [slideShow setSlideShowMode:NHSlideShowModeFade];
        }break;
        case NHSlideShowModeScale:
        {
            [slideShow setSlideShowMode:NHSlideShowModeScale];
        }break;
        case NHSlideShowModeWindow:
        {
            [slideShow setSlideShowMode:NHSlideShowModeWindow];
        }break;
        case NHSlideShowModeRandom:
        {
            [slideShow setSlideShowMode:NHSlideShowModeRandom];
        }break;
        default:
            break;
    }  
}

-(IBAction)modeValueChanged:(UISegmentedControl *)segmentedControl
{
    NSLog(@"ValueChanged...");
    
    switch (segmentedControl.selectedSegmentIndex)
    {
        case 0:
        {
            [slideShow start];
        }break;
        case 1:
        {
            [slideShow stop];
        }break;
        default:
            break;
    }
}

-(IBAction)btnNext_Click:(id)sender
{
    [slideShow moveNext];
}

-(IBAction)btnPrevious_Click:(id)sender
{
    [slideShow movePrevious];
}

#pragma mark - NHSlideShow delegate functions


-(NSInteger)slideShowShouldStartFromSlide:(NHSlideShow *)slideShow
{
    return 0; // Pass the starting slide number
}

-(void)slideShow:(NHSlideShow *)slideShow didChangedSlideAtIndex:(NSInteger)slideIndex
{
    // TODO: You can display your image description using this delegate.
    NSLog(@"didChangedSlideAtIndex : %ld", (long)slideIndex);
}

@end
