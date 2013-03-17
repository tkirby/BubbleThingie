//
//  MessageBubbleView.m
//  ImageBubble
//
//  Created by Richard Kirby on 3/14/13.
//  Copyright (c) 2013 Kirby. All rights reserved.
//

#import "TextMessageBubbleViewButton.h"
#import "UIImage+Utils.h"

#define IMAGE_INSETS UIEdgeInsetsMake(13, 13, 13, 21)

#define RIGHT_CONTENT_INSETS UIEdgeInsetsMake(8, 13, 8, 21)
#define LEFT_CONTENT_INSETS UIEdgeInsetsMake(8, 21, 8, 13)

static const float kBubbleTextSize = 14.0f;

@interface TextMessageBubbleViewButton ()

@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (nonatomic, retain) UIImageView *bubbleImageView;
@property (nonatomic, assign) CGFloat maxWidth;

@end

@implementation TextMessageBubbleViewButton

- (id)initWithText:(NSString *) text
         withColor:(UIColor *) color
withHighlightColor:(UIColor *) highlightColor
 withTailDirection:(MessageBubbleViewButtonTailDirection)tailDirection
          maxWidth:(CGFloat) maxWidth
{
    if (self = [super init])
    {
        UIEdgeInsets imageInsets = IMAGE_INSETS;
        UIImageOrientation bubbleOrientation;
        _maxWidth = maxWidth;
        
        if (tailDirection == MessageBubbleViewButtonTailDirectionLeft)
        {
            self.contentInsets = LEFT_CONTENT_INSETS;
            bubbleOrientation =UIImageOrientationUpMirrored;
        }
        else
        {
            self.contentInsets = RIGHT_CONTENT_INSETS;
            bubbleOrientation =UIImageOrientationUp;
        }
        
        UIImage *coloredImage = [[UIImage imageNamed:@"ImageBubbleMask~iphone"] maskWithColor:color];
        
        UIImage *coloredBackgroundImage = [[UIImage imageNamed:@"ImageBubbleMask~iphone"] maskWithColor:highlightColor];
        
        UIImage *backgroundImageNormal = [[UIImage imageWithCGImage:coloredImage.CGImage
                                                           scale:1.0 orientation: bubbleOrientation] resizableImageWithCapInsets:imageInsets resizingMode:UIImageResizingModeStretch];
        
        UIImage *backgroundImageHightlighted = [[UIImage imageWithCGImage:coloredBackgroundImage.CGImage
                                                           scale:1.0 orientation: bubbleOrientation] resizableImageWithCapInsets:imageInsets resizingMode:UIImageResizingModeStretch];
        
        // bubble overlay image
        UIImage *bubbleImage = [[UIImage imageWithCGImage:[UIImage imageNamed:@"ImageBubble~iphone"].CGImage
                                                    scale:1.0 orientation: bubbleOrientation] resizableImageWithCapInsets:imageInsets resizingMode:UIImageResizingModeStretch];
        
        _bubbleImageView = [[UIImageView alloc] initWithImage:bubbleImage];
        
        [self autoresizesSubviews];
        
        [self setTitle:text forState:UIControlStateNormal];
        [self setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont systemFontOfSize:kBubbleTextSize];
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.backgroundColor = UIColor.clearColor;
        [self setBackgroundImage:backgroundImageNormal forState:UIControlStateNormal];
        [self setBackgroundImage:backgroundImageHightlighted forState:UIControlStateHighlighted];
        
        _bubbleImageView.frame = self.frame;
        [self addSubview:_bubbleImageView];
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}

UIEdgeInsets UIEdgeInsetsNegate(UIEdgeInsets insets)
{
    return UIEdgeInsetsMake(-insets.top , -insets.left, -insets.bottom, -insets.right );
}


- (void) sizeToFit
{
    [super sizeToFit];
    self.frame = UIEdgeInsetsInsetRect(self.frame, UIEdgeInsetsNegate(self.contentInsets));
    self.bubbleImageView.frame = self.bounds;

}

- (CGSize)sizeThatFits:(CGSize)size
{
    return self.textSize;
}

- (CGSize) textSize
{
    CGFloat widthWithInsetsApplied = self.maxWidth - self.contentInsets.left - self.contentInsets.right;
    
    
    return [self.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:kBubbleTextSize]
                                           constrainedToSize:CGSizeMake(widthWithInsetsApplied, INT_MAX)
                                               lineBreakMode:NSLineBreakByWordWrapping];
}

@end
