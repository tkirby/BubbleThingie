//
//  ImageBubbleViewController.m
//  ImageBubble
//
//  Created by Richard Kirby on 3/12/13.
//  Copyright (c) 2013 Kirby. All rights reserved.
//

#import "ImageBubbleViewController.h"
#import "TextMessageBubbleViewButton.h"
#import "MessageBubbleView.h"

#define TWO_THIRDS_OF_PORTRAIT_WIDTH (UIScreen.mainScreen.bounds.size.width * 0.6666667f)
#define MARGIN 10.0f
#define IMAGE_SIZE CGSizeMake(100,100)


#define GRAY_TEXT_BUBBLE_COLOR [UIColor colorWithRed:0.866667 green:0.866667 blue:0.866667 alpha:1]
#define GREEN_TEXT_BUBBLE_COLOR [UIColor colorWithRed:0.439216 green:0.854902 blue:0.223529 alpha:1]
#define BLUE_TEXT_HIGHLIGHT_COLOR [UIColor colorWithRed:0.270588 green:0.545098 blue:1.000000 alpha:1]

@implementation ImageBubbleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Bubble view button
    
    TextMessageBubbleViewButton *haikuTextMessageBubbleViewButton =
    [[TextMessageBubbleViewButton alloc] initWithText:@"throughout the money,\nPanda attached finally.\nBelgium stops pulling."
                                        withColor:GRAY_TEXT_BUBBLE_COLOR
                               withHighlightColor:BLUE_TEXT_HIGHLIGHT_COLOR 
                                withTailDirection:MessageBubbleViewButtonTailDirectionLeft
     maxWidth:TWO_THIRDS_OF_PORTRAIT_WIDTH];
    
    [haikuTextMessageBubbleViewButton sizeToFit];
    
    [self.view addSubview:haikuTextMessageBubbleViewButton];
    
    haikuTextMessageBubbleViewButton.frame = CGRectMake(MARGIN, MARGIN, haikuTextMessageBubbleViewButton.frame.size.width, haikuTextMessageBubbleViewButton.frame.size.height);
    
    // Flower image bubble view
    
    MessageBubbleView *flowerImageBubbleView =
    [[MessageBubbleView alloc] initWithImage:[UIImage imageNamed:@"flower"] withTailDirection:MessageBubbleViewTailDirectionLeft atSize:IMAGE_SIZE];
    
    [flowerImageBubbleView sizeToFit];
    flowerImageBubbleView.frame = CGRectMake(MARGIN, haikuTextMessageBubbleViewButton.frame.origin.y + haikuTextMessageBubbleViewButton.bounds.size.height + MARGIN, flowerImageBubbleView.frame.size.width, flowerImageBubbleView.frame.size.height);
    
    [self.view addSubview:flowerImageBubbleView];
    
    // Bubble view
    
    MessageBubbleView *haikuMessageBubbleView =
    [[MessageBubbleView alloc] initWithText:@"take chairs on sugar\nwhen princes hunt to loiter\nbecause crayons walk\n"
                                  withColor:GREEN_TEXT_BUBBLE_COLOR
                         withHighlightColor:BLUE_TEXT_HIGHLIGHT_COLOR
                          withTailDirection:MessageBubbleViewTailDirectionRight];
    
    [haikuMessageBubbleView sizeToFit];
    
    [self.view addSubview:haikuMessageBubbleView];
    haikuMessageBubbleView.frame = CGRectMake(self.view.frame.size.width - haikuMessageBubbleView.frame.size.width - MARGIN, flowerImageBubbleView.frame.origin.y + flowerImageBubbleView.bounds.size.height + MARGIN, haikuMessageBubbleView.frame.size.width, haikuMessageBubbleView.frame.size.height);

    // Person image bubble view
    
    MessageBubbleView *personImageBubbleView =
    [[MessageBubbleView alloc] initWithImage:[UIImage imageNamed:@"person"] withTailDirection:MessageBubbleViewTailDirectionRight atSize:IMAGE_SIZE];
    
    [personImageBubbleView sizeToFit];
    personImageBubbleView.backgroundColor = UIColor.clearColor;
    personImageBubbleView.frame = CGRectMake(self.view.frame.size.width - personImageBubbleView.frame.size.width - MARGIN, haikuMessageBubbleView.frame.origin.y + haikuMessageBubbleView.bounds.size.height + MARGIN, personImageBubbleView.frame.size.width, personImageBubbleView.frame.size.height);
    
    [self.view addSubview:personImageBubbleView];
}

@end
