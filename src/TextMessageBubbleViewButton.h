//
//  MessageBubbleView.h
//  ImageBubble
//
//  Created by Richard Kirby on 3/14/13.
//  Copyright (c) 2013 Kirby. All rights reserved.
//

@interface TextMessageBubbleViewButton : UIButton

typedef enum
{
    MessageBubbleViewButtonTailDirectionRight = 0,
    MessageBubbleViewButtonTailDirectionLeft = 1
} MessageBubbleViewButtonTailDirection;

- (id)initWithText:(NSString *) text
         withColor:(UIColor *) color
withHighlightColor:(UIColor *) highlightColor
 withTailDirection:(MessageBubbleViewButtonTailDirection)tailDirection
          maxWidth:(CGFloat) maxWidth;

@end
