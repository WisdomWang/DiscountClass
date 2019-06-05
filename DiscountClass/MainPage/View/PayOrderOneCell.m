
//
//  PayOrderOneCell.m
//  DiscountClass
//
//  Created by Cary on 2019/6/3.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "PayOrderOneCell.h"
#import "ThirdLibsHeader.h"

@implementation PayOrderOneCell

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
        _bgView.image = [UIImage imageNamed:@"bankBg"];
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top).offset(24);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-16);
            make.width.mas_equalTo(xScreenWidth -33);
        }];
        
        _iconImage = [[UIImageView alloc]init];
        _iconImage.image = [UIImage imageNamed:@"smallUnionPayIcon"];
        [_bgView addSubview:_iconImage];
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView.mas_top).offset(20);
            make.left.equalTo(self.bgView.mas_left).offset(20);
        }];
        _label = [UILabel new];
        _label.text = @"中国工商银行";
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:15];
        [_bgView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImage.mas_centerY);
            make.left.equalTo(self.iconImage.mas_right).offset(8);
        }];
        
        _fastPayImg = [[UIImageView alloc]init];
        _fastPayImg.image = [UIImage imageNamed:@"FastPayIcon"];
        [self.contentView addSubview:_fastPayImg];
        [_fastPayImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImage.mas_centerY);
            make.left.equalTo(self.label.mas_right).offset(8);
        }];
        
        _detailLabel = [UILabel new];
        _detailLabel.text = @"****     ****     ****     7378";
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.font = [UIFont boldSystemFontOfSize:24];
        [_bgView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImage.mas_left);
            make.width.mas_equalTo(xScreenWidth-70);
            make.top.equalTo(self.iconImage.mas_bottom).offset(20);
            make.bottom.equalTo(self.bgView.mas_bottom).offset(-30);
        }];
        
    }
    
    return self;
}

- (void)setModel:(BankInfoModel *)model {

    _label.text = model.bankName;
    _detailLabel.text = model.accountNo;
    
}

@end
