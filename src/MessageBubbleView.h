//
//  MessageBubbleView.h
//  ImageBubble
//
//  Created by Richard Kirby on 3/14/13.
//  Copyright (c) 2013 Kirby. All rights reserved.
//

@interface MessageBubbleView : UIView

typedef enum
{
    MessageBubbleViewTailDirectionRight = 0,
    MessageBubbleViewTailDirectionLeft = 1
} MessageBubbleViewTailDirection;

- (id)initWithText:(NSString *) text
         withColor:(UIColor *) color
withHighlightColor:(UIColor *) highlightColor
 withTailDirection:(MessageBubbleViewTailDirection) tailDirection;

- (id) initWithImage:(UIImage *) image
   withTailDirection:(MessageBubbleViewTailDirection) tailDirection
              atSize:(CGSize) size;

@end
