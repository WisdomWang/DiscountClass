//
//  PayOrderTwoCell.m
//  DiscountClass
//
//  Created by Cary on 2019/6/4.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "PayOrderTwoCell.h"
#import "ThirdLibsHeader.h"

@implementation PayOrderTwoCell

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
        
        _bgView = [UIImageView new];
        _bgView.userInteractionEnabled = YES;
        _bgView.image = [UIImage imageNamed:@"bankBgGray"];
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.width.mas_equalTo(xScreenWidth -33);
        }];
        
        _iconImage = [[UIImageView alloc]init];
        _iconImage.image = [UIImage imageNamed:@"changeBankIcon"];
        [_bgView addSubview:_iconImage];
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView.mas_left).offset(20);
            make.centerY.equalTo(self.bgView.mas_centerY);
        }];
        _label = [UILabel new];
        _label.text = @"更换银行卡";
        _label.textColor = [UIColor colorWithHexString:@"#9e9e9e"];
        _label.font = [UIFont systemFontOfSize:15];
        [_bgView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImage.mas_centerY);
            make.left.equalTo(self.iconImage.mas_right).offset(8);
        }];
        
    }
    
    return self;
}


@end
