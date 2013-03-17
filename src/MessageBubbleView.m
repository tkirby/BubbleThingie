//
//  MessageBubbleView.m
//  ImageBubble
//
//  Created by Richard Kirby on 3/14/13.
//  Copyright (c) 2013 Kirby. All rights reserved.
//

#import "MessageBubbleView.h"
#import "CopyLabel.h"
#import "UIImage+Utils.h"

#define IMAGE_INSETS UIEdgeInsetsMake(13, 13, 13, 21)

#define RIGHT_CONTENT_INSETS UIEdgeInsetsMake(8, 13, 8, 21)
#define LEFT_CONTENT_INSETS UIEdgeInsetsMake(8, 21, 8, 13)
#define RIGHT_CONTENT_OUTSETS UIEdgeInsetsMake(-8, -13, -8, -21)
#define LEFT_CONTENT_OUTSETS UIEdgeInsetsMake(-8, -21, -8, -13)

static const float kBubbleTextSize = 14.0f;

@interface MessageBubbleView () <CopyLabelDelegate>

@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (nonatomic, retain) UIImageView *bubbleImageView;
@property (nonatomic, retain) UIImageView *backgroundImageView;
@property (nonatomic, retain) UIImage *backgroundImageNormal;
@property (nonatomic, retain) UIImage *backgroundImageHighlighted;
@property (nonatomic, assign) CGSize imageSize;

@property (nonatomic, retain) CopyLabel *titleLabel;

@end

@implementation MessageBubbleView

- (id)initWithText:(NSString *) text
         withColor:(UIColor *) color
withHighlightColor:(UIColor *) highlightColor
  withTailDirection:(MessageBubbleViewTailDirection)tailDirection;
{
    if (self = [super init])
    {
        UIEdgeInsets imageInsets = IMAGE_INSETS;
        UIImageOrientation bubbleOrientation;
        
        if (tailDirection == MessageBubbleViewTailDirectionLeft)
        {
            _contentInsets = LEFT_CONTENT_INSETS;
            bubbleOrientation =UIImageOrientationUpMirrored;
        }
        else
        {
            _contentInsets = RIGHT_CONTENT_INSETS;
            bubbleOrientation =UIImageOrientationUp;
        }
        
        UIImage *coloredImage = [[UIImage imageNamed:@"ImageBubbleMask~iphone"] maskWithColor:color];
        
        UIImage *coloredBackgroundImage = [[UIImage imageNamed:@"ImageBubbleMask~iphone"] maskWithColor:highlightColor];
        
        _backgroundImageNormal = [[UIImage imageWithCGImage:coloredImage.CGImage
                                                           scale:1.0 orientation: bubbleOrientation] resizableImageWithCapInsets:imageInsets resizingMode:UIImageResizingModeStretch];
        
        _backgroundImageHighlighted = [[UIImage imageWithCGImage:coloredBackgroundImage.CGImage
                                                           scale:1.0 orientation: bubbleOrientation] resizableImageWithCapInsets:imageInsets resizingMode:UIImageResizingModeStretch];
        
        // bubble overlay image
        UIImage *bubbleImage = [[UIImage imageWithCGImage:[UIImage imageNamed:@"ImageBubble~iphone"].CGImage
                                                    scale:1.0 orientation: bubbleOrientation] resizableImageWithCapInsets:imageInsets resizingMode:UIImageResizingModeStretch];
        
        _bubbleImageView = [[UIImageView alloc] initWithImage:bubbleImage];
        _bubbleImageView.frame = self.frame;
        _bubbleImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        _titleLabel = [[CopyLabel alloc] init];
        _titleLabel.delegate = self;
        _titleLabel.text = text;
        _titleLabel.font = [UIFont systemFontOfSize:kBubbleTextSize];
        _titleLabel.textColor = UIColor.blackColor;
        
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.backgroundColor = UIColor.clearColor;
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:_backgroundImageNormal];
        _backgroundImageView.frame = self.bounds;
        _backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

        //[self setBackgroundImage:backgroundImageHightlighted forState:UIControlStateHighlighted];
        
        //self.contentEdgeInsets = contentInsets;
        self.titleLabel.preferredMaxLayoutWidth = 200.0f;
        

 
        [self addSubview:_backgroundImageView];
        [self addSubview:_titleLabel];
        [self addSubview:_bubbleImageView];
        [self autoresizesSubviews];
        self.backgroundColor = UIColor.clearColor;

    }
    return self;
}

#define TWO_THIRDS_OF_PORTRAIT_WIDTH (320.0f * 0.66f)

- (void) sizeToFit
{
    [super sizeToFit];
    
    if (self.titleLabel.text)
    {
        self.titleLabel.frame = CGRectMake(0,0, self.textSize.width, self.textSize.height);
        
        self.frame = UIEdgeInsetsInsetRect(CGRectMake(0,0, self.textSize.width, self.textSize.height), LEFT_CONTENT_OUTSETS);
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    if (self.titleLabel.text)
    {
        return self.textSize;
    }
    else
    {
        return self.imageSize;
    }
}

- (CGSize) textSize
{
    return [self.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:kBubbleTextSize]
                                           constrainedToSize:CGSizeMake(TWO_THIRDS_OF_PORTRAIT_WIDTH, INT_MAX)
                                               lineBreakMode:NSLineBreakByWordWrapping];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    if (self.titleLabel.text)
    {
        self.titleLabel.frame = CGRectMake(18, 8, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    }
}

- (id) initWithImage:(UIImage *)image
   withTailDirection:(MessageBubbleViewTailDirection) tailDirection
              atSize:(CGSize)size
{
    if (self = [super init])
    {
        self.imageSize = size;
        const UIEdgeInsets insets = UIEdgeInsetsMake(13, 13, 13, 21);
        
        const UIImageOrientation bubbleOrientation = tailDirection ? UIImageOrientationUpMirrored : UIImageOrientationUp;
        
        const UIImage *resizableMaskImage = [[UIImage imageWithCGImage:[UIImage imageNamed:@"ImageBubbleMask~iphone"].CGImage
                                                                 scale:1.0 orientation: bubbleOrientation] resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        
        const UIImage *maskImageDrawnToSize = [resizableMaskImage renderAtSize:size];
        
        // bubble overlay image
        UIImage *bubbleImage = [[UIImage imageWithCGImage:[UIImage imageNamed:@"ImageBubble~iphone"].CGImage
                                                    scale:1.0 orientation: bubbleOrientation] resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        
        UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:bubbleImage];
        
        // masked image
        UIImageView *maskedImageView = [[UIImageView alloc] initWithImage:
                                        [image maskWithImage: maskImageDrawnToSize]];
        
        bubbleImageView.frame = maskedImageView.bounds;
        [self addSubview:maskedImageView];
        [self addSubview:bubbleImageView];
    }
    
    return self;
}

-(void) didStartSelect
{
    self.backgroundImageView.image = self.backgroundImageHighlighted;
}

-(void) didEndSelect
{
    self.backgroundImageView.image = self.backgroundImageNormal;
}


@end
