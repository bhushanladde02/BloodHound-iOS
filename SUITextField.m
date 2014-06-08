//
//  SUITextField.m
//  BloodHound
//
//  Created by William Grey on 6/7/14.
//  Copyright (c) 2014 Small Emperor. All rights reserved.
//

#import "SUITextField.h"

@implementation SUITextField
@synthesize paddingTop, paddingBottom, paddingLeft, paddingRight;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.paddingRight   = 10;
        self.paddingLeft    = 10;
        self.paddingTop     = 5;
        self.paddingBottom  = 5;
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 5, bounds.origin.y + 8,
                      bounds.size.width - 20, bounds.size.height - 16);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
