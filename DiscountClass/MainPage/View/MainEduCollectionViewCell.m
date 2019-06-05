//
//  MainEduCollectionViewCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/9.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "MainEduCollectionViewCell.h"
#import "ThirdLibsHeader.h"

@implementation MainEduCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.image = [[UIImageView alloc]initWithFrame:self.contentView.frame];
        self.image.image = [UIImage imageNamed:@"testEduLogo"];
        [self.contentView addSubview:self.image];
        
    }
    return self;
}

@end
