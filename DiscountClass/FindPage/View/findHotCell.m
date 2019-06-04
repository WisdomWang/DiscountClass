//
//  findHotCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/7.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "findHotCell.h"
#import "ThirdLibsHeader.h"

@implementation findHotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _picImg = [[UIImageView alloc]init];
        _picImg.image = [UIImage imageNamed:@"mainBanner"];
        [self.contentView addSubview:_picImg];
        [_picImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(17);
            make.right.equalTo(self.mas_right).offset(-17);
            make.height.mas_equalTo(125);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        
    }
    return self;
}

@end
