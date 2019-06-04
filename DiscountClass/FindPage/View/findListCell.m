//
//  findListCell.m
//  DiscountClass
//
//  Created by Cary on 2019/5/7.
//  Copyright © 2019 Cary. All rights reserved.
//

#import "findListCell.h"
#import "ThirdLibsHeader.h"

@implementation findListCell

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
            make.right.equalTo(self.mas_right).offset(-17);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(160);
            make.height.mas_equalTo(90);
           // make.bottom.equalTo(self.contentView.mas_bottom).offset(12);
        }];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#515151"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.text = @"涨知识：人类首张黑洞照片问世！";
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.picImg.mas_top);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.right.equalTo(self.picImg.mas_left).offset(-20);
        }];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.text = @"2019年5月10日";
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(24);
            make.left.equalTo(self.contentView.mas_left).offset(17);
            make.width.mas_equalTo(150);
            make.bottom.equalTo(self.picImg.mas_bottom);
        }];
      
    }
    return self;
}


@end
